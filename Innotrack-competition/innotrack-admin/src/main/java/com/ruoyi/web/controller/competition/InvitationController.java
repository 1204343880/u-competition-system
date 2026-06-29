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
import org.springframework.web.bind.annotation.RestController;
import com.ruoyi.common.core.controller.BaseController;
import com.ruoyi.common.core.domain.AjaxResult;
import com.ruoyi.common.core.domain.entity.SysUser;
import com.ruoyi.common.core.domain.model.LoginUser;
import com.ruoyi.common.utils.SecurityUtils;
import com.ruoyi.framework.mq.RabbitMqProducer;
import com.ruoyi.system.domain.CompTeam;
import com.ruoyi.system.domain.TeamTeacherInvitation;
import com.ruoyi.system.domain.UserNotification;
import com.ruoyi.system.service.ICompTeamService;
import com.ruoyi.system.service.ISysUserService;
import com.ruoyi.system.service.ITeamTeacherInvitationService;
import io.swagger.v3.oas.annotations.Operation;
import io.swagger.v3.oas.annotations.tags.Tag;

@Tag(name = "教师邀请")
@RestController
public class InvitationController extends BaseController
{
    @Autowired
    private ITeamTeacherInvitationService invitationService;

    @Autowired
    private ICompTeamService teamService;

    @Autowired
    private ISysUserService userService;

    @Autowired
    private RabbitMqProducer rabbitMqProducer;

    @Operation(summary = "学生-邀请教师指导")
    @PostMapping("/student/team/{teamId}/invite-teacher")
    public AjaxResult inviteTeacher(
            @PathVariable Long teamId,
            @RequestBody TeamTeacherInvitation invitation)
    {
        LoginUser loginUser = SecurityUtils.getLoginUser();
        if (loginUser == null)
        {
            return error("请先登录");
        }
        if (invitation == null || invitation.getTeacherId() == null)
        {
            return error("请选择指导教师");
        }

        CompTeam team = teamService.getTeamById(teamId);
        if (team == null)
        {
            return error("队伍不存在");
        }
        if (!loginUser.getUserId().equals(team.getLeaderId()))
        {
            return error("仅队长可以邀请指导教师");
        }

        SysUser teacher = userService.selectUserById(invitation.getTeacherId());
        if (teacher == null || "2".equals(teacher.getDelFlag()))
        {
            return error("指导教师不存在");
        }
        if (teacher.getRoles() == null || teacher.getRoles().stream()
                .noneMatch(role -> "teacher".equals(role.getRoleKey())))
        {
            return error("所选用户不是指导教师");
        }

        invitation.setTeamId(teamId);
        invitation.setCompetitionId(team.getCompetitionId());
        invitation.setCompetitionName(team.getCompetitionName());
        invitation.setTeamName(team.getTeamName());
        invitation.setTeacherName(teacher.getNickName() != null && !teacher.getNickName().isBlank()
                ? teacher.getNickName() : teacher.getUserName());
        invitation.setStudentId(loginUser.getUserId());
        invitation.setStudentName(loginUser.getUser().getNickName() != null
                ? loginUser.getUser().getNickName() : loginUser.getUsername());
        invitationService.insertInvitation(invitation);
        return success("邀请已发送");
    }

    @Operation(summary = "学生-查看队伍的所有邀请记录")
    @GetMapping("/student/team/{teamId}/invitations")
    public AjaxResult teamInvitations(@PathVariable Long teamId)
    {
        List<TeamTeacherInvitation> list = invitationService.selectInvitationsByTeamId(teamId);
        return success(list);
    }

    @Operation(summary = "学生-撤销邀请")
    @DeleteMapping("/student/team/invitation/{invitationId}/cancel")
    public AjaxResult cancelInvitation(@PathVariable Long invitationId)
    {
        LoginUser loginUser = SecurityUtils.getLoginUser();
        if (loginUser == null)
        {
            return error("请先登录");
        }
        invitationService.cancelInvitation(invitationId, loginUser.getUserId());
        return success("已撤销");
    }

