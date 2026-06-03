package com.ruoyi.system.service.impl;

import java.util.List;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
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
}
