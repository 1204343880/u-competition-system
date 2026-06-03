package com.ruoyi.web.controller.competition;

import java.util.Arrays;
import java.util.List;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;
import com.ruoyi.common.annotation.Anonymous;
import com.ruoyi.common.core.controller.BaseController;
import com.ruoyi.common.core.domain.AjaxResult;
import com.ruoyi.common.core.domain.model.LoginUser;
import com.ruoyi.common.utils.SecurityUtils;
import com.ruoyi.framework.manager.AsyncManager;
import com.ruoyi.framework.manager.factory.AsyncFactory;
import com.ruoyi.framework.web.service.TokenService;
import com.ruoyi.system.domain.TeamInvitationRecord;
import com.ruoyi.system.domain.UserNotification;
import com.ruoyi.system.service.ISysUserService;
import com.ruoyi.system.service.ITeamInvitationRecordService;
import com.ruoyi.system.mapper.SysUserMapper;
import io.swagger.v3.oas.annotations.Operation;
import io.swagger.v3.oas.annotations.Parameter;
import io.swagger.v3.oas.annotations.tags.Tag;
import com.ruoyi.common.core.domain.entity.SysUser;

@Tag(name = "人才市场")
@RestController
@RequestMapping("/student/market")
public class MarketController extends BaseController
{
    @Autowired
    private ISysUserService userService;

    @Autowired
    private SysUserMapper sysUserMapper;

    @Autowired
    private TokenService tokenService;

    @Autowired
    private ITeamInvitationRecordService invitationRecordService;

    @Anonymous
    @Operation(summary = "查询人才市场列表")
    @GetMapping("/list")
    public AjaxResult list(
            @Parameter(description = "技能筛选（逗号分隔）")
            @RequestParam(required = false) String skills)
    {
        SysUser param = new SysUser();
        param.setShowInMarket("1");
        if (skills != null && !skills.isEmpty()) {
            param.getParams().put("skillList", Arrays.asList(skills.split(",")));
        }
        List<SysUser> list = userService.selectUserList(param);
        list.forEach(u -> {
            u.setPassword(null);
        });
        return success(list);
    }

    @Operation(summary = "从市场邀请用户加入队伍")
    @PostMapping("/invite/{userId}")
    public AjaxResult inviteToTeam(
            @Parameter(description = "被邀请用户ID", required = true)
            @PathVariable Long userId,
            @Parameter(description = "队伍ID", required = true)
            @RequestParam Long teamId)
    {
        LoginUser loginUser = SecurityUtils.getLoginUser();
        if (loginUser == null)
        {
            return error("请先登录");
        }
        try
        {
            TeamInvitationRecord record = invitationRecordService.inviteFromMarket(
                    teamId, loginUser.getUserId(), userId);

            UserNotification notification = new UserNotification();
            notification.setUserId(userId);
            notification.setBizType("invitation");
            notification.setBizId(record.getId());
            notification.setTitle("收到组队邀请");
            notification.setContent("用户 " + loginUser.getUsername() + " 邀请你加入队伍");
            AsyncManager.me().execute(AsyncFactory.recordNotification(notification));

            return success(record);
        }
        catch (Exception e)
        {
            return error(e.getMessage());
        }
    }

    @Operation(summary = "查询我收到的队伍邀请")
    @GetMapping("/invitations")
    public AjaxResult getMyInvitations()
    {
        LoginUser loginUser = SecurityUtils.getLoginUser();
        if (loginUser == null)
        {
            return error("请先登录");
        }
        return success(invitationRecordService.getMyInvitations(loginUser.getUserId()));
    }

    @Operation(summary = "切换人才市场可见性")
    @PutMapping("/toggle")
    public AjaxResult toggle()
    {
        LoginUser loginUser = SecurityUtils.getLoginUser();
        if (loginUser == null)
        {
            return error("请先登录");
        }
        SysUser user = loginUser.getUser();
        String newVal = "1".equals(user.getShowInMarket()) ? "0" : "1";
        sysUserMapper.updateShowInMarket(user.getUserId(), newVal);
        user.setShowInMarket(newVal);
        tokenService.setLoginUser(loginUser);
        return success("1".equals(newVal) ? "已公开到人才市场" : "已关闭人才市场展示");
    }
}
