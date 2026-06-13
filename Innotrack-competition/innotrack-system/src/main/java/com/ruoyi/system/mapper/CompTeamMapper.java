package com.ruoyi.system.mapper;

import java.util.List;
import com.ruoyi.system.domain.CompTeam;
import com.ruoyi.system.domain.CompTeamMember;

public interface CompTeamMapper
{
    int insertTeam(CompTeam team);

    CompTeam selectTeamById(Long teamId);

    CompTeam selectTeamByInviteCode(String inviteCode);

    CompTeam selectTeamByCompIdAndUserId(Long competitionId, Long userId);

    List<CompTeam> selectTeamsByUserId(Long userId);

    List<CompTeamMember> selectMembersByTeamId(Long teamId);

    int updateTeam(CompTeam team);

    int deleteTeam(Long teamId);

    int countMemberByCompIdAndUserId(Long competitionId, Long userId);

    int transferLeader(Long teamId, Long newLeaderId, String newLeaderName);

    List<CompTeam> selectPublicTeams(Long competitionId);

    int togglePublic(Long teamId, String isPublic);

    int updateNeededSkills(Long teamId, String neededSkills);

    int submitTeam(Long teamId, Long leaderId);

    int auditTeam(CompTeam team);

    List<CompTeam> selectTeamAuditList(CompTeam team);

    int setTeacher(Long teamId, Long teacherId, String teacherName);

    List<CompTeam> selectTeamsByTeacherId(Long teacherId);
}
