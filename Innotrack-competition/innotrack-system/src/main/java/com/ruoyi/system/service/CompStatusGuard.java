package com.ruoyi.system.service;

import org.springframework.stereotype.Component;
import com.ruoyi.common.exception.ServiceException;
import com.ruoyi.system.domain.CompStatus;
import com.ruoyi.system.domain.Competition;

/**
 * 竞赛状态守卫：统一校验入口，杜绝散落各处的 if ("0".equals(...))
 */
@Component
public class CompStatusGuard
{
    /**
     * 强制要求竞赛处于"报名中"状态
     */
    public void requireRegistering(Competition competition)
    {
        if (competition == null || competition.getStatus() != CompStatus.REGISTERING)
        {
            throw new ServiceException("当前竞赛不在报名阶段");
        }
    }

    /**
     * 校验状态转移是否合法
     */
    public void requireCanTransition(CompStatus current, CompStatus target)
    {
        if (current == null || target == null)
        {
            throw new ServiceException("状态参数不能为空");
        }
        if (!current.canTransitionTo(target))
        {
            throw new ServiceException(
                String.format("不允许从「%s」变更为「%s」", current.getLabel(), target.getLabel()));
        }
    }
}
