package com.ruoyi.web.controller.system;

import java.util.HashMap;
import java.util.List;
import java.util.Map;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;
import com.ruoyi.common.core.controller.BaseController;
import com.ruoyi.common.core.domain.AjaxResult;
import com.ruoyi.common.core.domain.model.LoginUser;
import com.ruoyi.common.core.redis.RedisCache;
import com.ruoyi.common.utils.SecurityUtils;
import com.ruoyi.system.domain.UserNotification;
import com.ruoyi.system.service.IUserNotificationService;

@RestController
@RequestMapping("/system/notification")
public class SysNotificationController extends BaseController
{
    @Autowired
    private IUserNotificationService notificationService;

    @Autowired
    private RedisCache redisCache;

    private static final String UNREAD_COUNT_KEY = "notification:unread:";

    @GetMapping("/list")
    public AjaxResult list()
    {
        LoginUser loginUser = SecurityUtils.getLoginUser();
        if (loginUser == null)
        {
            return error("请先登录");
        }
        List<UserNotification> list = notificationService.selectNotificationsByUserId(loginUser.getUserId());
        return success(list);
    }

    @GetMapping("/unread")
    public AjaxResult unreadCount()
    {
        LoginUser loginUser = SecurityUtils.getLoginUser();
        if (loginUser == null)
        {
            return error("请先登录");
        }
        Long userId = loginUser.getUserId();
        String key = UNREAD_COUNT_KEY + userId;
        Integer cached = redisCache.getCacheObject(key);
        int count;
        if (cached != null)
        {
            count = cached;
        }
        else
        {
            count = notificationService.selectUnreadCount(userId);
            redisCache.redisTemplate.opsForValue().set(key, count);
        }
        Map<String, Integer> result = new HashMap<>();
        result.put("count", count);
        return success(result);
    }

    @PutMapping("/{id}/read")
    public AjaxResult read(@PathVariable Long id)
    {
        LoginUser loginUser = SecurityUtils.getLoginUser();
        if (loginUser == null)
        {
            return error("请先登录");
        }
        notificationService.markAsRead(id, loginUser.getUserId());
        String key = UNREAD_COUNT_KEY + loginUser.getUserId();
        redisCache.redisTemplate.opsForValue().decrement(key, 1);
        return success();
    }

    @PutMapping("/read-all")
    public AjaxResult readAll()
    {
        LoginUser loginUser = SecurityUtils.getLoginUser();
        if (loginUser == null)
        {
            return error("请先登录");
        }
        notificationService.markAllAsRead(loginUser.getUserId());
        String key = UNREAD_COUNT_KEY + loginUser.getUserId();
        redisCache.redisTemplate.opsForValue().set(key, 0);
        return success();
    }

    @DeleteMapping("/{ids}")
    public AjaxResult remove(@PathVariable Long[] ids)
    {
        notificationService.deleteByIds(ids);
        return success();
    }
}
