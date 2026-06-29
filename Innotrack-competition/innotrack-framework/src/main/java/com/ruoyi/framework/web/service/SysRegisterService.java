package com.ruoyi.framework.web.service;

import java.time.Year;
import java.util.Locale;
import java.util.Random;
import java.util.concurrent.TimeUnit;
import java.util.regex.Pattern;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;
import com.ruoyi.common.constant.CacheConstants;
import com.ruoyi.common.constant.Constants;
import com.ruoyi.common.constant.UserConstants;
import com.ruoyi.common.core.domain.entity.SysDept;
import com.ruoyi.common.core.domain.entity.SysRole;
import com.ruoyi.common.core.domain.entity.SysUser;
import com.ruoyi.common.core.domain.model.RegisterBody;
import com.ruoyi.common.core.redis.RedisCache;
import com.ruoyi.common.exception.user.CaptchaException;
import com.ruoyi.common.exception.user.CaptchaExpireException;
import com.ruoyi.common.mail.IEmailProvider;
import com.ruoyi.common.utils.DateUtils;
import com.ruoyi.common.utils.MessageUtils;
import com.ruoyi.common.utils.SecurityUtils;
import com.ruoyi.common.utils.StringUtils;
import com.ruoyi.framework.manager.AsyncManager;
import com.ruoyi.framework.manager.factory.AsyncFactory;
import com.ruoyi.system.service.ISysConfigService;
import com.ruoyi.system.service.ISysDeptService;
import com.ruoyi.system.service.ISysRoleService;
import com.ruoyi.system.service.ISysUserService;

/**
 * 注册校验方法
 * 
 * @author ruoyi
 */
@Component
public class SysRegisterService
{
    private static final Pattern PHONE_PATTERN = Pattern.compile("^1[3-9]\\d{9}$");
    private static final Pattern EMAIL_PATTERN = Pattern.compile("^[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}$");
    private static final Pattern STUDENT_NO_PATTERN = Pattern.compile("^[A-Za-z0-9]{4,20}$");
    private static final Pattern GRADE_PATTERN = Pattern.compile("^(\\d{4})(?:级)?$");
    private static final int GRADE_YEAR_SPAN = 7;
    private static final String DEFAULT_AVATAR = Constants.RESOURCE_PREFIX + "/default-avatar.jpg";

    @Autowired
    private ISysUserService userService;

    @Autowired
    private ISysConfigService configService;

    @Autowired
    private ISysDeptService deptService;

    @Autowired
    private ISysRoleService roleService;

    @Autowired
    private RedisCache redisCache;

    @Autowired(required = false)
    private IEmailProvider emailProvider;

    /**
     * 注册
     */
    public String register(RegisterBody registerBody)
    {
        String msg = "", username = StringUtils.trim(registerBody.getUsername()), password = registerBody.getPassword();
        String nickName = StringUtils.trim(registerBody.getNickName());
        String studentNo = StringUtils.trim(registerBody.getStudentNo());
        String grade = StringUtils.trim(registerBody.getGrade());
        String phonenumber = StringUtils.trim(registerBody.getPhonenumber());
        String email = normalizeEmail(registerBody.getEmail());
        SysUser sysUser = new SysUser();
        sysUser.setUserName(username);
        sysUser.setNickName(nickName);
        sysUser.setStudentNo(studentNo);
        sysUser.setGrade(grade);
        sysUser.setPhonenumber(phonenumber);
        sysUser.setEmail(email);
        sysUser.setDeptId(registerBody.getDeptId());

        // 验证码开关
        if (StringUtils.isEmpty(username))
        {
            msg = "用户名不能为空";
        }
        else if (StringUtils.isEmpty(password))
        {
            msg = "用户密码不能为空";
        }
        else if (username.length() < UserConstants.USERNAME_MIN_LENGTH
                || username.length() > UserConstants.USERNAME_MAX_LENGTH)
        {
            msg = "账户长度必须在2到20个字符之间";
        }
        else if (password.length() < UserConstants.PASSWORD_MIN_LENGTH
                || password.length() > UserConstants.PASSWORD_MAX_LENGTH)
        {
            msg = "密码长度必须在5到20个字符之间";
        }
        else if (StringUtils.isEmpty(nickName) || nickName.length() > 30)
        {
            msg = "姓名不能为空且不能超过30个字符";
        }
        else if (StringUtils.isEmpty(studentNo) || !STUDENT_NO_PATTERN.matcher(studentNo).matches())
        {
            msg = "学号须为4到20位字母或数字";
        }
        else if (!isValidGrade(grade))
        {
            msg = "年级不能为空且不能超过10个字符";
            int currentYear = Year.now().getValue();
            msg = "年级须为" + (currentYear - GRADE_YEAR_SPAN) + "级至" + currentYear + "级";
        }
        else if (StringUtils.isEmpty(phonenumber) || !PHONE_PATTERN.matcher(phonenumber).matches())
        {
            msg = "请输入正确的手机号码";
        }
        else if (StringUtils.isEmpty(email) || !EMAIL_PATTERN.matcher(email).matches())
        {
            msg = "请输入正确的邮箱地址";
        }
        else if (registerBody.getCollegeId() == null || registerBody.getDeptId() == null)
        {
            msg = "请选择学院和专业";
        }
        else
        {
            sysUser.setGrade(normalizeGrade(grade));
            if (!verifyEmailCode(email, registerBody.getEmailCode()))
            {
                msg = "邮箱验证码错误或已过期";
            }
            else if (!userService.checkUserNameUnique(sysUser))
        {
            msg = "保存用户'" + username + "'失败，注册账号已存在";
        }
        else if (!userService.checkStudentNoUnique(sysUser))
        {
            msg = "注册失败，该学号已被使用";
        }
        else if (!userService.checkPhoneUnique(sysUser))
        {
            msg = "注册失败，该手机号码已被使用";
        }
        else if (!userService.checkEmailUnique(sysUser))
        {
            msg = "注册失败，该邮箱已被使用";
        }
        else
        {
            SysDept college = deptService.selectDeptById(registerBody.getCollegeId());
            SysDept major = deptService.selectDeptById(registerBody.getDeptId());
            if (college == null || major == null || !registerBody.getCollegeId().equals(major.getParentId())
                    || !"0".equals(college.getStatus()) || !"0".equals(major.getStatus()))
            {
                return "学院或专业无效，请重新选择";
            }

            SysRole studentRole = roleService.selectRoleByKey("student");
            if (studentRole == null)
            {
                return "注册失败，系统未配置可用的学生角色";
            }

            // Only consume the image captcha after all reusable registration data passed validation.
            // This keeps a later validation error from invalidating a correct captcha prematurely.
            if (configService.selectCaptchaEnabled())
            {
                validateCaptcha(username, registerBody.getCode(), registerBody.getUuid());
            }

            sysUser.setPwdUpdateDate(DateUtils.getNowDate());
            sysUser.setPassword(SecurityUtils.encryptPassword(password));
            sysUser.setAvatar(DEFAULT_AVATAR);
            sysUser.setRoleIds(new Long[] { studentRole.getRoleId() });
            sysUser.setStatus("0");
            sysUser.setSex("2");
            sysUser.setShowInMarket("0");
            sysUser.setCreateBy("self-register");
            boolean regFlag = userService.insertUser(sysUser) > 0;
            if (!regFlag)
            {
                msg = "注册失败,请联系系统管理人员";
            }
            else
            {
                redisCache.deleteObject(CacheConstants.EMAIL_CODE_KEY + email);
                AsyncManager.me().execute(AsyncFactory.recordLogininfor(username, Constants.REGISTER, MessageUtils.message("user.register.success")));
            }
        }
        }
        return msg;
    }

