package com.ruoyi.system.service;

import java.util.List;
import com.ruoyi.system.domain.CompetitionApply;

public interface ICompetitionApplyService
{
    CompetitionApply selectApplyByCompetitionIdAndUserId(Long competitionId, Long userId);

    List<CompetitionApply> selectApplyListByUserId(Long userId);

    int insertApply(CompetitionApply apply);

    int cancelApply(Long applyId);

    int auditApply(CompetitionApply apply);

    List<CompetitionApply> selectApplyAuditList(CompetitionApply apply);

    CompetitionApply selectApplyByIdRaw(Long applyId);
}
