package com.ruoyi.competition.controller;

import java.util.List;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;
import com.ruoyi.competition.domain.Competition;
import com.ruoyi.competition.service.ICompetitionService;
import com.ruoyi.common.core.controller.BaseController;
import com.ruoyi.common.core.domain.AjaxResult;
import com.ruoyi.common.core.page.TableDataInfo;

/**
 * 竞赛列表Controller
 * 
 * @author ruoyi
 * @date 2026-05-29
 */
@RestController
@RequestMapping("/competition/list")
public class CompetitionListController extends BaseController
{
    @Autowired
    private ICompetitionService competitionService;

    /**
     * 查询竞赛列表
     */
    @PreAuthorize("@ss.hasPermi('competition:list:list')")
    @GetMapping
    public TableDataInfo list(Competition competition)
    {
        startPage();
        List<Competition> list = competitionService.selectCompetitionList(competition);
        return getDataTable(list);
    }

    /**
     * 获取竞赛详细信息
     */
    @PreAuthorize("@ss.hasPermi('competition:list:query')")
    @GetMapping(value = "/{competitionId}")
    public AjaxResult getInfo(@PathVariable("competitionId") Long competitionId)
    {
        return AjaxResult.success(competitionService.selectCompetitionById(competitionId));
    }

    /**
     * 删除竞赛
     */
    @PreAuthorize("@ss.hasPermi('competition:list:remove')")
    @DeleteMapping("/{competitionId}")
    public AjaxResult remove(@PathVariable("competitionId") Long competitionId)
    {
        return toAjax(competitionService.deleteCompetitionById(competitionId));
    }
}