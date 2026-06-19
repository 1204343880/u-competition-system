package com.ruoyi.web.controller.competition;

import java.nio.charset.StandardCharsets;
import java.security.MessageDigest;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestHeader;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;
import com.ruoyi.common.annotation.Anonymous;
import com.ruoyi.common.core.domain.AjaxResult;
import com.ruoyi.common.core.domain.entity.SysUser;
import com.ruoyi.system.domain.CompetitionApply;
import com.ruoyi.system.domain.CompetitionResult;
import com.ruoyi.system.mapper.CompetitionExperienceMapper;
import com.ruoyi.system.mapper.CompetitionMapper;
import com.ruoyi.system.mapper.CompetitionRetrospectMapper;
import com.ruoyi.system.service.ICompetitionApplyService;
import com.ruoyi.system.service.ICompetitionResultService;
import com.ruoyi.system.service.ISysUserService;

@Anonymous
@RestController
@RequestMapping("/internal/agent")
public class InternalAgentController
{
    @Value("${agent.shared-secret}")
    private String sharedSecret;

    @Autowired
    private ISysUserService userService;

    @Autowired
    private ICompetitionApplyService applyService;

    @Autowired
    private ICompetitionResultService resultService;

    @Autowired
    private CompetitionMapper competitionMapper;

    @Autowired
    private CompetitionRetrospectMapper retrospectMapper;

    @Autowired
    private CompetitionExperienceMapper experienceMapper;

    @GetMapping("/users/{userId}/profile")
    public AjaxResult profile(@RequestHeader(value = "X-Agent-Key", required = false) String agentKey,
            @PathVariable Long userId)
    {
        AjaxResult denied = authorize(agentKey);
        if (denied != null)
        {
            return denied;
        }

        SysUser user = userService.selectUserById(userId);
        if (user == null || "2".equals(user.getDelFlag()))
        {
            return AjaxResult.error(404, "User not found");
        }

        List<String> history = new ArrayList<>();
        for (CompetitionApply apply : applyService.selectApplyListByUserId(userId))
        {
            if ("1".equals(apply.getAuditStatus()))
            {
                history.add("Registered: " + value(apply.getCompetitionName()));
            }
        }
        for (CompetitionResult result : resultService.selectResultsByUserId(userId))
        {
            history.add("Result: " + value(result.getCompetitionName()) + " - " + value(result.getAwardLevel()));
        }

        Map<String, Object> profile = new LinkedHashMap<>();
        profile.put("user_id", user.getUserId());
        profile.put("name", user.getNickName() == null ? user.getUserName() : user.getNickName());
        profile.put("grade", value(user.getGrade()));
        profile.put("major", user.getDept() == null ? "" : value(user.getDept().getDeptName()));
        profile.put("skills", splitTags(user.getSkillTags()));
        profile.put("interests", List.of());
        profile.put("history", history);
        return AjaxResult.success(profile);
    }

    @GetMapping("/competitions/search")
    public AjaxResult competitions(@RequestHeader(value = "X-Agent-Key", required = false) String agentKey,
            @RequestParam(value = "q", required = false, defaultValue = "") String query)
    {
        AjaxResult denied = authorize(agentKey);
        return denied == null ? AjaxResult.success(competitionMapper.searchForAgent(query.trim())) : denied;
    }

    @GetMapping("/retrospects/search")
    public AjaxResult retrospects(@RequestHeader(value = "X-Agent-Key", required = false) String agentKey,
            @RequestParam(value = "q", required = false, defaultValue = "") String query)
    {
        AjaxResult denied = authorize(agentKey);
        return denied == null ? AjaxResult.success(retrospectMapper.searchForAgent(query.trim())) : denied;
    }

    @GetMapping("/experiences/search")
    public AjaxResult experiences(@RequestHeader(value = "X-Agent-Key", required = false) String agentKey,
            @RequestParam(value = "q", required = false, defaultValue = "") String query)
    {
        AjaxResult denied = authorize(agentKey);
        return denied == null ? AjaxResult.success(experienceMapper.searchForAgent(query.trim())) : denied;
    }

    private AjaxResult authorize(String agentKey)
    {
        if (agentKey == null || sharedSecret == null || sharedSecret.isBlank())
        {
            return AjaxResult.error(401, "Invalid agent credentials");
        }
        byte[] expected = sharedSecret.getBytes(StandardCharsets.UTF_8);
        byte[] actual = agentKey.getBytes(StandardCharsets.UTF_8);
        return MessageDigest.isEqual(expected, actual) ? null : AjaxResult.error(401, "Invalid agent credentials");
    }

    private List<String> splitTags(String tags)
    {
        if (tags == null || tags.isBlank())
        {
            return List.of();
        }
        return Arrays.stream(tags.split("[,，]"))
                .map(String::trim)
                .filter(tag -> !tag.isEmpty())
                .toList();
    }

    private String value(String text)
    {
        return text == null ? "" : text;
    }
}
