package com.ruoyi.web.controller.competition;

import java.util.Date;
import java.util.List;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;
import com.ruoyi.common.annotation.Anonymous;
import com.ruoyi.common.core.controller.BaseController;
import com.ruoyi.common.core.domain.AjaxResult;
import com.ruoyi.common.core.domain.model.LoginUser;
import com.ruoyi.common.core.page.TableDataInfo;
import com.ruoyi.common.utils.SecurityUtils;
import com.ruoyi.system.domain.CompetitionExperience;
import com.ruoyi.system.domain.CompetitionRetrospect;
import com.ruoyi.system.service.ICompetitionExperienceService;
import com.ruoyi.system.service.ICompetitionRetrospectService;
import io.swagger.v3.oas.annotations.Operation;
import io.swagger.v3.oas.annotations.Parameter;
import io.swagger.v3.oas.annotations.tags.Tag;

@Tag(name = "薪火相传-知识库")
@RestController
@RequestMapping("/student/knowledge")
public class KnowledgeController extends BaseController
{
    @Autowired
    private ICompetitionRetrospectService retrospectService;

    @Autowired
    private ICompetitionExperienceService experienceService;

    @Anonymous
    @Operation(summary = "分页查询项目复盘列表")
    @GetMapping("/retrospect/list")
    public TableDataInfo retrospectList(
            @Parameter(description = "项目名称（模糊查询）")
            @RequestParam(required = false) String projectName,
            @Parameter(description = "竞赛名称（模糊查询）")
            @RequestParam(required = false) String competitionName,
            @Parameter(description = "获奖级别")
            @RequestParam(required = false) String awardLevel,
            @Parameter(description = "年份")
            @RequestParam(required = false) String year)
    {
        CompetitionRetrospect retrospect = new CompetitionRetrospect();
        retrospect.setProjectName(projectName);
        retrospect.setCompetitionName(competitionName);
        retrospect.setAwardLevel(awardLevel);
        retrospect.setYear(year);
        startPage();
        List<CompetitionRetrospect> list = retrospectService.selectRetrospectList(retrospect);
        return getDataTable(list);
    }

    @Anonymous
    @Operation(summary = "查询项目复盘详情")
    @GetMapping("/retrospect/{retrospectId}")
    public AjaxResult retrospectInfo(
            @Parameter(description = "复盘ID", required = true)
            @PathVariable Long retrospectId)
    {
        CompetitionRetrospect retrospect = retrospectService.selectRetrospectById(retrospectId);
        if (retrospect == null)
        {
            return error("复盘记录不存在");
        }
        return success(retrospect);
    }

    @Operation(summary = "新增项目复盘")
    @PostMapping("/retrospect")
    public AjaxResult addRetrospect(@RequestBody CompetitionRetrospect retrospect)
    {
        LoginUser loginUser = SecurityUtils.getLoginUser();
        if (loginUser == null)
        {
            return error("请先登录");
        }
        retrospect.setCreateBy(loginUser.getUsername());
        retrospect.setCreateTime(new Date());
        retrospect.setAuditStatus("0");
        retrospect.setDelFlag("0");
        retrospectService.insertRetrospect(retrospect);
        return success("投稿成功，请等待管理员审核");
    }

    @Operation(summary = "修改项目复盘（仅限本人或管理员）")
    @PutMapping("/retrospect")
    public AjaxResult updateRetrospect(@RequestBody CompetitionRetrospect retrospect)
    {
        // 归属校验在 Service 层执行
        retrospect.setUpdateBy(SecurityUtils.getUsername());
        retrospect.setUpdateTime(new Date());
        retrospectService.updateRetrospect(retrospect);
        return success("修改成功");
    }

    @Operation(summary = "删除项目复盘（仅限本人或管理员）")
    @DeleteMapping("/retrospect/{retrospectIds}")
    public AjaxResult deleteRetrospect(
            @Parameter(description = "复盘ID，多个逗号分隔", required = true)
            @PathVariable Long[] retrospectIds)
    {
        // 归属校验在 Service 层执行
        retrospectService.deleteRetrospectByIds(retrospectIds);
        return success("删除成功");
    }

