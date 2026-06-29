package com.ruoyi.framework.mq;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.amqp.rabbit.annotation.RabbitListener;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;
import com.ruoyi.common.core.redis.RedisCache;
import com.ruoyi.common.exception.ServiceException;
import com.ruoyi.framework.config.RabbitMqConfig;
import com.ruoyi.system.domain.UserNotification;
import com.ruoyi.system.service.IUserNotificationService;

@Component
public class NotificationConsumer
{
    private static final Logger log = LoggerFactory.getLogger(NotificationConsumer.class);

    private static final String UNREAD_COUNT_KEY = "notification:unread:";

    @Autowired
    private IUserNotificationService userNotificationService;

    @Autowired
    private RedisCache redisCache;

    @RabbitListener(queues = RabbitMqConfig.QUEUE_NOTIFICATION)
    public void handleNotification(UserNotification notification)
    {
        try
        {
            validateNotification(notification);
            int rows = userNotificationService.insertNotification(notification);
            if (rows != 1)
            {
                log.error("Notification insert returned unexpected rows: rows={}, userId={}, bizType={}, bizId={}, title={}",
                        rows, notification.getUserId(), notification.getBizType(), notification.getBizId(),
                        notification.getTitle());
                throw new ServiceException("Notification insert failed");
            }
            refreshUnreadCount(notification.getUserId());
            log.info("Notification consumed and persisted: id={}, userId={}, bizType={}, bizId={}, title={}",
                    notification.getId(), notification.getUserId(), notification.getBizType(), notification.getBizId(),
                    notification.getTitle());
        }
        catch (Exception e)
        {
            log.error("Failed to consume notification: userId={}, bizType={}, bizId={}, title={}",
                    notification == null ? null : notification.getUserId(),
                    notification == null ? null : notification.getBizType(),
                    notification == null ? null : notification.getBizId(),
                    notification == null ? null : notification.getTitle(), e);
            throw e;
        }
    }

    private void validateNotification(UserNotification notification)
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
    }

    private void refreshUnreadCount(Long userId)
    {
        int count = userNotificationService.selectUnreadCount(userId);
        redisCache.setCacheObject(UNREAD_COUNT_KEY + userId, count);
    }
}
