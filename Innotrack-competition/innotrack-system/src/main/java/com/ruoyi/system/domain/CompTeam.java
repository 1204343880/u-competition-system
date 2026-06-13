package com.ruoyi.system.domain;

import java.util.Date;
import com.fasterxml.jackson.annotation.JsonFormat;
import com.ruoyi.common.core.domain.BaseEntity;

public class CompTeam extends BaseEntity
{
    private static final long serialVersionUID = 1L;

    private Long teamId;

    private Long competitionId;

    private String teamName;

    private Long leaderId;

    private String leaderName;

    private Long teacherId;

    private String teacherName;

    private String inviteCode;

    private String status;

    private Integer maxMembers;

    private Integer currentMembers;

    private String isPublic;

    private String neededSkills;

    private String delFlag;

    private String competitionName;

    private String compStatus;

    private String categoryName;

    private String category;

    private String userRole;

    @JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss")
    private Date joinTime;

    public Long getTeamId()
    {
        return teamId;
    }

    public void setTeamId(Long teamId)
    {
        this.teamId = teamId;
    }

    public Long getCompetitionId()
    {
        return competitionId;
    }

    public void setCompetitionId(Long competitionId)
    {
        this.competitionId = competitionId;
    }

    public String getTeamName()
    {
        return teamName;
    }

    public void setTeamName(String teamName)
    {
        this.teamName = teamName;
    }

    public Long getLeaderId()
    {
        return leaderId;
    }

    public void setLeaderId(Long leaderId)
    {
        this.leaderId = leaderId;
    }

    public String getLeaderName()
    {
        return leaderName;
    }

    public void setLeaderName(String leaderName)
    {
        this.leaderName = leaderName;
    }

    public Long getTeacherId()
    {
        return teacherId;
    }

    public void setTeacherId(Long teacherId)
    {
        this.teacherId = teacherId;
    }

    public String getTeacherName()
    {
        return teacherName;
    }

    public void setTeacherName(String teacherName)
    {
        this.teacherName = teacherName;
    }

    public String getInviteCode()
    {
        return inviteCode;
    }

    public void setInviteCode(String inviteCode)
    {
        this.inviteCode = inviteCode;
    }

    public String getStatus()
    {
        return status;
    }

    public void setStatus(String status)
    {
        this.status = status;
    }

    public Integer getMaxMembers()
    {
        return maxMembers;
    }

    public void setMaxMembers(Integer maxMembers)
    {
        this.maxMembers = maxMembers;
    }

    public Integer getCurrentMembers()
    {
        return currentMembers;
    }

    public void setCurrentMembers(Integer currentMembers)
    {
        this.currentMembers = currentMembers;
    }

    public String getIsPublic()
    {
        return isPublic;
    }

    public void setIsPublic(String isPublic)
    {
        this.isPublic = isPublic;
    }

    public String getNeededSkills()
    {
        return neededSkills;
    }

    public void setNeededSkills(String neededSkills)
    {
        this.neededSkills = neededSkills;
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

    public String getUserRole()
    {
        return userRole;
    }

    public void setUserRole(String userRole)
    {
        this.userRole = userRole;
    }

    public Date getJoinTime()
    {
        return joinTime;
    }

    public void setJoinTime(Date joinTime)
    {
        this.joinTime = joinTime;
    }
}
