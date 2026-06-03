package com.ruoyi.system.service.impl;

import java.util.List;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import com.ruoyi.common.exception.ServiceException;
import com.ruoyi.common.utils.SecurityUtils;
import com.ruoyi.system.domain.CompetitionRetrospect;
import com.ruoyi.system.mapper.CompetitionRetrospectMapper;
import com.ruoyi.system.service.ICompetitionRetrospectService;

@Service
public class CompetitionRetrospectServiceImpl implements ICompetitionRetrospectService
{
    @Autowired
    private CompetitionRetrospectMapper retrospectMapper;

    @Override
    public CompetitionRetrospect selectRetrospectById(Long retrospectId)
    {
        return retrospectMapper.selectRetrospectById(retrospectId);
    }

    @Override
    public List<CompetitionRetrospect> selectRetrospectList(CompetitionRetrospect retrospect)
    {
        return retrospectMapper.selectRetrospectList(retrospect);
    }

    @Override
    public List<CompetitionRetrospect> selectAuditList(CompetitionRetrospect retrospect)
    {
        return retrospectMapper.selectAuditList(retrospect);
    }

    @Override
    public List<CompetitionRetrospect> selectMySubmissions(CompetitionRetrospect retrospect)
    {
        return retrospectMapper.selectMySubmissions(retrospect);
    }

    @Override
    public int insertRetrospect(CompetitionRetrospect retrospect)
    {
        return retrospectMapper.insertRetrospect(retrospect);
    }

    @Override
    public CompetitionRetrospect selectRetrospectByIdRaw(Long retrospectId)
    {
        return retrospectMapper.selectRetrospectByIdRaw(retrospectId);
    }

    @Override
    public int updateRetrospect(CompetitionRetrospect retrospect)
    {
        CompetitionRetrospect exist = retrospectMapper.selectRetrospectByIdRaw(retrospect.getRetrospectId());
        checkOwnership(exist);
        if ("2".equals(exist.getAuditStatus()))
        {
            retrospect.setAuditStatus("0");
            retrospect.setRejectReason(null);
        }
        return retrospectMapper.updateRetrospect(retrospect);
    }

    @Override
    public int deleteRetrospectByIds(Long[] retrospectIds)
    {
        for (Long id : retrospectIds)
        {
            CompetitionRetrospect exist = selectRetrospectForOwner(id);
            checkOwnership(exist);
        }
        return retrospectMapper.deleteRetrospectByIds(retrospectIds);
    }

    @Override
    public int auditRetrospect(CompetitionRetrospect retrospect)
    {
        int rows = retrospectMapper.auditRetrospect(retrospect);
        if (rows == 0)
        {
            throw new ServiceException("该复盘已被审核或不存在，请刷新列表");
        }
        return rows;
    }

    private CompetitionRetrospect selectRetrospectForOwner(Long id)
    {
        return retrospectMapper.selectRetrospectByIdRaw(id);
    }

    private void checkOwnership(CompetitionRetrospect record)
    {
        if (record == null)
        {
            throw new ServiceException("记录不存在");
        }
        String currentUser = SecurityUtils.getUsername();
        if (!currentUser.equals(record.getCreateBy())
                && !SecurityUtils.hasRole("admin")
                && !SecurityUtils.hasRole("teacher"))
        {
            throw new ServiceException("无权操作他人数据");
        }
    }
}
