package com.ruoyi.framework.mq;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.amqp.rabbit.core.RabbitTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;
import com.ruoyi.framework.config.RabbitMqConfig;
import com.ruoyi.system.domain.UserNotification;
import com.ruoyi.system.service.IUserNotificationService;

@Component
public class RabbitMqProducer
{
    private static final Logger log = LoggerFactory.getLogger(RabbitMqProducer.class);

    private static final int MAX_RETRIES = 3;
    private static final long[] BACKOFF_MS = {1000, 2000, 4000};

    @Autowired
    private RabbitTemplate rabbitTemplate;

    @Autowired
    private IUserNotificationService userNotificationService;

    public void sendNotification(UserNotification notification)
    {
        log.info("Publishing notification: userId={}, bizType={}, bizId={}, title={}",
                notification == null ? null : notification.getUserId(),
                notification == null ? null : notification.getBizType(),
                notification == null ? null : notification.getBizId(),
                notification == null ? null : notification.getTitle());

        // 手动重试（指数退避 1s / 2s / 4s）
        for (int attempt = 1; attempt <= MAX_RETRIES; attempt++)
        {
            try
            {
                rabbitTemplate.convertAndSend(
                        RabbitMqConfig.EXCHANGE_NAME,
                        RabbitMqConfig.ROUTING_KEY_NOTIFICATION,
                        notification);
                return; // 发送成功
            }
            catch (Exception e)
            {
                log.warn("RabbitMQ send attempt {}/{} failed: {}", attempt, MAX_RETRIES, e.getMessage());
                if (attempt < MAX_RETRIES)
                {
                    try { Thread.sleep(BACKOFF_MS[attempt - 1]); }
                    catch (InterruptedException ie) { Thread.currentThread().interrupt(); }
                }
            }
        }

        // 重试耗尽后降级：直接持久化到数据库，确保通知不丢失
        log.error("RabbitMQ send failed after {} retries, falling back to DB persist: userId={}, bizType={}, bizId={}",
                MAX_RETRIES, notification.getUserId(), notification.getBizType(), notification.getBizId());
        try
        {
            userNotificationService.insertNotification(notification);
            log.warn("Notification persisted to DB successfully after RabbitMQ failure");
        }
        catch (Exception dbEx)
        {
            log.error("DB fallback also failed for notification: userId={}, bizType={}, bizId={}",
                    notification.getUserId(), notification.getBizType(), notification.getBizId(), dbEx);
        }
    }
}
