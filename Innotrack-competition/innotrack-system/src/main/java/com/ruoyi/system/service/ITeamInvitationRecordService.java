package com.ruoyi.system.service;

import java.util.List;
import com.ruoyi.system.domain.TeamInvitationRecord;

public interface ITeamInvitationRecordService
{
    TeamInvitationRecord inviteFromMarket(Long teamId, Long inviterId, Long inviteeId);

    void acceptInvitation(Long recordId, Long userId);

    void rejectInvitation(Long recordId, Long userId);

    List<TeamInvitationRecord> getMyInvitations(Long userId);

    List<TeamInvitationRecord> getMySentInvitations(Long userId);
}
