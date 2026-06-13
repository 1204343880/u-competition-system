package com.ruoyi.system.domain;

import java.util.Date;
import com.fasterxml.jackson.annotation.JsonFormat;
import com.ruoyi.common.core.domain.BaseEntity;

public class CompetitionApply extends BaseEntity
{
    private static final long serialVersionUID = 1L;

    private Long applyId;

    private Long competitionId;

    private Long userId;

    private String userName;

    private String nickName;

    private String teamName;

    private String teamMembers;

    @JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss")
    private Date applyTime;

    private String auditStatus;

    @JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss")
    private Date auditTime;

    private String auditRemark;

    private String auditBy;

    private String delFlag;

    private String competitionName;

    private String compStatus;

    private String categoryName;

    private String category;

    public Long getApplyId()
    {
        return applyId;
    }

    public void setApplyId(Long applyId)
    {
        this.applyId = applyId;
    }

    public Long getCompetitionId()
    {
        return competitionId;
    }

    public void setCompetitionId(Long competitionId)
    {
        this.competitionId = competitionId;
    }

    public Long getUserId()
    {
        return userId;
    }

    public void setUserId(Long userId)
    {
        this.userId = userId;
    }

    public String getUserName()
    {
        return userName;
    }

    public void setUserName(String userName)
    {
        this.userName = userName;
    }

    public String getNickName()
    {
        return nickName;
    }

    public void setNickName(String nickName)
    {
        this.nickName = nickName;
    }

    public String getTeamName()
    {
        return teamName;
    }

    public void setTeamName(String teamName)
    {
        this.teamName = teamName;
    }

    public String getTeamMembers()
    {
        return teamMembers;
    }

    public void setTeamMembers(String teamMembers)
    {
        this.teamMembers = teamMembers;
    }

    public Date getApplyTime()
    {
        return applyTime;
    }

    public void setApplyTime(Date applyTime)
    {
        this.applyTime = applyTime;
    }

    public String getAuditStatus()
    {
        return auditStatus;
    }

    public void setAuditStatus(String auditStatus)
    {
        this.auditStatus = auditStatus;
    }

    public Date getAuditTime()
    {
        return auditTime;
    }

    public void setAuditTime(Date auditTime)
    {
        this.auditTime = auditTime;
    }

    public String getAuditRemark()
    {
        return auditRemark;
    }

    public void setAuditRemark(String auditRemark)
    {
        this.auditRemark = auditRemark;
    }

    public String getAuditBy()
    {
        return auditBy;
    }

    public void setAuditBy(String auditBy)
    {
        this.auditBy = auditBy;
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

    public String getCompStatus()
    {
        return compStatus;
    }

    public void setCompStatus(String compStatus)
    {
        this.compStatus = compStatus;
    }

    public String getCategoryName()
    {
        return categoryName;
    }

    public void setCategoryName(String categoryName)
    {
        this.categoryName = categoryName;
    }

    public String getCategory()
    {
        return category;
    }

    public void setCategory(String category)
    {
        this.category = category;
    }
}
