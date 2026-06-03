package com.ruoyi.system.service;

import java.util.List;
import com.ruoyi.system.domain.CompetitionRetrospect;

public interface ICompetitionRetrospectService
{
    CompetitionRetrospect selectRetrospectById(Long retrospectId);

    List<CompetitionRetrospect> selectRetrospectList(CompetitionRetrospect retrospect);

    List<CompetitionRetrospect> selectAuditList(CompetitionRetrospect retrospect);

    List<CompetitionRetrospect> selectMySubmissions(CompetitionRetrospect retrospect);

    int insertRetrospect(CompetitionRetrospect retrospect);

    int updateRetrospect(CompetitionRetrospect retrospect);

    int deleteRetrospectByIds(Long[] retrospectIds);

    CompetitionRetrospect selectRetrospectByIdRaw(Long retrospectId);

    int auditRetrospect(CompetitionRetrospect retrospect);
}
