package com.ruoyi.system.domain;

import com.fasterxml.jackson.annotation.JsonValue;
import com.ruoyi.common.exception.ServiceException;

/**
 * 竞赛生命周期状态（状态机模型）
 * code 对应数据库 CHAR(1) 字段，通过 TypeHandler 透明转换
 */
public enum CompStatus
{
    REGISTERING("0", "报名中"),
    IN_PROGRESS("1", "进行中"),
    FINISHED("2", "已结束"),
    PENDING("3", "待开赛");

    private final String code;
    private final String label;

    CompStatus(String code, String label)
    {
        this.code = code;
        this.label = label;
    }

    @JsonValue
    public String getCode() { return code; }
    public String getLabel() { return label; }

    /**
     * 状态转移规则
     */
    public boolean canTransitionTo(CompStatus target)
    {
        return switch (this)
        {
            case REGISTERING  -> target == PENDING || target == IN_PROGRESS;
            case PENDING      -> target == IN_PROGRESS || target == REGISTERING;
            case IN_PROGRESS  -> target == FINISHED;
            case FINISHED     -> target == IN_PROGRESS;
        };
    }

    public static CompStatus fromCode(String code)
    {
        for (CompStatus s : values())
        {
            if (s.code.equals(code)) return s;
        }
        throw new ServiceException("未知竞赛状态码: " + code);
    }
}
