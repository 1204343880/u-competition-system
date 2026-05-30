package com.ruoyi.competition.domain;

import java.util.Date;
import com.fasterxml.jackson.annotation.JsonFormat;
import org.apache.commons.lang3.builder.ToStringBuilder;
import org.apache.commons.lang3.builder.ToStringStyle;
import com.ruoyi.common.annotation.Excel;
import com.ruoyi.common.core.domain.BaseEntity;

/**
 * 竞赛信息对象 competition
 * 
 * @author ruoyi
 * @date 2026-05-28
 */
public class Competition extends BaseEntity
{
    private static final long serialVersionUID = 1L;

    /** 竞赛ID */
    private Long competitionId;

    /** 竞赛名称 */
    @Excel(name = "竞赛名称")
    private String competitionName;

    /** 竞赛类别 */
    @Excel(name = "竞赛类别")
    private String category;

    /** 类别名称 */
    @Excel(name = "类别名称")
    private String categoryName;

    /** 竞赛描述 */
    @Excel(name = "竞赛描述")
    private String description;

    /** 报名开始时间 */
    @JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss")
    @Excel(name = "报名开始时间", width = 30, dateFormat = "yyyy-MM-dd HH:mm:ss")
    private Date applyStartTime;

    /** 报名结束时间 */
    @JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss")
    @Excel(name = "报名结束时间", width = 30, dateFormat = "yyyy-MM-dd HH:mm:ss")
    private Date applyEndTime;

    /** 竞赛开始时间 */
    @JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss")
    @Excel(name = "竞赛开始时间", width = 30, dateFormat = "yyyy-MM-dd HH:mm:ss")
    private Date startTime;

    /** 竞赛结束时间 */
    @JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss")
    @Excel(name = "竞赛结束时间", width = 30, dateFormat = "yyyy-MM-dd HH:mm:ss")
    private Date endTime;

    /** 竞赛状态（0报名中 1进行中 2已结束） */
    @Excel(name = "竞赛状态", readConverterExp = "0=报名中,1=进行中,2=已结束")
    private String status;

    /** 主办方 */
    @Excel(name = "主办方")
    private String organizer;

    /** 承办方 */
    @Excel(name = "承办方")
    private String host;

    /** 参赛人数限制 */
    @Excel(name = "参赛人数限制")
    private Integer maxParticipants;

    /** 当前报名人数 */
    @Excel(name = "当前报名人数")
    private Integer currentParticipants;

    /** 删除标志（0代表存在 2代表删除） */
    private String delFlag;

    /** 报名时间（用于我的竞赛列表） */
    @JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss")
    private Date applyTime;

    public void setCompetitionId(Long competitionId) 
    {
        this.competitionId = competitionId;
    }

    public Long getCompetitionId() 
    {
        return competitionId;
    }

    public void setCompetitionName(String competitionName) 
    {
        this.competitionName = competitionName;
    }

    public String getCompetitionName() 
    {
        return competitionName;
    }

    public void setCategory(String category) 
    {
        this.category = category;
    }

    public String getCategory() 
    {
        return category;
    }

    public void setCategoryName(String categoryName) 
    {
        this.categoryName = categoryName;
    }

    public String getCategoryName() 
    {
        return categoryName;
    }

    public void setDescription(String description) 
    {
        this.description = description;
    }

    public String getDescription() 
    {
        return description;
    }

    public void setApplyStartTime(Date applyStartTime) 
    {
        this.applyStartTime = applyStartTime;
    }

    public Date getApplyStartTime() 
    {
        return applyStartTime;
    }

    public void setApplyEndTime(Date applyEndTime) 
    {
        this.applyEndTime = applyEndTime;
    }

    public Date getApplyEndTime() 
    {
        return applyEndTime;
    }

    public void setStartTime(Date startTime) 
    {
        this.startTime = startTime;
    }

    public Date getStartTime() 
    {
        return startTime;
    }

    public void setEndTime(Date endTime) 
    {
        this.endTime = endTime;
    }

    public Date getEndTime() 
    {
        return endTime;
    }

    public void setStatus(String status) 
    {
        this.status = status;
    }

    public String getStatus() 
    {
        return status;
    }

    public void setOrganizer(String organizer) 
    {
        this.organizer = organizer;
    }

    public String getOrganizer() 
    {
        return organizer;
    }

    public void setHost(String host) 
    {
        this.host = host;
    }

    public String getHost() 
    {
        return host;
    }

    public void setMaxParticipants(Integer maxParticipants) 
    {
        this.maxParticipants = maxParticipants;
    }

    public Integer getMaxParticipants() 
    {
        return maxParticipants;
    }

    public void setCurrentParticipants(Integer currentParticipants) 
    {
        this.currentParticipants = currentParticipants;
    }

    public Integer getCurrentParticipants() 
    {
        return currentParticipants;
    }

    public void setDelFlag(String delFlag) 
    {
        this.delFlag = delFlag;
    }

    public String getDelFlag() 
    {
        return delFlag;
    }

    public void setApplyTime(Date applyTime) 
    {
        this.applyTime = applyTime;
    }

    public Date getApplyTime() 
    {
        return applyTime;
    }

    @Override
    public String toString() {
        return new ToStringBuilder(this,ToStringStyle.MULTI_LINE_STYLE)
            .append("competitionId", getCompetitionId())
            .append("competitionName", getCompetitionName())
            .append("category", getCategory())
            .append("categoryName", getCategoryName())
            .append("description", getDescription())
            .append("applyStartTime", getApplyStartTime())
            .append("applyEndTime", getApplyEndTime())
            .append("startTime", getStartTime())
            .append("endTime", getEndTime())
            .append("status", getStatus())
            .append("organizer", getOrganizer())
            .append("host", getHost())
            .append("maxParticipants", getMaxParticipants())
            .append("currentParticipants", getCurrentParticipants())
            .append("delFlag", getDelFlag())
            .append("applyTime", getApplyTime())
            .append("createBy", getCreateBy())
            .append("createTime", getCreateTime())
            .append("updateBy", getUpdateBy())
            .append("updateTime", getUpdateTime())
            .toString();
    }
}