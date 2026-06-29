package com.ruoyi.system.service.impl;

import java.util.Date;
import java.util.List;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import com.ruoyi.common.exception.ServiceException;
import com.ruoyi.system.domain.UserNotification;
import com.ruoyi.system.mapper.UserNotificationMapper;
import com.ruoyi.system.service.IUserNotificationService;

@Service
public class UserNotificationServiceImpl implements IUserNotificationService
{
    private static final Logger log = LoggerFactory.getLogger(UserNotificationServiceImpl.class);

    @Autowired
    private UserNotificationMapper notificationMapper;

    @Override
    public int insertNotification(UserNotification notification)
    {
        if (notification == null)
        {
            throw new ServiceException("Notification message must not be null");
        }
        if (notification.getUserId() == null)
        {
            throw new ServiceException("Notification userId must not be null");
        }
        if (notification.getBizType() == null || notification.getBizType().trim().isEmpty())
        {
            throw new ServiceException("Notification bizType must not be empty");
        }
        if (notification.getTitle() == null || notification.getTitle().trim().isEmpty())
        {
            throw new ServiceException("Notification title must not be empty");
        }
        if (notification.getIsRead() == null)
        {
            notification.setIsRead("0");
        }
        if (notification.getCreateTime() == null)
        {
            notification.setCreateTime(new Date());
        }
        log.info("Persisting notification: userId={}, bizType={}, bizId={}, title={}",
                notification.getUserId(), notification.getBizType(), notification.getBizId(), notification.getTitle());
        return notificationMapper.insertNotification(notification);
    }

    @Override
    public List<UserNotification> selectNotificationsByUserId(Long userId)
    {
        return notificationMapper.selectNotificationsByUserId(userId);
    }

    @Override
    public int selectUnreadCount(Long userId)
    {
        return notificationMapper.selectUnreadCount(userId);
    }

    @Override
    public int markAsRead(Long id, Long userId)
    {
        return notificationMapper.markAsRead(id, userId);
    }

    @Override
    public int markAllAsRead(Long userId)
    {
        return notificationMapper.markAllAsRead(userId);
    }

    @Override
    public int deleteByIds(Long[] ids, Long userId)
    {
        return notificationMapper.deleteByIds(ids, userId);
    }
}
