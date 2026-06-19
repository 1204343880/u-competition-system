package com.ruoyi.system.mapper;

import java.util.List;
import com.ruoyi.system.domain.CompetitionRetrospect;
import org.apache.ibatis.annotations.Param;

public interface CompetitionRetrospectMapper
{
    CompetitionRetrospect selectRetrospectById(Long retrospectId);

    List<CompetitionRetrospect> selectRetrospectList(CompetitionRetrospect retrospect);

    List<CompetitionRetrospect> selectAuditList(CompetitionRetrospect retrospect);

    List<CompetitionRetrospect> selectMySubmissions(CompetitionRetrospect retrospect);

    List<CompetitionRetrospect> searchForAgent(@Param("query") String query);

    int insertRetrospect(CompetitionRetrospect retrospect);

    int updateRetrospect(CompetitionRetrospect retrospect);

    int deleteRetrospectByIds(Long[] retrospectIds);

    CompetitionRetrospect selectRetrospectByIdRaw(Long retrospectId);

    int auditRetrospect(CompetitionRetrospect retrospect);
}
