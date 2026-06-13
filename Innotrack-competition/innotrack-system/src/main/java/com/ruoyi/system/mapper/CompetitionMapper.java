package com.ruoyi.system.mapper;

import java.util.List;
import com.ruoyi.system.domain.Competition;

public interface CompetitionMapper
{
    Competition selectCompetitionById(Long competitionId);

    List<Competition> selectCompetitionList(Competition competition);

    List<Competition> selectCompetitionManageList(Competition competition);

    int insertCompetition(Competition competition);

    int updateCompetition(Competition competition);

    int deleteCompetitionByIds(Long[] competitionIds);

    int updatePublishStatus(Competition competition);

    int incrementParticipants(Long competitionId);

    int decrementParticipants(Long competitionId);
}
