package com.ruoyi.web.core.config;

import java.util.List;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import com.ruoyi.common.config.RuoYiConfig;
import io.swagger.v3.oas.models.Components;
import io.swagger.v3.oas.models.OpenAPI;
import io.swagger.v3.oas.models.info.Contact;
import io.swagger.v3.oas.models.info.Info;
import io.swagger.v3.oas.models.security.SecurityRequirement;
import io.swagger.v3.oas.models.security.SecurityScheme;
import io.swagger.v3.oas.models.servers.Server;

/**
 * SpringDoc 接口配置
 *
 * @author ruoyi
 */
@Configuration
public class SwaggerConfig
{
    @Autowired
    private RuoYiConfig ruoyiConfig;

    @Bean
    public OpenAPI customOpenApi()
    {
        return new OpenAPI()
            .servers(List.of(new Server().url("/").description("本地服务")))
            .components(new Components()
            .addSecuritySchemes("apikey", securityScheme()))
            .addSecurityItem(new SecurityRequirement().addList("apikey"))
            .info(getApiInfo());
    }

    @Bean
    public SecurityScheme securityScheme()
    {
        return new SecurityScheme()
            .type(SecurityScheme.Type.APIKEY)
            .name("Authorization")
            .in(SecurityScheme.In.HEADER)
            .scheme("Bearer");
    }

    public Info getApiInfo()
    {
        return new Info()
            .title("学科竞赛管理系统 - 接口文档")
            .description("竞赛信息管理、报名、审核等功能模块接口")
            .contact(new Contact().name(ruoyiConfig.getName()))
            .version("v" + ruoyiConfig.getVersion());
    }
}
