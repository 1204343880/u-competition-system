package com.ruoyi.system.service.impl;

import java.util.List;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import com.ruoyi.common.exception.ServiceException;
import com.ruoyi.system.domain.Competition;
import com.ruoyi.system.mapper.CompetitionMapper;
import com.ruoyi.system.service.ICompetitionService;

@Service
public class CompetitionServiceImpl implements ICompetitionService
{
    @Autowired
    private CompetitionMapper competitionMapper;

    @Override
    public Competition selectCompetitionById(Long competitionId)
    {
        return competitionMapper.selectCompetitionById(competitionId);
    }

    @Override
    public List<Competition> selectCompetitionList(Competition competition)
    {
        return competitionMapper.selectCompetitionList(competition);
    }

    @Override
    public List<Competition> selectCompetitionManageList(Competition competition)
    {
        return competitionMapper.selectCompetitionManageList(competition);
    }

    @Override
    public int insertCompetition(Competition competition)
    {
        if (competition.getPublishStatus() == null)
        {
            competition.setPublishStatus("0");
        }
        return competitionMapper.insertCompetition(competition);
    }

    @Override
    public int updateCompetition(Competition competition)
    {
        Competition exist = competitionMapper.selectCompetitionById(competition.getCompetitionId());
        if (exist == null)
        {
            throw new ServiceException("竞赛不存在");
        }
        return competitionMapper.updateCompetition(competition);
    }

    @Override
    public int deleteCompetitionByIds(Long[] competitionIds)
    {
        return competitionMapper.deleteCompetitionByIds(competitionIds);
    }

    @Override
    public int updatePublishStatus(Competition competition)
    {
        Competition exist = competitionMapper.selectCompetitionById(competition.getCompetitionId());
        if (exist == null)
        {
            throw new ServiceException("竞赛不存在");
        }
        if ("0".equals(competition.getPublishStatus()))
        {
            String cur = exist.getPublishStatus();
            if (!"0".equals(cur) && !"2".equals(cur))
            {
                throw new ServiceException("仅草稿和已关闭的竞赛可以退回草稿");
            }
        }
        return competitionMapper.updatePublishStatus(competition);
    }

    @Override
    public boolean incrementParticipants(Long competitionId)
    {
        return competitionMapper.incrementParticipants(competitionId) > 0;
    }

    @Override
    public void decrementParticipants(Long competitionId)
    {
        competitionMapper.decrementParticipants(competitionId);
    }
}
