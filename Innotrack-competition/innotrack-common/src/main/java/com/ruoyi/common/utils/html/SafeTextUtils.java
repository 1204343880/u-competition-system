package com.ruoyi.common.utils.html;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.regex.Pattern;
import com.ruoyi.common.exception.ServiceException;
import com.ruoyi.common.utils.StringUtils;

/**
 * 业务文本安全处理工具：统一处理富文本白名单、纯文本 XSS 拦截和长度校验。
 */
public class SafeTextUtils
{
    private static final Pattern HTML_TAG_PATTERN = Pattern.compile("<[^>]+>");
    private static final Pattern DANGEROUS_HTML_PATTERN = Pattern.compile(
            "(?i)<\\s*/?\\s*(script|iframe|object|embed|svg|math|style|link|meta|base)\\b|\\son\\w+\\s*=|javascript\\s*:|data\\s*:");

    private SafeTextUtils()
    {
    }

    public static String sanitizeRichText(String text)
    {
        if (StringUtils.isEmpty(text))
        {
            return text;
        }
        return new HTMLFilter(richTextConfig()).filter(text.trim());
    }

    public static String sanitizePlainText(String fieldName, String text)
    {
        if (StringUtils.isEmpty(text))
        {
            return text;
        }
        String trimmed = text.trim();
        if (HTML_TAG_PATTERN.matcher(trimmed).find() || DANGEROUS_HTML_PATTERN.matcher(trimmed).find())
        {
            throw new ServiceException(fieldName + "不能包含HTML标签或脚本内容");
        }
        return trimmed;
    }

    public static void validateLength(String fieldName, String text, int maxLength)
    {
        if (text != null && text.length() > maxLength)
        {
            throw new ServiceException(fieldName + "长度不能超过" + maxLength + "个字符");
        }
    }

    private static Map<String, Object> richTextConfig()
    {
        Map<String, List<String>> allowed = new HashMap<>();
        List<String> noAttrs = new ArrayList<>();
        allowed.put("p", noAttrs);
        allowed.put("br", noAttrs);
        allowed.put("ul", noAttrs);
        allowed.put("ol", noAttrs);
        allowed.put("li", noAttrs);
        allowed.put("b", noAttrs);
        allowed.put("strong", noAttrs);
        allowed.put("i", noAttrs);
        allowed.put("em", noAttrs);

        List<String> aAttrs = new ArrayList<>();
        aAttrs.add("href");
        aAttrs.add("target");
        allowed.put("a", aAttrs);

        List<String> imgAttrs = new ArrayList<>();
        imgAttrs.add("src");
        imgAttrs.add("width");
        imgAttrs.add("height");
        imgAttrs.add("alt");
        allowed.put("img", imgAttrs);

        Map<String, Object> conf = new HashMap<>();
        conf.put("vAllowed", allowed);
        conf.put("vSelfClosingTags", new String[] { "img", "br" });
        conf.put("vNeedClosingTags", new String[] { "p", "ul", "ol", "li", "a", "b", "strong", "i", "em" });
        conf.put("vDisallowed", new String[] {});
        conf.put("vAllowedProtocols", new String[] { "http", "https", "mailto" });
        conf.put("vProtocolAtts", new String[] { "src", "href" });
        conf.put("vRemoveBlanks", new String[] { "a", "b", "strong", "i", "em" });
        conf.put("vAllowedEntities", new String[] { "amp", "gt", "lt", "quot" });
        conf.put("stripComment", true);
        conf.put("encodeQuotes", true);
        conf.put("alwaysMakeTags", false);
        return conf;
    }
}
