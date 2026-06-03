package com.ruoyi.system.service.impl;

import java.util.List;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import com.ruoyi.system.domain.CompetitionApply;
import com.ruoyi.system.mapper.CompetitionApplyMapper;
import com.ruoyi.system.service.ICompetitionApplyService;

@Service
public class CompetitionApplyServiceImpl implements ICompetitionApplyService
{
    @Autowired
    private CompetitionApplyMapper applyMapper;

    @Override
    public CompetitionApply selectApplyByCompetitionIdAndUserId(Long competitionId, Long userId)
    {
        return applyMapper.selectApplyByCompetitionIdAndUserId(competitionId, userId);
    }

    @Override
    public List<CompetitionApply> selectApplyListByUserId(Long userId)
    {
        return applyMapper.selectApplyListByUserId(userId);
    }

    @Override
    public int insertApply(CompetitionApply apply)
    {
        return applyMapper.insertApply(apply);
    }
}
