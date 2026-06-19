package com.ruoyi.system.mapper;

import java.util.List;
import com.ruoyi.system.domain.CompetitionExperience;
import org.apache.ibatis.annotations.Param;

public interface CompetitionExperienceMapper
{
    CompetitionExperience selectExperienceById(Long experienceId);

    List<CompetitionExperience> selectExperienceList(CompetitionExperience experience);

    List<CompetitionExperience> selectAuditList(CompetitionExperience experience);

    List<CompetitionExperience> selectMySubmissions(CompetitionExperience experience);

    List<CompetitionExperience> searchForAgent(@Param("query") String query);

    int insertExperience(CompetitionExperience experience);

    int updateExperience(CompetitionExperience experience);

    int deleteExperienceByIds(Long[] experienceIds);

    int incrementViewCount(Long experienceId);

    CompetitionExperience selectExperienceByIdRaw(Long experienceId);

    int auditExperience(CompetitionExperience experience);
}
