package com.ruoyi.framework.mq;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.amqp.rabbit.annotation.RabbitListener;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;
import com.ruoyi.framework.config.RabbitMqConfig;
import com.ruoyi.system.domain.UserNotification;
import com.ruoyi.system.service.IUserNotificationService;

@Component
public class NotificationConsumer
{
    private static final Logger log = LoggerFactory.getLogger(NotificationConsumer.class);

    @Autowired
    private IUserNotificationService userNotificationService;

    @RabbitListener(queues = RabbitMqConfig.QUEUE_NOTIFICATION)
    public void handleNotification(UserNotification notification)
    {
        try
        {
            userNotificationService.insertNotification(notification);
        }
        catch (Exception e)
        {
            log.error("处理通知消息失败: userId={}, bizType={}, title={}",
                    notification.getUserId(), notification.getBizType(), notification.getTitle(), e);
            throw e;
        }
    }
}
