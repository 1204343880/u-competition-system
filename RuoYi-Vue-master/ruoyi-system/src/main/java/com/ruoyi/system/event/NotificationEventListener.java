package com.ruoyi.system.event;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.event.EventListener;
import org.springframework.stereotype.Component;
import org.springframework.transaction.event.TransactionPhase;
import org.springframework.transaction.event.TransactionalEventListener;
import com.ruoyi.common.core.redis.RedisCache;
import com.ruoyi.system.domain.UserNotification;
import com.ruoyi.system.mapper.UserNotificationMapper;

@Component
public class NotificationEventListener
{
    @Autowired
    private UserNotificationMapper notificationMapper;

    @Autowired
    private RedisCache redisCache;

    private static final String UNREAD_COUNT_KEY = "notification:unread:";

    @SuppressWarnings("unchecked")
    @TransactionalEventListener(phase = TransactionPhase.AFTER_COMMIT)
    public void handleNotification(NotificationEvent event)
    {
        UserNotification notification = new UserNotification();
        notification.setUserId(event.getUserId());
        notification.setBizType(event.getBizType());
        notification.setBizId(event.getBizId());
        notification.setTitle(event.getTitle());
        notification.setContent(event.getContent());
        notificationMapper.insertNotification(notification);

        String key = UNREAD_COUNT_KEY + event.getUserId();
        redisCache.redisTemplate.opsForValue().increment(key, 1);
    }

    @EventListener
    public void handleNotificationSync(NotificationEvent event)
    {
    }
}
