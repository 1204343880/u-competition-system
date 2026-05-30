package com.ruoyi.competition.mapper;

import java.util.List;
import com.ruoyi.competition.domain.Competition;
import com.ruoyi.competition.domain.CompetitionApply;

/**
 * 竞赛信息Mapper接口
 * 
 * @author ruoyi
 * @date 2026-05-28
 */
public interface CompetitionMapper 
{
    /**
     * 查询竞赛信息
     * 
     * @param competitionId 竞赛信息主键
     * @return 竞赛信息
     */
    public Competition selectCompetitionById(Long competitionId);

    /**
     * 查询竞赛信息列表
     * 
     * @param competition 竞赛信息
     * @return 竞赛信息集合
     */
    public List<Competition> selectCompetitionList(Competition competition);

    /**
     * 查询用户已报名的竞赛列表
     * 
     * @param userId 用户ID
     * @return 竞赛信息集合
     */
    public List<Competition> selectMyCompetitionList(Long userId);

    /**
     * 新增竞赛信息
     * 
     * @param competition 竞赛信息
     * @return 结果
     */
    public int insertCompetition(Competition competition);

    /**
     * 修改竞赛信息
     * 
     * @param competition 竞赛信息
     * @return 结果
     */
    public int updateCompetition(Competition competition);

    /**
     * 删除竞赛信息
     * 
     * @param competitionId 竞赛信息主键
     * @return 结果
     */
    public int deleteCompetitionById(Long competitionId);

    /**
     * 批量删除竞赛信息
     * 
     * @param competitionIds 需要删除的数据主键集合
     * @return 结果
     */
    public int deleteCompetitionByIds(Long[] competitionIds);

    /**
     * 查询报名记录
     * 
     * @param applyId 报名ID
     * @return 报名记录
     */
    public CompetitionApply selectApplyById(Long applyId);

    /**
     * 查询用户是否已报名某竞赛
     * 
     * @param competitionId 竞赛ID
     * @param userId 用户ID
     * @return 报名记录
     */
    public CompetitionApply selectApplyByCompetitionAndUser(Long competitionId, Long userId);

    /**
     * 新增报名记录
     * 
     * @param apply 报名记录
     * @return 结果
     */
    public int insertApply(CompetitionApply apply);

    /**
     * 删除报名记录
     * 
     * @param applyId 报名ID
     * @return 结果
     */
    public int deleteApplyById(Long applyId);

    /**
     * 根据竞赛ID和用户ID删除报名记录
     * 
     * @param competitionId 竞赛ID
     * @param userId 用户ID
     * @return 结果
     */
    public int deleteApplyByCompetitionAndUser(Long competitionId, Long userId);
}