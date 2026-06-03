package com.ruoyi.system.service;

import java.util.List;
import com.ruoyi.system.domain.Competition;

public interface ICompetitionService
{
    Competition selectCompetitionById(Long competitionId);

    List<Competition> selectCompetitionList(Competition competition);
}
