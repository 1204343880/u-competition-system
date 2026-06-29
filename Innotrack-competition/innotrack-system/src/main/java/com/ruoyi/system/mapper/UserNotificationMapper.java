package com.ruoyi.system.mapper;

import java.util.List;
import org.apache.ibatis.annotations.Param;
import com.ruoyi.system.domain.UserNotification;

public interface UserNotificationMapper
{
    int insertNotification(UserNotification notification);

    List<UserNotification> selectNotificationsByUserId(Long userId);

    int selectUnreadCount(Long userId);

    int markAsRead(@Param("id") Long id, @Param("userId") Long userId);

    int markAllAsRead(Long userId);

    int deleteByIds(@Param("ids") Long[] ids, @Param("userId") Long userId);
}
