package com.ruoyi.web.controller.competition;

import java.util.Date;
import java.util.List;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;
import com.ruoyi.common.core.controller.BaseController;
import com.ruoyi.common.core.domain.AjaxResult;
import com.ruoyi.common.core.domain.model.LoginUser;
import com.ruoyi.common.core.page.TableDataInfo;
import com.ruoyi.common.utils.SecurityUtils;
import com.ruoyi.system.domain.CompetitionResult;
import com.ruoyi.system.service.ICompetitionResultService;
import io.swagger.v3.oas.annotations.Operation;
import io.swagger.v3.oas.annotations.Parameter;
import io.swagger.v3.oas.annotations.tags.Tag;

@Tag(name = "竞赛成绩管理")
@RestController
@RequestMapping("/system/competition/result")
public class CompetitionResultController extends BaseController
{
    @Autowired
    private ICompetitionResultService resultService;

    @Operation(summary = "分页查询已确认的成绩列表（公开）")
    @GetMapping("/list")
    public TableDataInfo list(
            @Parameter(description = "竞赛名称") @RequestParam(required = false) String competitionName,
            @Parameter(description = "获奖级别") @RequestParam(required = false) String awardLevel,
            @Parameter(description = "项目名称") @RequestParam(required = false) String projectName)
    {
        CompetitionResult result = new CompetitionResult();
        result.setCompetitionName(competitionName);
        result.setAwardLevel(awardLevel);
        result.setProjectName(projectName);
        startPage();
        List<CompetitionResult> list = resultService.selectResultList(result);
        return getDataTable(list);
    }

    @Operation(summary = "查询成绩详情")
    @GetMapping("/{resultId}")
    public AjaxResult detail(@PathVariable Long resultId)
    {
        CompetitionResult result = resultService.selectResultById(resultId);
        if (result == null)
        {
            return error("成绩记录不存在");
        }
        return success(result);
    }

    @Operation(summary = "教师/管理员-录入成绩")
    @PreAuthorize("@ss.hasAnyRoles('admin,teacher')")
    @PostMapping
    public AjaxResult add(@RequestBody CompetitionResult result)
    {
        LoginUser loginUser = SecurityUtils.getLoginUser();
        if (loginUser == null)
        {
            return error("请先登录");
        }
        result.setCreateBy(loginUser.getUsername());
        resultService.insertResult(result);
        return success("成绩录入成功，待管理员审核");
    }

    @Operation(summary = "教师/管理员-修改成绩（仅待审核状态可修改）")
    @PreAuthorize("@ss.hasAnyRoles('admin,teacher')")
    @PutMapping
    public AjaxResult edit(@RequestBody CompetitionResult result)
    {
        LoginUser loginUser = SecurityUtils.getLoginUser();
        if (loginUser == null)
        {
            return error("请先登录");
        }
        CompetitionResult exist = resultService.selectResultByIdRaw(result.getResultId());
        if (exist == null)
        {
            return error("成绩记录不存在");
        }
        if (!"0".equals(exist.getResultStatus()))
        {
            return error("仅待审核状态可修改");
        }
        result.setUpdateBy(loginUser.getUsername());
        resultService.updateResult(result);
        return success("修改成功");
    }

    @Operation(summary = "管理员-审核成绩（通过/驳回）")
    @PreAuthorize("@ss.hasPermi('system:competition:audit')")
    @PutMapping("/audit")
    public AjaxResult audit(@RequestBody CompetitionResult result)
    {
        CompetitionResult update = new CompetitionResult();
        update.setResultId(result.getResultId());
        update.setResultStatus(result.getResultStatus());
        update.setRemark(result.getRemark());
        update.setAuditBy(SecurityUtils.getUsername());
        update.setAuditTime(new Date());
        int rows = resultService.auditResult(update);
        return rows > 0 ? success("审核完成") : error("该成绩已被审核，请刷新列表");
    }

    @Operation(summary = "教师/管理员-删除成绩")
    @PreAuthorize("@ss.hasAnyRoles('admin,teacher')")
    @DeleteMapping("/{resultIds}")
    public AjaxResult remove(@PathVariable Long[] resultIds)
    {
        resultService.deleteResultByIds(resultIds);
        return success("删除成功");
    }

    @Operation(summary = "分页查询成绩审核列表（管理员）")
    @PreAuthorize("@ss.hasPermi('system:competition:audit')")
    @GetMapping("/audit/list")
    public TableDataInfo auditList(
            @Parameter(description = "审核状态（0待审核 1已确认 2已作废）")
            @RequestParam(required = false) String resultStatus,
            @Parameter(description = "竞赛名称") @RequestParam(required = false) String competitionName)
    {
        CompetitionResult result = new CompetitionResult();
        result.setResultStatus(resultStatus);
        result.setCompetitionName(competitionName);
        startPage();
        List<CompetitionResult> list = resultService.selectResultAuditList(result);
        return getDataTable(list);
    }

    @Operation(summary = "查询我的获奖记录")
    @GetMapping("/my")
    public AjaxResult myResults()
    {
        LoginUser loginUser = SecurityUtils.getLoginUser();
        if (loginUser == null)
        {
            return error("请先登录");
        }
        List<CompetitionResult> list = resultService.selectResultsByUserId(loginUser.getUserId());
        return success(list);
    }
}
