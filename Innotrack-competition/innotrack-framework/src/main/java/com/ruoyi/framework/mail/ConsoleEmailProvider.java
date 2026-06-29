package com.ruoyi.framework.mail;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.boot.autoconfigure.condition.ConditionalOnMissingBean;
import org.springframework.stereotype.Component;
import com.ruoyi.common.mail.IEmailProvider;

@Component
@ConditionalOnMissingBean(SmtpEmailProvider.class)
public class ConsoleEmailProvider implements IEmailProvider
{
    private static final Logger log = LoggerFactory.getLogger(ConsoleEmailProvider.class);

    @Override
    public void sendVerificationCode(String to, String code)
    {
        log.info("【邮箱验证码】收件人: {} 验证码: {} (控制台模式，未配置SMTP)", to, code);
    }
}
