package com.ruoyi;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.boot.jdbc.autoconfigure.DataSourceAutoConfiguration;
import org.springframework.amqp.rabbit.annotation.EnableRabbit;

/**
 * 启动程序
 * 
 * @author ruoyi
 */
@SpringBootApplication(exclude = { DataSourceAutoConfiguration.class })
@EnableRabbit
public class **确认，问题 100% 就是这两个。**

        ### 🚨 问题 1：`ruoyi.scss:509` — 未定义变量

```scss
// ruoyi.scss 文件头：没有 @use
// ...
        .inno-card {
    transition: box-shadow $transition-fast ease;  // ← $transition-fast 不存在！
}
```

        `$transition-fast` 定义在 `variables.module.scss`，但 `ruoyi.scss` **没有 `@use` 导入**。Dart Sass 不会跨文件泄漏变量，编译直接抛出 `Undefined variable`。

        → **修复**：文件头加一行 `@use './variables.module.scss' as *;`

        ### 🚨 问题 2：`Skeleton/index.vue:124` — `@extend` 在 scoped CSS 中失效

```scss
        <style lang="scss" scoped>
        .skeleton-card-image {
    @extend .skeleton-line;   // ← scoped 下 @extend 行为不可靠
}
```

        Vue scoped 用 PostCSS 加 `data-v-xxx`，但 `@extend` 在 Sass 编译期合并选择器，打不到 scope 上。轻则动画不生效（卡片骨架没 shimmer），重则编译失败。

        → **修复**：去掉 `@extend`，把 `.skeleton-line` 的 background + animation 属性直接抄写在 `.skeleton-card-image` 上。

        ---

        ### 修复计划

| 文件 | 改动 | 1 行 |
        |------|------|------|
        | `ruoyi.scss` 文件头 | 加 `@use './variables.module.scss' as *;` | 1 行 |
        | `Skeleton/index.vue:124` | 替换 `@extend` 为直接属性（6 行） | 6 行 |

        要不要切执行模式修？RuoYiApplication
{
    public static void main(String[] args)
    {
        // System.setProperty("spring.devtools.restart.enabled", "false");
        SpringApplication.run(RuoYiApplication.class, args);
        System.out.println("(♥◠‿◠)ﾉﾞ  若依启动成功   ლ(´ڡ`ლ)ﾞ  \n" +
                " .-------.       ____     __        \n" +
                " |  _ _   \\      \\   \\   /  /    \n" +
                " | ( ' )  |       \\  _. /  '       \n" +
                " |(_ o _) /        _( )_ .'         \n" +
                " | (_,_).' __  ___(_ o _)'          \n" +
                " |  |\\ \\  |  ||   |(_,_)'         \n" +
                " |  | \\ `'   /|   `-'  /           \n" +
                " |  |  \\    /  \\      /           \n" +
                " ''-'   `'-'    `-..-'              ");
    }
}