    @Operation(summary = "查询我的复盘提交列表（含审核状态）")
    @GetMapping("/retrospect/my-submissions")
    public AjaxResult myRetrospectSubmissions()
    {
        LoginUser loginUser = SecurityUtils.getLoginUser();
        if (loginUser == null)
        {
            return error("请先登录");
        }
        CompetitionRetrospect retrospect = new CompetitionRetrospect();
        retrospect.setCreateBy(loginUser.getUsername());
        startPage();
        List<CompetitionRetrospect> list = retrospectService.selectMySubmissions(retrospect);
        return success(getDataTable(list));
    }

    @Operation(summary = "获取复盘原始内容（用于修改被驳回的复盘）")
    @GetMapping("/retrospect/raw/{retrospectId}")
    public AjaxResult retrospectRaw(
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

    @Anonymous
    @Operation(summary = "分页查询经验帖列表")
    @GetMapping("/experience/list")
    public TableDataInfo experienceList(
            @Parameter(description = "标题（模糊查询）")
            @RequestParam(required = false) String title,
            @Parameter(description = "作者（模糊查询）")
            @RequestParam(required = false) String author,
            @Parameter(description = "分类")
            @RequestParam(required = false) String category)
    {
        CompetitionExperience experience = new CompetitionExperience();
        experience.setTitle(title);
        experience.setAuthor(author);
        experience.setCategory(category);
        startPage();
        List<CompetitionExperience> list = experienceService.selectExperienceList(experience);
        return getDataTable(list);
    }

    @Anonymous
    @Operation(summary = "查询经验帖详情（浏览量+1）")
    @GetMapping("/experience/{experienceId}")
    public AjaxResult experienceInfo(
            @Parameter(description = "经验帖ID", required = true)
            @PathVariable Long experienceId)
    {
        CompetitionExperience experience = experienceService.selectExperienceById(experienceId);
        if (experience == null)
        {
            return error("经验帖不存在");
        }
        experienceService.incrementViewCount(experienceId);
        return success(experience);
    }

    @Operation(summary = "新增经验帖")
    @PostMapping("/experience")
    public AjaxResult addExperience(@RequestBody CompetitionExperience experience)
    {
        LoginUser loginUser = SecurityUtils.getLoginUser();
        if (loginUser == null)
        {
            return error("请先登录");
        }
        experience.setAuthor(loginUser.getUser().getNickName() != null
                ? loginUser.getUser().getNickName() : loginUser.getUsername());
        experience.setCreateBy(loginUser.getUsername());
        experience.setCreateTime(new Date());
        experience.setViewCount(0);
        experience.setAuditStatus("0");
        experience.setDelFlag("0");
        experienceService.insertExperience(experience);
        return success("投稿成功，请等待管理员审核");
    }

    @Operation(summary = "修改经验帖（仅限本人或管理员）")
    @PutMapping("/experience")
    public AjaxResult updateExperience(@RequestBody CompetitionExperience experience)
    {
        // 归属校验在 Service 层执行
        experience.setUpdateBy(SecurityUtils.getUsername());
        experience.setUpdateTime(new Date());
        experienceService.updateExperience(experience);
        return success("修改成功");
    }

    @Operation(summary = "删除经验帖（仅限本人或管理员）")
    @DeleteMapping("/experience/{experienceIds}")
    public AjaxResult deleteExperience(
            @Parameter(description = "经验帖ID，多个逗号分隔", required = true)
            @PathVariable Long[] experienceIds)
    {
        // 归属校验在 Service 层执行
        experienceService.deleteExperienceByIds(experienceIds);
        return success("删除成功");
    }

    @Operation(summary = "查询我的经验帖提交列表（含审核状态）")
    @GetMapping("/experience/my-submissions")
    public AjaxResult myExperienceSubmissions()
    {
        LoginUser loginUser = SecurityUtils.getLoginUser();
        if (loginUser == null)
        {
            return error("请先登录");
        }
        CompetitionExperience experience = new CompetitionExperience();
        experience.setCreateBy(loginUser.getUsername());
        startPage();
        List<CompetitionExperience> list = experienceService.selectMySubmissions(experience);
        return success(getDataTable(list));
    }

    @Operation(summary = "获取经验帖原始内容（用于修改被驳回的经验帖）")
    @GetMapping("/experience/raw/{experienceId}")
    public AjaxResult experienceRaw(
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
}
