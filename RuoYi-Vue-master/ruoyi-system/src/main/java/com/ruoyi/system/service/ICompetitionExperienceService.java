package com.ruoyi.system.service;

import java.util.List;
import com.ruoyi.system.domain.CompetitionExperience;

public interface ICompetitionExperienceService
{
    CompetitionExperience selectExperienceById(Long experienceId);

    List<CompetitionExperience> selectExperienceList(CompetitionExperience experience);

    List<CompetitionExperience> selectAuditList(CompetitionExperience experience);

    List<CompetitionExperience> selectMySubmissions(CompetitionExperience experience);

    int insertExperience(CompetitionExperience experience);

    int updateExperience(CompetitionExperience experience);

    int deleteExperienceByIds(Long[] experienceIds);

    int incrementViewCount(Long experienceId);

    CompetitionExperience selectExperienceByIdRaw(Long experienceId);

    int auditExperience(CompetitionExperience experience);
}
