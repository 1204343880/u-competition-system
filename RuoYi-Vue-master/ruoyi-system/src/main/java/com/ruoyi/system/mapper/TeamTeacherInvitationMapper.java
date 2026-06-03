package com.ruoyi.system.mapper;

import java.util.List;
import com.ruoyi.system.domain.TeamTeacherInvitation;

public interface TeamTeacherInvitationMapper
{
    TeamTeacherInvitation selectInvitationById(Long invitationId);

    List<TeamTeacherInvitation> selectInvitationsByTeamId(Long teamId);

    List<TeamTeacherInvitation> selectPendingByTeacherId(Long teacherId);

    List<TeamTeacherInvitation> selectHistoryByTeacherId(Long teacherId);

    int insertInvitation(TeamTeacherInvitation invitation);

    int updateStatus(TeamTeacherInvitation invitation);

    int deleteInvitation(Long invitationId);
}
