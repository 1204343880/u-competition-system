package com.ruoyi.system.domain;

import java.util.Date;
import com.fasterxml.jackson.annotation.JsonFormat;

public class TeamInvitationRecord
{
    private Long id;

    private Long teamId;

    private Long inviterId;

    private Long inviteeId;

    private String status;

    @JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss")
    private Date createTime;

    @JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss")
    private Date updateTime;

    private String teamName;

    private String inviterName;

    private String inviteeName;

    private String competitionName;

    public Long getId()
    {
        return id;
    }

    public void setId(Long id)
    {
        this.id = id;
    }

    public Long getTeamId()
    {
        return teamId;
    }

    public void setTeamId(Long teamId)
    {
        this.teamId = teamId;
    }

    public Long getInviterId()
    {
        return inviterId;
    }

    public void setInviterId(Long inviterId)
    {
        this.inviterId = inviterId;
    }

    public Long getInviteeId()
    {
        return inviteeId;
    }

    public void setInviteeId(Long inviteeId)
    {
        this.inviteeId = inviteeId;
    }

    public String getStatus()
    {
        return status;
    }

    public void setStatus(String status)
    {
        this.status = status;
    }

    public Date getCreateTime()
    {
        return createTime;
    }

    public void setCreateTime(Date createTime)
    {
        this.createTime = createTime;
    }

    public Date getUpdateTime()
    {
        return updateTime;
    }

    public void setUpdateTime(Date updateTime)
    {
        this.updateTime = updateTime;
    }

    public String getTeamName()
    {
        return teamName;
    }

    public void setTeamName(String teamName)
    {
        this.teamName = teamName;
    }

    public String getInviterName()
    {
        return inviterName;
    }

    public void setInviterName(String inviterName)
    {
        this.inviterName = inviterName;
    }

    public String getInviteeName()
    {
        return inviteeName;
    }

    public void setInviteeName(String inviteeName)
    {
        this.inviteeName = inviteeName;
    }

    public String getCompetitionName()
    {
        return competitionName;
    }

    public void setCompetitionName(String competitionName)
    {
        this.competitionName = competitionName;
    }
}
