package com.ruoyi.system.service.impl;

import java.util.List;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import com.ruoyi.common.exception.ServiceException;
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

    @Override
    public int cancelApply(Long applyId)
    {
        return applyMapper.deleteApply(applyId);
    }

    @Override
    public int auditApply(CompetitionApply apply)
    {
        int rows = applyMapper.auditApply(apply);
        if (rows == 0)
        {
            throw new ServiceException("该报名已被处理或不存在，请刷新列表");
        }
        return rows;
    }

    @Override
    public List<CompetitionApply> selectApplyAuditList(CompetitionApply apply)
    {
        return applyMapper.selectApplyAuditList(apply);
    }

    @Override
    public CompetitionApply selectApplyByIdRaw(Long applyId)
    {
        return applyMapper.selectApplyByIdRaw(applyId);
    }
}
