package com.ruoyi.system.mapper;

import java.util.List;
import com.ruoyi.system.domain.CompetitionResult;

public interface CompetitionResultMapper
{
    CompetitionResult selectResultById(Long resultId);

    List<CompetitionResult> selectResultList(CompetitionResult result);

    List<CompetitionResult> selectResultAuditList(CompetitionResult result);

    int insertResult(CompetitionResult result);

    int updateResult(CompetitionResult result);

    int auditResult(CompetitionResult result);

    int deleteResultByIds(Long[] resultIds);

    CompetitionResult selectResultByIdRaw(Long resultId);

    List<CompetitionResult> selectResultsByUserId(Long userId);
}
