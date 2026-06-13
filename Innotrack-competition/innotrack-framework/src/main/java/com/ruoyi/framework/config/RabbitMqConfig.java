package com.ruoyi.framework.config;

import org.springframework.amqp.core.Binding;
import org.springframework.amqp.core.BindingBuilder;
import org.springframework.amqp.core.DirectExchange;
import org.springframework.amqp.core.Queue;
import org.springframework.amqp.rabbit.connection.ConnectionFactory;
import org.springframework.amqp.rabbit.core.RabbitTemplate;
import org.springframework.amqp.support.converter.Jackson2JsonMessageConverter;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;

@Configuration
public class RabbitMqConfig
{
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
    public RabbitTemplate rabbitTemplate(ConnectionFactory connectionFactory)
    {
        RabbitTemplate template = new RabbitTemplate(connectionFactory);
        template.setMessageConverter(new Jackson2JsonMessageConverter());
        template.setConfirmCallback((correlationData, ack, cause) -> {
            if (!ack)
            {
                System.err.println("RabbitMQ message confirm failed: " + cause);
            }
        });
        return template;
    }
}
