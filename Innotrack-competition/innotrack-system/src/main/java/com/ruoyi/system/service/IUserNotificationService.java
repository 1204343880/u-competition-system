package com.ruoyi.system.service;

import java.util.List;
import com.ruoyi.system.domain.UserNotification;

public interface IUserNotificationService
{
    int insertNotification(UserNotification notification);

    List<UserNotification> selectNotificationsByUserId(Long userId);

    int selectUnreadCount(Long userId);

    int markAsRead(Long id, Long userId);

    int markAllAsRead(Long userId);

    int deleteByIds(Long[] ids);
}
