package com.ruoyi.framework.config;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.amqp.core.Binding;
import org.springframework.amqp.core.BindingBuilder;
import org.springframework.amqp.core.DirectExchange;
import org.springframework.amqp.core.Queue;
import org.springframework.amqp.rabbit.config.SimpleRabbitListenerContainerFactory;
import org.springframework.amqp.rabbit.connection.ConnectionFactory;
import org.springframework.amqp.rabbit.core.RabbitTemplate;
import org.springframework.amqp.support.converter.Jackson2JsonMessageConverter;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;

@Configuration
public class RabbitMqConfig
{
    private static final Logger log = LoggerFactory.getLogger(RabbitMqConfig.class);

    public static final String EXCHANGE_NAME = "competition.exchange";
    public static final String QUEUE_NOTIFICATION = "competition.notification.queue";
    public static final String ROUTING_KEY_NOTIFICATION = "competition.notification";

    @Bean
    public DirectExchange competitionExchange()
    {
        return new DirectExchange(EXCHANGE_NAME, true, false);
    }

    @Bean
    public Queue notificationQueue()
    {
        return new Queue(QUEUE_NOTIFICATION, true);
    }

    @Bean
    public Binding notificationBinding()
    {
        return BindingBuilder.bind(notificationQueue())
                .to(competitionExchange())
                .with(ROUTING_KEY_NOTIFICATION);
    }

    @Bean
    public Jackson2JsonMessageConverter jackson2JsonMessageConverter()
    {
        return new Jackson2JsonMessageConverter();
    }

    @Bean
    public RabbitTemplate rabbitTemplate(ConnectionFactory connectionFactory,
            Jackson2JsonMessageConverter jackson2JsonMessageConverter)
    {
        RabbitTemplate template = new RabbitTemplate(connectionFactory);
        template.setMessageConverter(jackson2JsonMessageConverter);
        template.setConfirmCallback((correlationData, ack, cause) -> {
            if (!ack)
            {
                log.error("RabbitMQ message confirm failed: {}", cause);
            }
        });
        return template;
    }

    @Bean
    public SimpleRabbitListenerContainerFactory rabbitListenerContainerFactory(ConnectionFactory connectionFactory,
            Jackson2JsonMessageConverter jackson2JsonMessageConverter)
    {
        SimpleRabbitListenerContainerFactory factory = new SimpleRabbitListenerContainerFactory();
        factory.setConnectionFactory(connectionFactory);
        factory.setMessageConverter(jackson2JsonMessageConverter);
        // 队列不可用时不停止监听容器，支持断连后自动恢复
        factory.setMissingQueuesFatal(false);
        // 连续 5 次活跃后触发重启检测，连续 5 次空闲后触发重启检测
        factory.setConsecutiveActiveTrigger(5);
        factory.setConsecutiveIdleTrigger(5);
        return factory;
    }
}
