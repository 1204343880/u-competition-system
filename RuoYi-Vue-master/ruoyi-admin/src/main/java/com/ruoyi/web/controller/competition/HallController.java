package com.ruoyi.web.controller.competition;

import java.util.Date;
import java.util.List;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;
import com.ruoyi.common.annotation.Anonymous;
import com.ruoyi.common.core.controller.BaseController;
import com.ruoyi.common.core.domain.AjaxResult;
import com.ruoyi.common.core.domain.model.LoginUser;
import com.ruoyi.common.core.page.TableDataInfo;
import com.ruoyi.common.utils.SecurityUtils;
import com.ruoyi.system.domain.Competition;
import com.ruoyi.system.domain.CompetitionApply;
import com.ruoyi.system.service.ICompetitionApplyService;
import com.ruoyi.system.service.ICompetitionService;
import io.swagger.v3.oas.annotations.Operation;
import io.swagger.v3.oas.annotations.Parameter;
import io.swagger.v3.oas.annotations.tags.Tag;

@Tag(name = "竞赛大厅")
@RestController
@RequestMapping("/student/hall")
public class HallController extends BaseController
{
    @Autowired
    private ICompetitionService competitionService;

    @Autowired
    private ICompetitionApplyService competitionApplyService;

    @Anonymous
    @Operation(summary = "分页查询竞赛列表")
    @GetMapping("/list")
    public TableDataInfo list(
            @Parameter(description = "竞赛名称（模糊查询）")
            @RequestParam(required = false) String competitionName,
            @Parameter(description = "竞赛状态（0报名中 1进行中 2已结束）")
            @RequestParam(required = false) String status,
            @Parameter(description = "学科分类code列表，逗号分隔")
            @RequestParam(required = false) String categories,
            @Parameter(description = "竞赛级别")
            @RequestParam(required = false) String competitionLevel,
            @Parameter(description = "排序（apply/start/update/view）")
            @RequestParam(required = false) String sortBy)
    {
        Competition competition = new Competition();
        competition.setCompetitionName(competitionName);
        competition.setStatus(status);
        competition.setCompetitionLevel(competitionLevel);
        if (categories != null && !categories.isEmpty()) {
            competition.getParams().put("categoryList", categories.split(","));
        }
        if (sortBy != null) {
            competition.getParams().put("sortBy", sortBy);
        }
        startPage();
        List<Competition> list = competitionService.selectCompetitionList(competition);
        return getDataTable(list);
    }

    @Anonymous
    @Operation(summary = "竞赛详情查询")
    @GetMapping("/{competitionId}")
    public AjaxResult getInfo(
            @Parameter(description = "竞赛ID", required = true)
            @PathVariable Long competitionId)
    {
        Competition competition = competitionService.selectCompetitionById(competitionId);
        if (competition == null)
        {
            return error("竞赛不存在");
        }
        return success(competition);
    }

    @Operation(summary = "竞赛报名")
    @PostMapping("/{competitionId}/apply")
    public AjaxResult apply(
            @Parameter(description = "竞赛ID", required = true)
            @PathVariable Long competitionId)
    {
        LoginUser loginUser = SecurityUtils.getLoginUser();
        if (loginUser == null)
        {
            return error("请先登录");
        }
        Long userId = loginUser.getUserId();
        String userName = loginUser.getUsername();

        Competition competition = competitionService.selectCompetitionById(competitionId);
        if (competition == null)
        {
            return error("竞赛不存在");
        }
        if (!"0".equals(competition.getStatus()))
        {
            return error("当前竞赛不在报名阶段");
        }

        CompetitionApply existApply = competitionApplyService.selectApplyByCompetitionIdAndUserId(competitionId, userId);
        if (existApply != null)
        {
            return error("您已报名该竞赛，请勿重复报名");
        }

        if (competition.getMaxParticipants() != null && competition.getMaxParticipants() > 0)
        {
            if (!competitionService.incrementParticipants(competitionId))
            {
                return error("该竞赛名额已满");
            }
        }

        CompetitionApply apply = new CompetitionApply();
        apply.setCompetitionId(competitionId);
        apply.setUserId(userId);
        apply.setUserName(userName);
        apply.setNickName(loginUser.getUser().getNickName());
        apply.setApplyTime(new Date());
        apply.setAuditStatus("0");
        apply.setCreateBy(userName);

        competitionApplyService.insertApply(apply);
        return success("报名成功");
    }

    @Operation(summary = "查询我的报名列表")
    @GetMapping("/my-applies")
    public AjaxResult myApplies()
    {
        LoginUser loginUser = SecurityUtils.getLoginUser();
        if (loginUser == null)
        {
            return error("请先登录");
        }
        List<CompetitionApply> list = competitionApplyService.selectApplyListByUserId(loginUser.getUserId());
        return success(list);
    }

    @Operation(summary = "取消竞赛报名")
    @DeleteMapping("/{competitionId}/apply")
    public AjaxResult cancelApply(
            @Parameter(description = "竞赛ID", required = true)
            @PathVariable Long competitionId)
    {
        LoginUser loginUser = SecurityUtils.getLoginUser();
        if (loginUser == null)
        {
            return error("请先登录");
        }
        Long userId = loginUser.getUserId();

        Competition competition = competitionService.selectCompetitionById(competitionId);
        if (competition == null)
        {
            return error("竞赛不存在");
        }
        if (!"0".equals(competition.getStatus()))
        {
            return error("当前竞赛不在报名阶段，无法取消");
        }

        CompetitionApply existApply = competitionApplyService.selectApplyByCompetitionIdAndUserId(competitionId, userId);
        if (existApply == null)
        {
            return error("您未报名该竞赛");
        }
        competitionApplyService.cancelApply(existApply.getApplyId());
        competitionService.decrementParticipants(competitionId);
        return success("取消报名成功");
    }
}
