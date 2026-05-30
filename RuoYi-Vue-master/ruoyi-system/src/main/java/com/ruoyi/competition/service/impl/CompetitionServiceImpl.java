package com.ruoyi.competition.service.impl;

import java.util.Date;
import java.util.List;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import com.ruoyi.competition.domain.Competition;
import com.ruoyi.competition.domain.CompetitionApply;
import com.ruoyi.competition.mapper.CompetitionMapper;
import com.ruoyi.competition.service.ICompetitionService;
import com.ruoyi.common.core.domain.entity.SysUser;
import com.ruoyi.common.exception.ServiceException;
import com.ruoyi.common.utils.SecurityUtils;
import com.ruoyi.system.service.ISysUserService;

/**
 * 竞赛信息Service业务层处理
 * 
 * @author ruoyi
 * @date 2026-05-28
 */
@Service
public class CompetitionServiceImpl implements ICompetitionService 
{
    @Autowired
    private CompetitionMapper competitionMapper;

    @Autowired
    private ISysUserService userService;

    /**
     * 查询竞赛信息
     * 
     * @param competitionId 竞赛信息主键
     * @return 竞赛信息
     */
    @Override
    public Competition selectCompetitionById(Long competitionId)
    {
        return competitionMapper.selectCompetitionById(competitionId);
    }

    /**
     * 查询竞赛信息列表
     * 
     * @param competition 竞赛信息
     * @return 竞赛信息集合
     */
    @Override
    public List<Competition> selectCompetitionList(Competition competition)
    {
        return competitionMapper.selectCompetitionList(competition);
    }

    /**
     * 查询用户已报名的竞赛列表
     * 
     * @param userId 用户ID
     * @return 竞赛信息集合
     */
    @Override
    public List<Competition> selectMyCompetitionList(Long userId)
    {
        return competitionMapper.selectMyCompetitionList(userId);
    }

    /**
     * 新增竞赛信息
     * 
     * @param competition 竞赛信息
     * @return 结果
     */
    @Override
    public int insertCompetition(Competition competition)
    {
        competition.setCreateBy(SecurityUtils.getUsername());
        competition.setCreateTime(new Date());
        competition.setDelFlag("0");
        competition.setCurrentParticipants(0);
        return competitionMapper.insertCompetition(competition);
    }

    /**
     * 修改竞赛信息
     * 
     * @param competition 竞赛信息
     * @return 结果
     */
    @Override
    public int updateCompetition(Competition competition)
    {
        competition.setUpdateBy(SecurityUtils.getUsername());
        competition.setUpdateTime(new Date());
        return competitionMapper.updateCompetition(competition);
    }

    /**
     * 删除竞赛信息
     * 
     * @param competitionId 竞赛信息主键
     * @return 结果
     */
    @Override
    public int deleteCompetitionById(Long competitionId)
    {
        return competitionMapper.deleteCompetitionById(competitionId);
    }

    /**
     * 批量删除竞赛信息
     * 
     * @param competitionIds 需要删除的数据主键集合
     * @return 结果
     */
    @Override
    public int deleteCompetitionByIds(Long[] competitionIds)
    {
        return competitionMapper.deleteCompetitionByIds(competitionIds);
    }

    /**
     * 报名竞赛
     * 
     * @param competitionId 竞赛ID
     * @param userId 用户ID
     * @return 结果
     */
    @Override
    public int applyCompetition(Long competitionId, Long userId)
    {
        // 检查竞赛是否存在
        Competition competition = competitionMapper.selectCompetitionById(competitionId);
        if (competition == null)
        {
            throw new ServiceException("竞赛不存在");
        }

        // 检查是否已报名
        if (isApplied(competitionId, userId))
        {
            throw new ServiceException("您已报名该竞赛");
        }

        // 获取用户信息
        SysUser user = userService.selectUserById(userId);
        if (user == null)
        {
            throw new ServiceException("用户不存在");
        }

        // 创建报名记录
        CompetitionApply apply = new CompetitionApply();
        apply.setCompetitionId(competitionId);
        apply.setUserId(userId);
        apply.setUserName(user.getUserName());
        apply.setNickName(user.getNickName());
        apply.setApplyTime(new Date());
        apply.setAuditStatus("0");
        apply.setDelFlag("0");
        apply.setCreateBy(user.getUserName());
        apply.setCreateTime(new Date());

        return competitionMapper.insertApply(apply);
    }

    /**
     * 取消报名
     * 
     * @param competitionId 竞赛ID
     * @param userId 用户ID
     * @return 结果
     */
    @Override
    public int cancelCompetition(Long competitionId, Long userId)
    {
        // 检查是否已报名
        if (!isApplied(competitionId, userId))
        {
            throw new ServiceException("您尚未报名该竞赛");
        }

        return competitionMapper.deleteApplyByCompetitionAndUser(competitionId, userId);
    }

    /**
     * 判断用户是否已报名某竞赛
     * 
     * @param competitionId 竞赛ID
     * @param userId 用户ID
     * @return 是否已报名
     */
    @Override
    public boolean isApplied(Long competitionId, Long userId)
    {
        CompetitionApply apply = competitionMapper.selectApplyByCompetitionAndUser(competitionId, userId);
        return apply != null;
    }
}