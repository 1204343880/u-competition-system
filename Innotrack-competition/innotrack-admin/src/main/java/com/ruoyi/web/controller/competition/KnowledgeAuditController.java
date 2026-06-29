package com.ruoyi.web.controller.competition;

import java.util.Date;
import java.util.List;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;
import com.ruoyi.common.core.controller.BaseController;
import com.ruoyi.common.core.domain.AjaxResult;
import com.ruoyi.common.core.domain.entity.SysUser;
import com.ruoyi.common.core.page.TableDataInfo;
import com.ruoyi.common.utils.SecurityUtils;
import com.ruoyi.framework.mq.RabbitMqProducer;
import com.ruoyi.system.domain.CompetitionExperience;
import com.ruoyi.system.domain.CompetitionRetrospect;
import com.ruoyi.system.domain.UserNotification;
import com.ruoyi.system.service.ICompetitionExperienceService;
import com.ruoyi.system.service.ICompetitionRetrospectService;
import com.ruoyi.system.service.ISysUserService;
import io.swagger.v3.oas.annotations.Operation;
import io.swagger.v3.oas.annotations.Parameter;
import io.swagger.v3.oas.annotations.tags.Tag;

@Tag(name = "知识库审核（管理员/教师）")
@PreAuthorize("@ss.hasPermi('system:knowledge:audit')")
@RestController
@RequestMapping("/system/knowledge/audit")
public class KnowledgeAuditController extends BaseController
{
    private static final Logger log = LoggerFactory.getLogger(KnowledgeAuditController.class);

    @Autowired
    private ICompetitionRetrospectService retrospectService;

    @Autowired
    private ICompetitionExperienceService experienceService;

    @Autowired
    private RabbitMqProducer rabbitMqProducer;

    @Autowired
    private ISysUserService userService;

    @Operation(summary = "分页查询复盘审核列表")
    @GetMapping("/retrospect/list")
    public TableDataInfo retrospectAuditList(
            @Parameter(description = "审核状态（0待审核 1已通过 2已驳回）")
            @RequestParam(required = false) String auditStatus,
            @Parameter(description = "项目名称（模糊查询）")
            @RequestParam(required = false) String projectName)
    {
        CompetitionRetrospect retrospect = new CompetitionRetrospect();
        retrospect.setAuditStatus(auditStatus);
        retrospect.setProjectName(projectName);
        startPage();
        List<CompetitionRetrospect> list = retrospectService.selectAuditList(retrospect);
        return getDataTable(list);
    }

    @Operation(summary = "审核复盘（通过/驳回）")
    @PutMapping("/retrospect")
    public AjaxResult auditRetrospect(
            @RequestBody CompetitionRetrospect retrospect)
    {
        CompetitionRetrospect exist = retrospectService.selectRetrospectByIdRaw(retrospect.getRetrospectId());
        if (exist == null)
        {
            return error("复盘记录不存在");
        }
        CompetitionRetrospect update = new CompetitionRetrospect();
        update.setRetrospectId(retrospect.getRetrospectId());
        update.setAuditStatus(retrospect.getAuditStatus());
        update.setRejectReason(retrospect.getRejectReason());
        update.setAuditBy(SecurityUtils.getUsername());
        update.setAuditTime(new Date());
        int rows = retrospectService.auditRetrospect(update);

        sendRetrospectNotification(exist, retrospect.getAuditStatus(), retrospect.getRejectReason());
        return rows > 0 ? success("审核完成") : error("该复盘已被审核，请刷新列表");
    }

    @Operation(summary = "查询复盘详情（管理员，不限制审核状态）")
    @GetMapping("/retrospect/{retrospectId}")
    public AjaxResult retrospectDetail(
            @Parameter(description = "复盘ID", required = true)
            @PathVariable Long retrospectId)
    {
        CompetitionRetrospect retrospect = retrospectService.selectRetrospectByIdRaw(retrospectId);
        if (retrospect == null)
        {
            return error("复盘记录不存在");
        }
        return success(retrospect);
    }

    @Operation(summary = "分页查询经验帖审核列表")
    @GetMapping("/experience/list")
    public TableDataInfo experienceAuditList(
            @Parameter(description = "审核状态（0待审核 1已通过 2已驳回）")
            @RequestParam(required = false) String auditStatus,
            @Parameter(description = "标题（模糊查询）")
            @RequestParam(required = false) String title)
    {
        CompetitionExperience experience = new CompetitionExperience();
        experience.setAuditStatus(auditStatus);
        experience.setTitle(title);
        startPage();
        List<CompetitionExperience> list = experienceService.selectAuditList(experience);
        return getDataTable(list);
    }