    @Operation(summary = "教师-待办邀请列表")
    @GetMapping("/teacher/invitation/pending")
    public AjaxResult teacherPending()
    {
        LoginUser loginUser = SecurityUtils.getLoginUser();
        if (loginUser == null)
        {
            return error("请先登录");
        }
        List<TeamTeacherInvitation> list = invitationService.selectPendingByTeacherId(loginUser.getUserId());
        return success(list);
    }

    @Operation(summary = "教师-已处理邀请历史")
    @GetMapping("/teacher/invitation/history")
    public AjaxResult teacherHistory()
    {
        LoginUser loginUser = SecurityUtils.getLoginUser();
        if (loginUser == null)
        {
            return error("请先登录");
        }
        List<TeamTeacherInvitation> list = invitationService.selectHistoryByTeacherId(loginUser.getUserId());
        return success(list);
    }

    @Operation(summary = "教师-接受邀请")
    @PutMapping("/teacher/invitation/{invitationId}/accept")
    public AjaxResult acceptInvitation(
            @PathVariable Long invitationId,
            @RequestBody Map<String, String> body)
    {
        LoginUser loginUser = SecurityUtils.getLoginUser();
        if (loginUser == null)
        {
            return error("请先登录");
        }
        String message = body != null ? body.getOrDefault("replyMessage", "已接受") : "已接受";
        TeamTeacherInvitation invitation = invitationService.selectInvitationById(invitationId);
        invitationService.acceptInvitation(invitationId, message, loginUser.getUserId());

        notifyStudent(invitation, "accept", message);
        return success("已接受邀请");
    }

    @Operation(summary = "教师-拒绝邀请")
    @PutMapping("/teacher/invitation/{invitationId}/reject")
    public AjaxResult rejectInvitation(
            @PathVariable Long invitationId,
            @RequestBody Map<String, String> body)
    {
        LoginUser loginUser = SecurityUtils.getLoginUser();
        if (loginUser == null)
        {
            return error("请先登录");
        }
        String message = body != null ? body.getOrDefault("replyMessage", "暂时无法指导") : "暂时无法指导";
        TeamTeacherInvitation invitation = invitationService.selectInvitationById(invitationId);
        invitationService.rejectInvitation(invitationId, message, loginUser.getUserId());

        notifyStudent(invitation, "reject", message);
        return success("已拒绝");
    }

    @Operation(summary = "教师-查看指导队伍列表")
    @GetMapping("/teacher/team/list")
    public AjaxResult teacherTeams()
    {
        LoginUser loginUser = SecurityUtils.getLoginUser();
        if (loginUser == null)
        {
            return error("请先登录");
        }
        List<CompTeam> list = teamService.getTeacherTeams(loginUser.getUserId());
        return success(list);
    }

    private void notifyStudent(TeamTeacherInvitation invitation, String action, String replyMessage)
    {
        if (invitation == null || invitation.getStudentId() == null)
        {
            return;
        }
        UserNotification notification = new UserNotification();
        notification.setUserId(invitation.getStudentId());
        notification.setBizType("invitation");
        notification.setBizId(invitation.getInvitationId());
        if ("accept".equals(action))
        {
            notification.setTitle("指导邀请已接受");
            notification.setContent("教师 " + invitation.getTeacherName()
                    + " 已同意指导你的队伍【" + invitation.getTeamName() + "】");
        }
        else
        {
            notification.setTitle("指导邀请已拒绝");
            notification.setContent("教师 " + invitation.getTeacherName()
                    + " 已拒绝指导你的队伍【" + invitation.getTeamName() + "】"
                    + (replyMessage != null ? "，回复：" + replyMessage : ""));
        }
        rabbitMqProducer.sendNotification(notification);
    }
}
