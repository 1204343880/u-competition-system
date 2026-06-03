package com.ruoyi.system.mapper;

import java.util.List;
import com.ruoyi.system.domain.CompetitionApply;

public interface CompetitionApplyMapper
{
    CompetitionApply selectApplyByCompetitionIdAndUserId(Long competitionId, Long userId);

    List<CompetitionApply> selectApplyListByUserId(Long userId);

    int insertApply(CompetitionApply apply);

    int updateApply(CompetitionApply apply);
}
