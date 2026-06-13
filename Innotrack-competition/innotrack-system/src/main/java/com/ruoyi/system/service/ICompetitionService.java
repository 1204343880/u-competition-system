package com.ruoyi.system.service;

import java.util.List;
import com.ruoyi.system.domain.Competition;

public interface ICompetitionService
{
    Competition selectCompetitionById(Long competitionId);

    List<Competition> selectCompetitionList(Competition competition);

    List<Competition> selectCompetitionManageList(Competition competition);

    int insertCompetition(Competition competition);

    int updateCompetition(Competition competition);

    int deleteCompetitionByIds(Long[] competitionIds);

    int updatePublishStatus(Competition competition);

    boolean incrementParticipants(Long competitionId);

    void decrementParticipants(Long competitionId);
}
