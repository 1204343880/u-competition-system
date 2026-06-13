package com.ruoyi.framework.mq;

import org.springframework.amqp.rabbit.core.RabbitTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;
import com.ruoyi.framework.config.RabbitMqConfig;
import com.ruoyi.system.domain.UserNotification;

@Component
public class RabbitMqProducer
{
    @Autowired
    private RabbitTemplate rabbitTemplate;

    public void sendNotification(UserNotification notification)
    {
        rabbitTemplate.convertAndSend(
                RabbitMqConfig.EXCHANGE_NAME,
                RabbitMqConfig.ROUTING_KEY_NOTIFICATION,
                notification);
    }
}
