package com.ruoyi.system.mapper;

import java.util.List;
import com.ruoyi.system.domain.Competition;

public interface CompetitionMapper
{
    Competition selectCompetitionById(Long competitionId);

    List<Competition> selectCompetitionList(Competition competition);
}
