package com.ruoyi.web.controller.system;

import java.util.ArrayList;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;
import java.util.Set;
import java.util.stream.Collectors;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RestController;
import com.ruoyi.common.core.controller.BaseController;
import com.ruoyi.common.core.domain.AjaxResult;
import com.ruoyi.common.core.domain.model.RegisterBody;
import com.ruoyi.common.core.domain.entity.SysDept;
import com.ruoyi.common.utils.StringUtils;
import com.ruoyi.framework.web.service.SysRegisterService;
import com.ruoyi.system.service.ISysDeptService;

/**
 * 注册验证
 * 
 * @author ruoyi
 */
@RestController
public class SysRegisterController extends BaseController
{
    @Autowired
    private SysRegisterService registerService;

    @Autowired
    private ISysDeptService deptService;

    /**
     * 学生注册可选的学院与专业。只返回启用中的学校组织树，不暴露负责人等后台字段。
     */
    @GetMapping("/register/departments")
    public AjaxResult departments()
    {
        List<SysDept> departments = deptService.selectRegistrationDeptList();
        Set<Long> rootIds = departments.stream()
                .filter(item -> Long.valueOf(0L).equals(item.getParentId()))
                .map(SysDept::getDeptId)
                .collect(Collectors.toSet());
        List<Map<String, Object>> colleges = new ArrayList<>();
        for (SysDept college : departments)
        {
            if (!rootIds.contains(college.getParentId()))
            {
                continue;
            }
            List<Map<String, Object>> majors = departments.stream()
                    .filter(item -> college.getDeptId().equals(item.getParentId()))
                    .map(item -> {
                        Map<String, Object> major = new LinkedHashMap<>();
                        major.put("deptId", item.getDeptId());
                        major.put("deptName", item.getDeptName());
                        return major;
                    })
                    .collect(Collectors.toList());
            if (!majors.isEmpty())
            {
                Map<String, Object> result = new LinkedHashMap<>();
                result.put("collegeId", college.getDeptId());
                result.put("collegeName", college.getDeptName());
                result.put("majors", majors);
                colleges.add(result);
            }
        }
        return success(colleges);
    }

    @PostMapping("/register")
    public AjaxResult register(@RequestBody RegisterBody user)
    {
        String msg = registerService.register(user);
        return StringUtils.isEmpty(msg) ? success() : error(msg);
    }

    /**
     * 邮箱验证码发送（注册用）
     */
    @PostMapping("/register/email/send")
    public AjaxResult sendEmailCode(@RequestBody RegisterBody body)
    {
        String email = StringUtils.trim(body.getEmail());
        if (email == null || !email.matches("^[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}$"))
        {
            return error("请输入正确的邮箱地址");
        }
        registerService.sendEmailCode(email);
        return success("验证码已发送至邮箱");
    }
}
