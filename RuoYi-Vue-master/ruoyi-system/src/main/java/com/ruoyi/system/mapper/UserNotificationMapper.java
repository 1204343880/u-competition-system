package com.ruoyi.system.mapper;

import java.util.List;
import com.ruoyi.system.domain.UserNotification;

public interface UserNotificationMapper
{
    int insertNotification(UserNotification notification);

    List<UserNotification> selectNotificationsByUserId(Long userId);

    int selectUnreadCount(Long userId);

    int markAsRead(Long id, Long userId);

    int markAllAsRead(Long userId);

    int deleteByIds(Long[] ids);
}
