package com.ruoyi.system.mapper;

import com.ruoyi.system.domain.CompTeamMember;

public interface CompTeamMemberMapper
{
    int insertMember(CompTeamMember member);

    int deleteMember(Long id);

    CompTeamMember selectMemberByTeamIdAndUserId(Long teamId, Long userId);

    boolean existsMemberInCompetition(Long competitionId, Long userId);
}
