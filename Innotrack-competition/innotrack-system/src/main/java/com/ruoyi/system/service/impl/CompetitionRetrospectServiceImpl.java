package com.ruoyi.system.service.impl;

import java.util.Arrays;
import java.util.HashSet;
import java.util.List;
import java.util.Set;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import com.ruoyi.common.exception.ServiceException;
import com.ruoyi.common.utils.SecurityUtils;
import com.ruoyi.common.utils.StringUtils;
import com.ruoyi.system.domain.CompetitionRetrospect;
import com.ruoyi.system.mapper.CompetitionRetrospectMapper;
import com.ruoyi.system.service.ICompetitionRetrospectService;

@Service
public class CompetitionRetrospectServiceImpl implements ICompetitionRetrospectService
{
    private static final Set<String> VALID_AWARD_LEVELS = new HashSet<>(
            Arrays.asList("国家级", "省级", "市级", "校级"));

    private static final int MAX_CONTENT_LENGTH = 50000;

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
        validateRetrospect(retrospect);
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
        validateRetrospect(retrospect);
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

    private void validateRetrospect(CompetitionRetrospect retrospect)
    {
        if (retrospect == null)
        {
            throw new ServiceException("复盘数据不能为空");
        }
        if (StringUtils.isEmpty(retrospect.getProjectName()))
        {
            throw new ServiceException("项目名称不能为空");
        }
        if (retrospect.getProjectName().length() > 100)
        {
            throw new ServiceException("项目名称不能超过100个字符");
        }
        if (StringUtils.isEmpty(retrospect.getCompetitionName()))
        {
            throw new ServiceException("竞赛名称不能为空");
        }
        if (retrospect.getCompetitionName().length() > 100)
        {
            throw new ServiceException("竞赛名称不能超过100个字符");
        }
        if (StringUtils.isEmpty(retrospect.getContent()))
        {
            throw new ServiceException("复盘内容不能为空");
        }
        if (retrospect.getContent().length() > MAX_CONTENT_LENGTH)
        {
            throw new ServiceException("复盘内容不能超过" + MAX_CONTENT_LENGTH + "个字符");
        }
        if (StringUtils.isNotEmpty(retrospect.getAwardLevel())
                && !VALID_AWARD_LEVELS.contains(retrospect.getAwardLevel()))
        {
            throw new ServiceException("获奖级别不合法，仅支持：国家级、省级、市级、校级");
        }
        if (StringUtils.isNotEmpty(retrospect.getYear())
                && !retrospect.getYear().matches("\\d{4}"))
        {
            throw new ServiceException("年份格式不正确，请输入4位数字（如2025）");
        }
        if (StringUtils.isNotEmpty(retrospect.getLeaderName())
                && retrospect.getLeaderName().length() > 50)
        {
            throw new ServiceException("负责人姓名不能超过50个字符");
        }
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
