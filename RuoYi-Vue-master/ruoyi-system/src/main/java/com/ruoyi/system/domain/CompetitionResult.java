package com.ruoyi.system.domain;

import java.util.Date;
import com.fasterxml.jackson.annotation.JsonFormat;
import com.ruoyi.common.core.domain.BaseEntity;

public class CompetitionResult extends BaseEntity
{
    private static final long serialVersionUID = 1L;

    private Long resultId;

    private Long competitionId;

    private Long teamId;

    private Long userId;

    private String projectName;

    private String awardLevel;

    private Integer ranking;

    private Double score;

    private String certificateUrl;

    private String certificateHash;

    private String resultStatus;

    private String auditBy;

    @JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss")
    private Date auditTime;

    private String delFlag;

    private String competitionName;

    private String teamName;

    private String userName;

    public Long getResultId()
    {
        return resultId;
    }

    public void setResultId(Long resultId)
    {
        this.resultId = resultId;
    }

    public Long getCompetitionId()
    {
        return competitionId;
    }

    public void setCompetitionId(Long competitionId)
    {
        this.competitionId = competitionId;
    }

    public Long getTeamId()
    {
        return teamId;
    }

    public void setTeamId(Long teamId)
    {
        this.teamId = teamId;
    }

    public Long getUserId()
    {
        return userId;
    }

    public void setUserId(Long userId)
    {
        this.userId = userId;
    }

    public String getProjectName()
    {
        return projectName;
    }

    public void setProjectName(String projectName)
    {
        this.projectName = projectName;
    }

    public String getAwardLevel()
    {
        return awardLevel;
    }

    public void setAwardLevel(String awardLevel)
    {
        this.awardLevel = awardLevel;
    }

    public Integer getRanking()
    {
        return ranking;
    }

    public void setRanking(Integer ranking)
    {
        this.ranking = ranking;
    }

    public Double getScore()
    {
        return score;
    }

    public void setScore(Double score)
    {
        this.score = score;
    }

    public String getCertificateUrl()
    {
        return certificateUrl;
    }

    public void setCertificateUrl(String certificateUrl)
    {
        this.certificateUrl = certificateUrl;
    }

    public String getCertificateHash()
    {
        return certificateHash;
    }

    public void setCertificateHash(String certificateHash)
    {
        this.certificateHash = certificateHash;
    }

    public String getResultStatus()
    {
        return resultStatus;
    }

    public void setResultStatus(String resultStatus)
    {
        this.resultStatus = resultStatus;
    }

    public String getAuditBy()
    {
        return auditBy;
    }

    public void setAuditBy(String auditBy)
    {
        this.auditBy = auditBy;
    }

    public Date getAuditTime()
    {
        return auditTime;
    }

    public void setAuditTime(Date auditTime)
    {
        this.auditTime = auditTime;
    }

    public String getDelFlag()
    {
        return delFlag;
    }

    public void setDelFlag(String delFlag)
    {
        this.delFlag = delFlag;
    }

    public String getCompetitionName()
    {
        return competitionName;
    }

    public void setCompetitionName(String competitionName)
    {
        this.competitionName = competitionName;
    }

    public String getTeamName()
    {
        return teamName;
    }

    public void setTeamName(String teamName)
    {
        this.teamName = teamName;
    }

    public String getUserName()
    {
        return userName;
    }

    public void setUserName(String userName)
    {
        this.userName = userName;
    }
}
