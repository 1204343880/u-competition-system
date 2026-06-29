package com.ruoyi.common.mail;

public interface IEmailProvider
{
    void sendVerificationCode(String to, String code);
}
