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
import com.ruoyi.common.core.page.TableDataInfo;
import com.ruoyi.common.utils.SecurityUtils;
import com.ruoyi.system.domain.Competition;
import com.ruoyi.system.domain.CompStatus;
import com.ruoyi.system.service.ICompetitionService;
import com.ruoyi.system.service.CompStatusGuard;
import io.swagger.v3.oas.annotations.Operation;
import io.swagger.v3.oas.annotations.Parameter;
import io.swagger.v3.oas.annotations.tags.Tag;

@Tag(name = "竞赛管理（管理员）")
@PreAuthorize("@ss.hasPermi('system:competition:manage')")
@RestController
@RequestMapping("/system/competition")
public class CompetitionManageController extends BaseController
{
    @Autowired
    private ICompetitionService competitionService;

    @Autowired
    private CompStatusGuard compStatusGuard;

    @Operation(summary = "分页查询竞赛管理列表")
    @GetMapping("/list")
    public TableDataInfo list(
            @Parameter(description = "竞赛名称（模糊查询）")
            @RequestParam(required = false) String competitionName,
            @Parameter(description = "发布状态（0草稿 1已发布 2已关闭 3已归档）")
            @RequestParam(required = false) String publishStatus,
            @Parameter(description = "类别")
            @RequestParam(required = false) String category)
    {
        Competition competition = new Competition();
        competition.setCompetitionName(competitionName);
        competition.setPublishStatus(publishStatus);
        competition.setCategory(category);
        startPage();
        List<Competition> list = competitionService.selectCompetitionManageList(competition);
        return getDataTable(list);
    }

    @Operation(summary = "查询竞赛详情")
    @GetMapping("/{competitionId}")
    public AjaxResult info(
            @Parameter(description = "竞赛ID", required = true)
            @PathVariable Long competitionId)
    {
        Competition competition = competitionService.selectCompetitionById(competitionId);
        if (competition == null)
        {
            return error("竞赛不存在");
        }
        return success(competition);
    }

    @Operation(summary = "新增竞赛（默认草稿状态）")
    @PostMapping
    public AjaxResult add(@RequestBody Competition competition)
    {
        competition.setCreateBy(SecurityUtils.getUsername());
        competition.setCreateTime(new Date());
        competition.setPublishStatus("0");
        competitionService.insertCompetition(competition);
        return success("竞赛创建成功（草稿）");
    }

    @Operation(summary = "修改竞赛")
    @PutMapping
    public AjaxResult edit(@RequestBody Competition competition)
    {
        Competition exist = competitionService.selectCompetitionById(competition.getCompetitionId());
        if (exist == null) return error("竞赛不存在");

        CompStatus oldStatus = exist.getStatus();
        CompStatus newStatus = competition.getStatus();
        if (newStatus != null && oldStatus != newStatus)
        {
            compStatusGuard.requireCanTransition(oldStatus, newStatus);
        }

        competition.setUpdateBy(SecurityUtils.getUsername());
        competition.setUpdateTime(new Date());
        competitionService.updateCompetition(competition);
        return success("修改成功");
    }

    @Operation(summary = "删除竞赛")
    @DeleteMapping("/{competitionIds}")
    public AjaxResult remove(
            @Parameter(description = "竞赛ID，多个逗号分隔", required = true)
            @PathVariable Long[] competitionIds)
    {
        competitionService.deleteCompetitionByIds(competitionIds);
        return success("删除成功");
    }

    @Operation(summary = "发布竞赛（草稿→已发布）")
    @PutMapping("/{competitionId}/publish")
    public AjaxResult publish(
            @Parameter(description = "竞赛ID", required = true)
            @PathVariable Long competitionId)
    {
        Competition update = new Competition();
        update.setCompetitionId(competitionId);
        update.setPublishStatus("1");
        competitionService.updatePublishStatus(update);
        return success("竞赛已发布");
    }

    @Operation(summary = "关闭竞赛（已发布→已关闭）")
    @PutMapping("/{competitionId}/close")
    public AjaxResult close(
            @Parameter(description = "竞赛ID", required = true)
            @PathVariable Long competitionId)
    {
        Competition exist = competitionService.selectCompetitionById(competitionId);
        if (exist == null)
        {
            return error("竞赛不存在");
        }
        if (!"1".equals(exist.getPublishStatus()))
        {
            return error("仅已发布的竞赛可以关闭");
        }
        Competition update = new Competition();
        update.setCompetitionId(competitionId);
        update.setPublishStatus("2");
        competitionService.updatePublishStatus(update);
        return success("竞赛已关闭");
    }

    @Operation(summary = "归档竞赛（已关闭→已归档）")
    @PutMapping("/{competitionId}/archive")
    public AjaxResult archive(
            @Parameter(description = "竞赛ID", required = true)
            @PathVariable Long competitionId)
    {
        Competition exist = competitionService.selectCompetitionById(competitionId);
        if (exist == null)
        {
            return error("竞赛不存在");
        }
        if (!"2".equals(exist.getPublishStatus()))
        {
            return error("仅已关闭的竞赛可以归档");
        }
        Competition update = new Competition();
        update.setCompetitionId(competitionId);
        update.setPublishStatus("3");
        competitionService.updatePublishStatus(update);
        return success("竞赛已归档");
    }

    @Operation(summary = "退回草稿（已关闭或草稿→草稿）")
    @PutMapping("/{competitionId}/draft")
    public AjaxResult draft(
            @Parameter(description = "竞赛ID", required = true)
            @PathVariable Long competitionId)
    {
        Competition update = new Competition();
        update.setCompetitionId(competitionId);
        update.setPublishStatus("0");
        competitionService.updatePublishStatus(update);
        return success("已退回草稿");
    }
}
