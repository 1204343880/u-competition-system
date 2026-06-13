package com.ruoyi.system.service.impl;

import java.util.List;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import com.ruoyi.common.exception.ServiceException;
import com.ruoyi.common.utils.SecurityUtils;
import com.ruoyi.system.domain.CompetitionExperience;
import com.ruoyi.system.mapper.CompetitionExperienceMapper;
import com.ruoyi.system.service.ICompetitionExperienceService;

@Service
public class CompetitionExperienceServiceImpl implements ICompetitionExperienceService
{
    @Autowired
    private CompetitionExperienceMapper experienceMapper;

    @Override
    public CompetitionExperience selectExperienceById(Long experienceId)
    {
        return experienceMapper.selectExperienceById(experienceId);
    }

    @Override
    public List<CompetitionExperience> selectExperienceList(CompetitionExperience experience)
    {
        return experienceMapper.selectExperienceList(experience);
    }

    @Override
    public List<CompetitionExperience> selectAuditList(CompetitionExperience experience)
    {
        return experienceMapper.selectAuditList(experience);
    }

    @Override
    public List<CompetitionExperience> selectMySubmissions(CompetitionExperience experience)
    {
        return experienceMapper.selectMySubmissions(experience);
    }

    @Override
    public int insertExperience(CompetitionExperience experience)
    {
        return experienceMapper.insertExperience(experience);
    }

    @Override
    public CompetitionExperience selectExperienceByIdRaw(Long experienceId)
    {
        return experienceMapper.selectExperienceByIdRaw(experienceId);
    }

    @Override
    public int updateExperience(CompetitionExperience experience)
    {
        CompetitionExperience exist = experienceMapper.selectExperienceByIdRaw(experience.getExperienceId());
        checkOwnership(exist);
        if ("2".equals(exist.getAuditStatus()))
        {
            experience.setAuditStatus("0");
            experience.setRejectReason(null);
        }
        return experienceMapper.updateExperience(experience);
    }

    @Override
    public int deleteExperienceByIds(Long[] experienceIds)
    {
        for (Long id : experienceIds)
        {
            CompetitionExperience exist = selectExperienceForOwner(id);
            checkOwnership(exist);
        }
        return experienceMapper.deleteExperienceByIds(experienceIds);
    }

    @Override
    public int auditExperience(CompetitionExperience experience)
    {
        int rows = experienceMapper.auditExperience(experience);
        if (rows == 0)
        {
            throw new ServiceException("该经验帖已被审核或不存在，请刷新列表");
        }
        return rows;
    }

    @Override
    public int incrementViewCount(Long experienceId)
    {
        return experienceMapper.incrementViewCount(experienceId);
    }

    private CompetitionExperience selectExperienceForOwner(Long id)
    {
        return experienceMapper.selectExperienceByIdRaw(id);
    }

    private void checkOwnership(CompetitionExperience record)
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
