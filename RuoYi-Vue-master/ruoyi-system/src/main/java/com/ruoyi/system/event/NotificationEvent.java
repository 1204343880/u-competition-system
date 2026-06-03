package com.ruoyi.system.event;

public class NotificationEvent
{
    private Long userId;

    private String bizType;

    private Long bizId;

    private String title;

    private String content;

    public NotificationEvent(Long userId, String bizType, Long bizId, String title, String content)
    {
        this.userId = userId;
        this.bizType = bizType;
        this.bizId = bizId;
        this.title = title;
        this.content = content;
    }

    public Long getUserId()
    {
        return userId;
    }

    public String getBizType()
    {
        return bizType;
    }

    public Long getBizId()
    {
        return bizId;
    }

    public String getTitle()
    {
        return title;
    }

    public String getContent()
    {
        return content;
    }
}
