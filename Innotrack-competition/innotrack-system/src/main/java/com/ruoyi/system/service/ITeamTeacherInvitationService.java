package com.ruoyi.system.service;

import java.util.List;
import com.ruoyi.system.domain.TeamTeacherInvitation;

public interface ITeamTeacherInvitationService
{
    TeamTeacherInvitation selectInvitationById(Long invitationId);

    List<TeamTeacherInvitation> selectInvitationsByTeamId(Long teamId);

    List<TeamTeacherInvitation> selectPendingByTeacherId(Long teacherId);

    List<TeamTeacherInvitation> selectHistoryByTeacherId(Long teacherId);

    int insertInvitation(TeamTeacherInvitation invitation);

    int acceptInvitation(Long invitationId, String replyMessage, Long teacherId);

    int rejectInvitation(Long invitationId, String replyMessage, Long teacherId);

    int cancelInvitation(Long invitationId, Long studentId);
}
