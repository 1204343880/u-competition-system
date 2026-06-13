package com.ruoyi.system.service.impl;

import java.util.Date;
import java.util.List;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import com.ruoyi.common.exception.ServiceException;
import com.ruoyi.common.utils.SecurityUtils;
import com.ruoyi.system.domain.CompetitionResult;
import com.ruoyi.system.mapper.CompetitionResultMapper;
import com.ruoyi.system.service.ICompetitionResultService;

@Service
public class CompetitionResultServiceImpl implements ICompetitionResultService
{
    @Autowired
    private CompetitionResultMapper resultMapper;

    @Override
    public CompetitionResult selectResultById(Long resultId)
    {
        return resultMapper.selectResultById(resultId);
    }

    @Override
    public List<CompetitionResult> selectResultList(CompetitionResult result)
    {
        return resultMapper.selectResultList(result);
    }

    @Override
    public List<CompetitionResult> selectResultAuditList(CompetitionResult result)
    {
        return resultMapper.selectResultAuditList(result);
    }

    @Override
    public int insertResult(CompetitionResult result)
    {
        return resultMapper.insertResult(result);
    }

    @Override
    public int updateResult(CompetitionResult result)
    {
        CompetitionResult exist = resultMapper.selectResultByIdRaw(result.getResultId());
        checkOwnership(exist);
        return resultMapper.updateResult(result);
    }

    @Override
    public int auditResult(CompetitionResult result)
    {
        int rows = resultMapper.auditResult(result);
        if (rows == 0)
        {
            throw new ServiceException("该成绩已被审核或不存在，请刷新列表");
        }
        return rows;
    }

    @Override
    public int deleteResultByIds(Long[] resultIds)
    {
        for (Long id : resultIds)
        {
            CompetitionResult exist = resultMapper.selectResultByIdRaw(id);
            checkOwnership(exist);
        }
        return resultMapper.deleteResultByIds(resultIds);
    }

    @Override
    public CompetitionResult selectResultByIdRaw(Long resultId)
    {
        return resultMapper.selectResultByIdRaw(resultId);
    }

    @Override
    public List<CompetitionResult> selectResultsByUserId(Long userId)
    {
        return resultMapper.selectResultsByUserId(userId);
    }

    private void checkOwnership(CompetitionResult record)
    {
        if (record == null)
        {
            throw new ServiceException("成绩记录不存在");
        }
        String currentUser = SecurityUtils.getUsername();
        if (!currentUser.equals(record.getCreateBy())
                && !SecurityUtils.hasRole("admin"))
        {
            throw new ServiceException("无权操作此成绩记录");
        }
    }
}