    /**
     * 校验验证码
     * 
     * @param username 用户名
     * @param code 验证码
     * @param uuid 唯一标识
     * @return 结果
     */
    public void validateCaptcha(String username, String code, String uuid)
    {
        String verifyKey = CacheConstants.CAPTCHA_CODE_KEY + StringUtils.nvl(uuid, "");
        Object cachedCaptcha = redisCache.getCacheObject(verifyKey);
        if (cachedCaptcha == null)
        {
            throw new CaptchaExpireException();
        }
        String captcha = String.valueOf(cachedCaptcha);
        String normalizedCode = StringUtils.trim(code);
        if (StringUtils.isEmpty(normalizedCode) || !normalizedCode.equalsIgnoreCase(captcha))
        {
            redisCache.deleteObject(verifyKey);
            throw new CaptchaException();
        }
        redisCache.deleteObject(verifyKey);
    }

    private boolean isValidGrade(String grade)
    {
        java.util.regex.Matcher matcher = GRADE_PATTERN.matcher(StringUtils.nvl(StringUtils.trim(grade), ""));
        if (!matcher.matches())
        {
            return false;
        }
        int year = Integer.parseInt(matcher.group(1));
        int currentYear = Year.now().getValue();
        int currentMonth = java.time.LocalDate.now().getMonthValue();
        int maxGradeYear = currentMonth >= 9 ? currentYear : currentYear - 1;
        int minGradeYear = maxGradeYear - GRADE_YEAR_SPAN;
        return year >= minGradeYear && year <= maxGradeYear;
    }

    private String normalizeGrade(String grade)
    {
        java.util.regex.Matcher matcher = GRADE_PATTERN.matcher(StringUtils.trim(grade));
        return matcher.matches() ? matcher.group(1) + "级" : grade;
    }

    private static final int CODE_TTL = 5;
    private static final Random RANDOM = new Random();

    /**
     * 发送邮箱验证码
     */
    public void sendEmailCode(String email)
    {
        email = normalizeEmail(email);
        String key = CacheConstants.EMAIL_CODE_KEY + email;
        Object cachedCode = redisCache.getCacheObject(key);
        String code = cachedCode == null ? null : String.valueOf(cachedCode);
        if (StringUtils.isEmpty(code))
        {
            code = String.format("%06d", RANDOM.nextInt(1000000));
        }
        redisCache.setCacheObject(key, code, CODE_TTL, TimeUnit.MINUTES);
        if (emailProvider != null)
        {
            emailProvider.sendVerificationCode(email, code);
        }
    }

    /**
     * 校验邮箱验证码
     */
    public boolean verifyEmailCode(String email, String code)
    {
        email = normalizeEmail(email);
        code = StringUtils.trim(code);
        if (StringUtils.isEmpty(email) || StringUtils.isEmpty(code))
        {
            return false;
        }
        String key = CacheConstants.EMAIL_CODE_KEY + email;
        Object cachedCode = redisCache.getCacheObject(key);
        if (cachedCode == null)
        {
            return false;
        }
        String storedCode = String.valueOf(cachedCode);
        if (storedCode.equals(code))
        {
            return true;
        }
        return false;
    }

    private String normalizeEmail(String email)
    {
        String normalized = StringUtils.trim(email);
        return normalized == null ? null : normalized.toLowerCase(Locale.ROOT);
    }
}
