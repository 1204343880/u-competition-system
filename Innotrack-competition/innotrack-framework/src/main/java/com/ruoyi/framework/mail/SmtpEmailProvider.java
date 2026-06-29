package com.ruoyi.framework.mail;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.boot.autoconfigure.condition.ConditionalOnProperty;
import org.springframework.mail.SimpleMailMessage;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.stereotype.Component;
import com.ruoyi.common.mail.IEmailProvider;

@Component
@ConditionalOnProperty(name = "spring.mail.host")
public class SmtpEmailProvider implements IEmailProvider
{
    private static final Logger log = LoggerFactory.getLogger(SmtpEmailProvider.class);

    private final JavaMailSender mailSender;

    @Value("${spring.mail.username}")
    private String from;

    public SmtpEmailProvider(JavaMailSender mailSender)
    {
        this.mailSender = mailSender;
    }

    @Override
    public void sendVerificationCode(String to, String code)
    {
        SimpleMailMessage message = new SimpleMailMessage();
        message.setFrom(from);
        message.setTo(to);
        message.setSubject("学科竞赛管理系统 - 邮箱验证码");
        message.setText("您的验证码是：" + code + "，有效期 5 分钟，请勿泄露。");
        mailSender.send(message);
        log.info("【邮箱验证码已发送】收件人: {}", to);
    }
}
