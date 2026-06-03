package com.ruoyi.web.controller.competition;

import java.util.List;
import java.util.Map;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestBody;
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
import com.ruoyi.system.domain.CompTeam;
import com.ruoyi.system.domain.CompTeamMember;
import com.ruoyi.system.domain.UserNotification;
import com.ruoyi.system.service.ICompTeamService;
import com.ruoyi.system.service.ITeamInvitationRecordService;
import io.swagger.v3.oas.annotations.Operation;
import io.swagger.v3.oas.annotations.Parameter;
import io.swagger.v3.oas.annotations.tags.Tag;

@Tag(name = "组队竞赛")
@RestController
@RequestMapping("/student/team")
public class TeamController extends BaseController
{
    @Autowired
    private ICompTeamService compTeamService;

    @Autowired
    private ITeamInvitationRecordService invitationRecordService;

    @Operation(summary = "创建队伍")
    @PostMapping("/create/{competitionId}")
    public AjaxResult createTeam(
            @Parameter(description = "竞赛ID", required = true)
            @PathVariable Long competitionId,
            @Parameter(description = "队名", required = true)
            @RequestParam String teamName)
    {
        LoginUser loginUser = SecurityUtils.getLoginUser();
        if (loginUser == null)
        {
            return error("请先登录");
        }
        if (teamName == null || teamName.trim().isEmpty())
        {
            return error("队名不能为空");
        }
        try
        {
            CompTeam team = compTeamService.createTeam(competitionId, teamName.trim(),
                    loginUser.getUserId(), loginUser.getUsername());
            return success(team);
        }
        catch (Exception e)
        {
            return error(e.getMessage());
        }
    }

    @Operation(summary = "加入队伍")
    @PostMapping("/join/{competitionId}")
    public AjaxResult joinTeam(
            @Parameter(description = "竞赛ID", required = true)
            @PathVariable Long competitionId,
            @Parameter(description = "邀请码", required = true)
            @RequestBody Map<String, String> body)
    {
        LoginUser loginUser = SecurityUtils.getLoginUser();
        if (loginUser == null)
        {
            return error("请先登录");
        }
        String inviteCode = body.get("inviteCode");
        if (inviteCode == null || inviteCode.trim().isEmpty())
        {
            return error("邀请码不能为空");
        }
        try
        {
            CompTeam team = compTeamService.joinTeam(competitionId, inviteCode.trim().toUpperCase(),
                    loginUser.getUserId(), loginUser.getUsername(),
                    loginUser.getUser().getNickName());
            return success(team);
        }
        catch (Exception e)
        {
            return error(e.getMessage());
        }
    }

    @Operation(summary = "退出队伍")
    @DeleteMapping("/{teamId}/leave")
    public AjaxResult leaveTeam(
            @Parameter(description = "队伍ID", required = true)
            @PathVariable Long teamId)
    {
        LoginUser loginUser = SecurityUtils.getLoginUser();
        if (loginUser == null)
        {
            return error("请先登录");
        }
        try
        {
            CompTeam team = compTeamService.getTeamById(teamId);
            String leaverName = loginUser.getUsername();
            compTeamService.leaveTeam(teamId, loginUser.getUserId());

            UserNotification notification = new UserNotification();
            notification.setUserId(team.getLeaderId());
            notification.setBizType("team");
            notification.setBizId(teamId);
            notification.setTitle("队员退出队伍");
            notification.setContent("队员 " + leaverName + " 已退出你的队伍【" + team.getTeamName() + "】");
            AsyncManager.me().execute(AsyncFactory.recordNotification(notification));

            return success("退出成功");
        }
        catch (Exception e)
        {
            return error(e.getMessage());
        }
    }

    @Operation(summary = "踢出队员（仅队长）")
    @DeleteMapping("/{teamId}/kick/{memberId}")
    public AjaxResult kickMember(
            @Parameter(description = "队伍ID", required = true)
            @PathVariable Long teamId,
            @Parameter(description = "队员ID", required = true)
            @PathVariable Long memberId)
    {
        LoginUser loginUser = SecurityUtils.getLoginUser();
        if (loginUser == null)
        {
            return error("请先登录");
        }
        try
        {
            CompTeam team = compTeamService.getTeamById(teamId);
            compTeamService.kickMember(teamId, loginUser.getUserId(), memberId);

            UserNotification notification = new UserNotification();
            notification.setUserId(memberId);
            notification.setBizType("team");
            notification.setBizId(teamId);
            notification.setTitle("你已被移出队伍");
            notification.setContent("你已被队长移出队伍【" + team.getTeamName() + "】");
            AsyncManager.me().execute(AsyncFactory.recordNotification(notification));

            return success("踢出成功");
        }
        catch (Exception e)
        {
            return error(e.getMessage());
        }
    }

    @Operation(summary = "解散队伍")
    @DeleteMapping("/{teamId}/disband")
    public AjaxResult disbandTeam(
            @Parameter(description = "队伍ID", required = true)
            @PathVariable Long teamId)
    {
        LoginUser loginUser = SecurityUtils.getLoginUser();
        if (loginUser == null)
        {
            return error("请先登录");
        }
        try
        {
            CompTeam team = compTeamService.getTeamById(teamId);
            List<CompTeamMember> members = compTeamService.getTeamMembers(teamId);
            Long leaderId = loginUser.getUserId();
            compTeamService.disbandTeam(teamId, leaderId);

            for (CompTeamMember m : members)
            {
                if (m.getUserId().equals(leaderId)) continue;
                UserNotification notification = new UserNotification();
                notification.setUserId(m.getUserId());
                notification.setBizType("team");
                notification.setBizId(teamId);
                notification.setTitle("队伍已解散");
                notification.setContent("你的队伍【" + team.getTeamName() + "】已被队长解散");
                AsyncManager.me().execute(AsyncFactory.recordNotification(notification));
            }

            return success("解散成功");
        }
        catch (Exception e)
        {
            return error(e.getMessage());
        }
    }