    @Operation(summary = "审核经验帖（通过/驳回）")
    @PutMapping("/experience")
    public AjaxResult auditExperience(
            @RequestBody CompetitionExperience experience)
    {
        CompetitionExperience exist = experienceService.selectExperienceByIdRaw(experience.getExperienceId());
        if (exist == null)
        {
            return error("经验帖不存在");
        }
        CompetitionExperience update = new CompetitionExperience();
        update.setExperienceId(experience.getExperienceId());
        update.setAuditStatus(experience.getAuditStatus());
        update.setRejectReason(experience.getRejectReason());
        update.setAuditBy(SecurityUtils.getUsername());
        update.setAuditTime(new Date());
        int rows = experienceService.auditExperience(update);

        sendExperienceNotification(exist, experience.getAuditStatus(), experience.getRejectReason());
        return rows > 0 ? success("审核完成") : error("该经验帖已被审核，请刷新列表");
    }

    @Operation(summary = "查询经验帖详情（管理员，不限制审核状态）")
    @GetMapping("/experience/{experienceId}")
    public AjaxResult experienceDetail(
            @Parameter(description = "经验帖ID", required = true)
            @PathVariable Long experienceId)
    {
        CompetitionExperience experience = experienceService.selectExperienceByIdRaw(experienceId);
        if (experience == null)
        {
            return error("经验帖不存在");
        }
        return success(experience);
    }

    private void sendRetrospectNotification(CompetitionRetrospect retrospect, String auditStatus, String rejectReason)
    {
        if (retrospect.getCreateBy() == null)
        {
            return;
        }
        UserNotification notification = new UserNotification();
        Long userId = resolveNotificationUserId(retrospect.getCreateBy(), "retrospect", retrospect.getRetrospectId());
        if (userId == null)
        {
            return;
        }
        notification.setUserId(userId);
        notification.setBizType("knowledge");
        notification.setBizId(retrospect.getRetrospectId());
        if ("1".equals(auditStatus))
        {
            notification.setTitle("复盘审核通过");
            notification.setContent("你的项目复盘【" + retrospect.getProjectName() + "】已通过审核");
        }
        else
        {
            notification.setTitle("复盘审核被驳回");
            notification.setContent("你的项目复盘【" + retrospect.getProjectName() + "】被驳回"
                    + (rejectReason != null ? "，原因：" + rejectReason : ""));
        }
        sendNotificationSafely(notification);
    }

    private void sendExperienceNotification(CompetitionExperience experience, String auditStatus, String rejectReason)
    {
        if (experience.getCreateBy() == null)
        {
            return;
        }
        UserNotification notification = new UserNotification();
        Long userId = resolveNotificationUserId(experience.getCreateBy(), "experience", experience.getExperienceId());
        if (userId == null)
        {
            return;
        }
        notification.setUserId(userId);
        notification.setBizType("knowledge");
        notification.setBizId(experience.getExperienceId());
        if ("1".equals(auditStatus))
        {
            notification.setTitle("经验帖审核通过");
            notification.setContent("你的经验帖【" + experience.getTitle() + "】已通过审核");
        }
        else
        {
            notification.setTitle("经验帖审核被驳回");
            notification.setContent("你的经验帖【" + experience.getTitle() + "】被驳回"
                    + (rejectReason != null ? "，原因：" + rejectReason : ""));
        }
        sendNotificationSafely(notification);
    }

    private Long resolveNotificationUserId(String createBy, String bizType, Long bizId)
    {
        if (createBy == null || createBy.trim().isEmpty())
        {
            log.warn("Skip knowledge audit notification because createBy is empty: bizType={}, bizId={}", bizType, bizId);
            return null;
        }
        SysUser user = userService.selectUserByUserName(createBy);
        if (user == null || user.getUserId() == null)
        {
            log.warn("Skip knowledge audit notification because createBy user was not found: bizType={}, bizId={}, createBy={}",
                    bizType, bizId, createBy);
            return null;
        }
        return user.getUserId();
    }

    private void sendNotificationSafely(UserNotification notification)
    {
        try
        {
            rabbitMqProducer.sendNotification(notification);
        }
        catch (Exception ex)
        {
            log.warn("Knowledge audit succeeded but notification delivery failed: bizType={}, bizId={}, userId={}",
                    notification.getBizType(), notification.getBizId(), notification.getUserId(), ex);
        }
    }
}
