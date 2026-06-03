package com.ruoyi.system.service;

import java.util.List;
import com.ruoyi.system.domain.CompTeam;
import com.ruoyi.system.domain.CompTeamMember;

public interface ICompTeamService
{
    CompTeam createTeam(Long competitionId, String teamName, Long userId, String userName);

    CompTeam joinTeam(Long competitionId, String inviteCode, Long userId, String userName, String nickName);

    void leaveTeam(Long teamId, Long userId);

    void kickMember(Long teamId, Long leaderId, Long memberId);

    void disbandTeam(Long teamId, Long userId);

    CompTeam getMyTeamByCompetitionId(Long competitionId, Long userId);

    List<CompTeam> getMyTeams(Long userId);

    List<CompTeamMember> getTeamMembers(Long teamId);

    void transferLeader(Long teamId, Long currentLeaderId, Long newLeaderId);

    List<CompTeam> getPublicTeams(Long competitionId);

    void togglePublic(Long teamId, Long userId, boolean isPublic);

    void updateNeededSkills(Long teamId, Long userId, String skills);

    CompTeam getTeamById(Long teamId);

    void submitTeam(Long teamId, Long leaderId);

    void auditTeam(CompTeam team);

    List<CompTeam> selectTeamAuditList(CompTeam team);

    List<CompTeam> getTeacherTeams(Long teacherId);
}