    @Operation(summary = "移交队长")
    @PostMapping("/{teamId}/transfer/{memberId}")
    public AjaxResult transferLeader(
            @Parameter(description = "队伍ID", required = true)
            @PathVariable Long teamId,
            @Parameter(description = "新队长用户ID", required = true)
            @PathVariable Long memberId)
    {
        LoginUser loginUser = SecurityUtils.getLoginUser();
        if (loginUser == null)
        {
            return error("请先登录");
        }
        try
        {
            compTeamService.transferLeader(teamId, loginUser.getUserId(), memberId);
            return success("移交成功");
        }
        catch (Exception e)
        {
            return error(e.getMessage());
        }
    }

    @Anonymous
    @Operation(summary = "查询公开招募的队伍列表")
    @GetMapping("/public")
    public AjaxResult getPublicTeams(
            @Parameter(description = "竞赛ID（可选筛选）")
            @RequestParam(required = false) Long competitionId)
    {
        List<CompTeam> list = compTeamService.getPublicTeams(competitionId);
        return success(list);
    }

    @Operation(summary = "切换队伍公开状态")
    @PutMapping("/{teamId}/toggle-public")
    public AjaxResult togglePublic(
            @Parameter(description = "队伍ID", required = true)
            @PathVariable Long teamId,
            @Parameter(description = "是否公开", required = true)
            @RequestParam boolean isPublic)
    {
        LoginUser loginUser = SecurityUtils.getLoginUser();
        if (loginUser == null)
        {
            return error("请先登录");
        }
        try
        {
            compTeamService.togglePublic(teamId, loginUser.getUserId(), isPublic);
            return success(isPublic ? "已公开招募" : "已关闭公开招募");
        }
        catch (Exception e)
        {
            return error(e.getMessage());
        }
    }

    @Operation(summary = "更新队伍所需技能")
    @PutMapping("/{teamId}/skills")
    public AjaxResult updateSkills(
            @Parameter(description = "队伍ID", required = true)
            @PathVariable Long teamId,
            @Parameter(description = "所需技能（逗号分隔）", required = true)
            @RequestParam String skills)
    {
        LoginUser loginUser = SecurityUtils.getLoginUser();
        if (loginUser == null)
        {
            return error("请先登录");
        }
        try
        {
            compTeamService.updateNeededSkills(teamId, loginUser.getUserId(), skills);
            return success("技能已更新");
        }
        catch (Exception e)
        {
            return error(e.getMessage());
        }
    }

    @Operation(summary = "查询某竞赛下我的队伍")
    @GetMapping("/my-team/{competitionId}")
    public AjaxResult getMyTeam(
            @Parameter(description = "竞赛ID", required = true)
            @PathVariable Long competitionId)
    {
        LoginUser loginUser = SecurityUtils.getLoginUser();
        if (loginUser == null)
        {
            return error("请先登录");
        }
        CompTeam team = compTeamService.getMyTeamByCompetitionId(competitionId, loginUser.getUserId());
        return success(team);
    }

    @Operation(summary = "查询我所在的所有队伍")
    @GetMapping("/my-teams")
    public AjaxResult getMyTeams()
    {
        LoginUser loginUser = SecurityUtils.getLoginUser();
        if (loginUser == null)
        {
            return error("请先登录");
        }
        List<CompTeam> list = compTeamService.getMyTeams(loginUser.getUserId());
        return success(list);
    }

    @Operation(summary = "查询队伍成员列表")
    @GetMapping("/{teamId}/members")
    public AjaxResult getTeamMembers(
            @Parameter(description = "队伍ID", required = true)
            @PathVariable Long teamId)
    {
        List<CompTeamMember> list = compTeamService.getTeamMembers(teamId);
        return success(list);
    }

    @Operation(summary = "提交队伍审核")
    @PutMapping("/{teamId}/submit")
    public AjaxResult submitTeam(
            @Parameter(description = "队伍ID", required = true)
            @PathVariable Long teamId)
    {
        LoginUser loginUser = SecurityUtils.getLoginUser();
        if (loginUser == null)
        {
            return error("请先登录");
        }
        compTeamService.submitTeam(teamId, loginUser.getUserId());
        return success("队伍已提交审核");
    }

    @Operation(summary = "同意队伍邀请")
    @PutMapping("/invite/accept/{recordId}")
    public AjaxResult acceptInvitation(
            @Parameter(description = "邀请记录ID", required = true)
            @PathVariable Long recordId)
    {
        LoginUser loginUser = SecurityUtils.getLoginUser();
        if (loginUser == null)
        {
            return error("请先登录");
        }
        try
        {
            invitationRecordService.acceptInvitation(recordId, loginUser.getUserId());
            return success("已加入队伍");
        }
        catch (Exception e)
        {
            return error(e.getMessage());
        }
    }

    @Operation(summary = "拒绝队伍邀请")
    @PutMapping("/invite/reject/{recordId}")
    public AjaxResult rejectInvitation(
            @Parameter(description = "邀请记录ID", required = true)
            @PathVariable Long recordId)
    {
        LoginUser loginUser = SecurityUtils.getLoginUser();
        if (loginUser == null)
        {
            return error("请先登录");
        }
        try
        {
            invitationRecordService.rejectInvitation(recordId, loginUser.getUserId());
            return success("已拒绝邀请");
        }
        catch (Exception e)
        {
            return error(e.getMessage());
        }
    }
}
