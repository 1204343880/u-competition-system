package com.ruoyi.system.service.impl;

import java.util.List;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import com.ruoyi.system.domain.UserNotification;
import com.ruoyi.system.mapper.UserNotificationMapper;
import com.ruoyi.system.service.IUserNotificationService;

@Service
public class UserNotificationServiceImpl implements IUserNotificationService
{
    @Autowired
    private UserNotificationMapper notificationMapper;

    @Override
    public int insertNotification(UserNotification notification)
    {
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
    public int deleteByIds(Long[] ids)
    {
        return notificationMapper.deleteByIds(ids);
    }
}
