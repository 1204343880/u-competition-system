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
import com.ruoyi.system.domain.CompetitionExperience;
import com.ruoyi.system.mapper.CompetitionExperienceMapper;
import com.ruoyi.system.service.ICompetitionExperienceService;

@Service
public class CompetitionExperienceServiceImpl implements ICompetitionExperienceService
{
    private static final Set<String> VALID_CATEGORIES = new HashSet<>(Arrays.asList(
            "备赛心得", "团队协作", "时间管理", "答辩经验", "技术分享", "避坑指南"));

    private static final int MAX_CONTENT_LENGTH = 50000;

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
        validateExperience(experience);
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
        validateExperience(experience);
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

    private void validateExperience(CompetitionExperience experience)
    {
        if (experience == null)
        {
            throw new ServiceException("经验帖数据不能为空");
        }
        if (StringUtils.isEmpty(experience.getTitle()))
        {
            throw new ServiceException("标题不能为空");
        }
        if (experience.getTitle().length() > 100)
        {
            throw new ServiceException("标题不能超过100个字符");
        }
        if (StringUtils.isEmpty(experience.getContent()))
        {
            throw new ServiceException("正文内容不能为空");
        }
        if (experience.getContent().length() > MAX_CONTENT_LENGTH)
        {
            throw new ServiceException("正文内容不能超过" + MAX_CONTENT_LENGTH + "个字符");
        }
        if (StringUtils.isNotEmpty(experience.getCategory())
                && !VALID_CATEGORIES.contains(experience.getCategory()))
        {
            throw new ServiceException("分类不合法，仅支持：备赛心得、团队协作、时间管理、答辩经验、技术分享、避坑指南");
        }
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
