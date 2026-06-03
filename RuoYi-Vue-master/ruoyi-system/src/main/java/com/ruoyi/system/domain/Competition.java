package com.ruoyi.system.domain;

import java.util.Date;
import com.fasterxml.jackson.annotation.JsonFormat;
import com.ruoyi.common.core.domain.BaseEntity;

public class Competition extends BaseEntity
{
    private static final long serialVersionUID = 1L;

    private Long competitionId;

    private String competitionName;

    private String category;

    private String categoryName;

    private String competitionType;

    private String competitionLevel;

    private String description;

    @JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss")
    private Date applyStartTime;

    @JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss")
    private Date applyEndTime;

    @JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss")
    private Date startTime;

    @JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss")
    private Date endTime;

    private String status;

    private String publishStatus;

    private String organizer;

    private String host;

    private Integer maxParticipants;

    private Integer currentParticipants;

    private Integer viewCount;

    private String tags;

    private String delFlag;

    public Long getCompetitionId()
    {
        return competitionId;
    }

    public void setCompetitionId(Long competitionId)
    {
        this.competitionId = competitionId;
    }

    public String getCompetitionName()
    {
        return competitionName;
    }

    public void setCompetitionName(String competitionName)
    {
        this.competitionName = competitionName;
    }

    public String getCategory()
    {
        return category;
    }

    public void setCategory(String category)
    {
        this.category = category;
    }

    public String getCategoryName()
    {
        return categoryName;
    }

    public void setCategoryName(String categoryName)
    {
        this.categoryName = categoryName;
    }

    public String getCompetitionType()
    {
        return competitionType;
    }

    public void setCompetitionType(String competitionType)
    {
        this.competitionType = competitionType;
    }

    public String getCompetitionLevel()
    {
        return competitionLevel;
    }

    public void setCompetitionLevel(String competitionLevel)
    {
        this.competitionLevel = competitionLevel;
    }

    public String getDescription()
    {
        return description;
    }

    public void setDescription(String description)
    {
        this.description = description;
    }

    public Date getApplyStartTime()
    {
        return applyStartTime;
    }

    public void setApplyStartTime(Date applyStartTime)
    {
        this.applyStartTime = applyStartTime;
    }

    public Date getApplyEndTime()
    {
        return applyEndTime;
    }

    public void setApplyEndTime(Date applyEndTime)
    {
        this.applyEndTime = applyEndTime;
    }

    public Date getStartTime()
    {
        return startTime;
    }

    public void setStartTime(Date startTime)
    {
        this.startTime = startTime;
    }

    public Date getEndTime()
    {
        return endTime;
    }

    public void setEndTime(Date endTime)
    {
        this.endTime = endTime;
    }

    public String getStatus()
    {
        return status;
    }

    public void setStatus(String status)
    {
        this.status = status;
    }

    public String getPublishStatus()
    {
        return publishStatus;
    }

    public void setPublishStatus(String publishStatus)
    {
        this.publishStatus = publishStatus;
    }

    public String getOrganizer()
    {
        return organizer;
    }

    public void setOrganizer(String organizer)
    {
        this.organizer = organizer;
    }

    public String getHost()
    {
        return host;
    }

    public void setHost(String host)
    {
        this.host = host;
    }

    public Integer getMaxParticipants()
    {
        return maxParticipants;
    }

    public void setMaxParticipants(Integer maxParticipants)
    {
        this.maxParticipants = maxParticipants;
    }

    public Integer getCurrentParticipants()
    {
        return currentParticipants;
    }

    public void setCurrentParticipants(Integer currentParticipants)
    {
        this.currentParticipants = currentParticipants;
    }

    public Integer getViewCount()
    {
        return viewCount;
    }

    public void setViewCount(Integer viewCount)
    {
        this.viewCount = viewCount;
    }

    public String getTags()
    {
        return tags;
    }

    public void setTags(String tags)
    {
        this.tags = tags;
    }

    public String getDelFlag()
    {
        return delFlag;
    }

    public void setDelFlag(String delFlag)
    {
        this.delFlag = delFlag;
    }
}
