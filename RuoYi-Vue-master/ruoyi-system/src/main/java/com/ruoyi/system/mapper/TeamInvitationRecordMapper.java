package com.ruoyi.system.mapper;

import java.util.List;
import com.ruoyi.system.domain.TeamInvitationRecord;

public interface TeamInvitationRecordMapper
{
    int insertInvitation(TeamInvitationRecord record);

    TeamInvitationRecord selectById(Long id);

    List<TeamInvitationRecord> selectByInviteeId(Long inviteeId);

    List<TeamInvitationRecord> selectByInviterId(Long inviterId);

    int updateStatus(Long id, String status);

    int checkDuplicatePending(Long teamId, Long inviteeId);

    List<TeamInvitationRecord> selectByTeamId(Long teamId);
}
