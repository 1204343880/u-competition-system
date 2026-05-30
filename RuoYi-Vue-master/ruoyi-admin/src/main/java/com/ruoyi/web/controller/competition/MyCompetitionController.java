package com.ruoyi.competition.controller;

import java.util.List;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;
import com.ruoyi.competition.domain.Competition;
import com.ruoyi.competition.service.ICompetitionService;
import com.ruoyi.common.core.controller.BaseController;
import com.ruoyi.common.core.domain.AjaxResult;
import com.ruoyi.common.core.page.TableDataInfo;
import com.ruoyi.common.utils.SecurityUtils;

/**
 * 我的竞赛Controller
 * 
 * @author ruoyi
 * @date 2026-05-28
 */
@RestController
@RequestMapping("/competition/my")
public class MyCompetitionController extends BaseController
{
    @Autowired
    private ICompetitionService competitionService;

    /**
     * 查询我的竞赛列表
     */
    @PreAuthorize("@ss.hasPermi('competition:my:list')")
    @GetMapping("/list")
    public TableDataInfo list(Competition competition)
    {
        startPage();
        Long userId = SecurityUtils.getUserId();
        List<Competition> list = competitionService.selectMyCompetitionList(userId);
        return getDataTable(list);
    }

    /**
     * 获取竞赛详细信息
     */
    @PreAuthorize("@ss.hasPermi('competition:my:query')")
    @GetMapping(value = "/{competitionId}")
    public AjaxResult getInfo(@PathVariable("competitionId") Long competitionId)
    {
        return AjaxResult.success(competitionService.selectCompetitionById(competitionId));
    }

    /**
     * 报名竞赛
     */
    @PreAuthorize("@ss.hasPermi('competition:my:add')")
    @PostMapping("/apply")
    public AjaxResult apply(Long competitionId)
    {
        Long userId = SecurityUtils.getUserId();
        return toAjax(competitionService.applyCompetition(competitionId, userId));
    }

    /**
     * 取消报名
     */
    @PreAuthorize("@ss.hasPermi('competition:my:cancel')")
    @DeleteMapping("/cancel/{competitionId}")
    public AjaxResult cancel(@PathVariable("competitionId") Long competitionId)
    {
        Long userId = SecurityUtils.getUserId();
        return toAjax(competitionService.cancelCompetition(competitionId, userId));
    }
}