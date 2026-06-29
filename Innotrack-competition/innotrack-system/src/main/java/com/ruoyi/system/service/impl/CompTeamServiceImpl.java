package com.ruoyi.system.service.impl;

import java.security.SecureRandom;
import java.util.List;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import com.ruoyi.common.exception.ServiceException;
import com.ruoyi.common.utils.html.SafeTextUtils;
import com.ruoyi.system.domain.CompTeam;
import com.ruoyi.system.domain.CompTeamMember;
import com.ruoyi.system.domain.Competition;
import com.ruoyi.system.mapper.CompTeamMapper;
import com.ruoyi.system.mapper.CompTeamMemberMapper;
import com.ruoyi.system.mapper.CompetitionMapper;
import com.ruoyi.system.service.ICompTeamService;
import com.ruoyi.system.service.CompStatusGuard;

@Service
public class CompTeamServiceImpl implements ICompTeamService
{
    private static final String INVITE_CHARS = "ABCDEFGHJKMNPQRSTUVWXYZ23456789";
    private static final int INVITE_LENGTH = 6;
    private static final int MAX_RETRY = 3;

    @Autowired
    private CompTeamMapper teamMapper;

    @Autowired
    private CompTeamMemberMapper memberMapper;

    @Autowired
    private CompetitionMapper competitionMapper;

    @Autowired
    private CompStatusGuard compStatusGuard;

    @Override
    @Transactional
    public CompTeam createTeam(Long competitionId, String teamName, Long userId, String userName)
    {
        teamName = SafeTextUtils.sanitizePlainText("队名", teamName);
        if (teamName == null || teamName.isEmpty())
        {
            throw new ServiceException("队名不能为空");
        }
        SafeTextUtils.validateLength("队名", teamName, 30);

        Competition competition = competitionMapper.selectCompetitionById(competitionId);
        if (competition == null)
        {
            throw new ServiceException("竞赛不存在");
        }
        compStatusGuard.requirePublished(competition);
        compStatusGuard.requireRegistering(competition);
        if (!"2".equals(competition.getCompetitionType()))
        {
            throw new ServiceException("该竞赛为个人赛，请使用【我要报名】");
        }

        int cnt = teamMapper.countMemberByCompIdAndUserId(competitionId, userId);
        if (cnt > 0)
        {
            throw new ServiceException("您已在该竞赛的队伍中，不可再创建队伍");
        }

        String inviteCode = generateUniqueInviteCode();

        CompTeam team = new CompTeam();
        team.setCompetitionId(competitionId);
        team.setTeamName(teamName);
        team.setLeaderId(userId);
        team.setLeaderName(userName);
        team.setInviteCode(inviteCode);
        team.setStatus("0");
        Integer teamMaxMembers = competition.getTeamMaxMembers();
        if (teamMaxMembers == null || teamMaxMembers < 2)
        {
            throw new ServiceException("请先配置队伍人数上限");
        }
        team.setMaxMembers(teamMaxMembers);
        team.setCurrentMembers(1);
        team.setCreateBy(userName);
        teamMapper.insertTeam(team);

        CompTeamMember member = new CompTeamMember();
        member.setTeamId(team.getTeamId());
        member.setUserId(userId);
        member.setUserName(userName);
        member.setNickName(userName);
        member.setCreateBy(userName);
        memberMapper.insertMember(member);

        return selectTeamWithRole(team.getTeamId(), userId);
    }

    @Override
    @Transactional
    public CompTeam joinTeam(Long competitionId, String inviteCode, Long userId, String userName, String nickName)
    {
        Competition competition = competitionMapper.selectCompetitionById(competitionId);
        if (competition == null)
        {
            throw new ServiceException("竞赛不存在");
        }
        compStatusGuard.requirePublished(competition);
        compStatusGuard.requireRegistering(competition);
        if (!"2".equals(competition.getCompetitionType()))
        {
            throw new ServiceException("该竞赛为个人赛，请使用【我要报名】");
        }

        int cnt = teamMapper.countMemberByCompIdAndUserId(competitionId, userId);
        if (cnt > 0)
        {
            throw new ServiceException("您已在该竞赛的队伍中，不可重复加入");
        }

        CompTeam team = teamMapper.selectTeamByInviteCode(inviteCode);
        if (team == null)
        {
            throw new ServiceException("邀请码无效，未找到对应队伍");
        }
        if (!team.getCompetitionId().equals(competitionId))
        {
            throw new ServiceException("该邀请码不属于当前竞赛");
        }
        if (!"0".equals(team.getStatus()))
        {
            throw new ServiceException("该队伍已不可加入");
        }
        if (team.getCurrentMembers() >= team.getMaxMembers())
        {
            throw new ServiceException("该队伍已满员");
        }

        CompTeamMember member = new CompTeamMember();
        member.setTeamId(team.getTeamId());
        member.setUserId(userId);
        member.setUserName(userName);
        member.setNickName(nickName != null ? nickName : userName);
        member.setCreateBy(userName);
        memberMapper.insertMember(member);

        team.setCurrentMembers(team.getCurrentMembers() + 1);
        team.setUpdateBy(userName);
        teamMapper.updateTeam(team);

        return selectTeamWithRole(team.getTeamId(), userId);
    }

    @Override
    @Transactional
    public void leaveTeam(Long teamId, Long userId)
    {
        CompTeamMember member = memberMapper.selectMemberByTeamIdAndUserId(teamId, userId);
        if (member == null)
        {
            throw new ServiceException("您不在该队伍中");
        }

        CompTeam team = teamMapper.selectTeamById(teamId);
        if (team == null)
        {
            throw new ServiceException("队伍不存在");
        }
        if (!"0".equals(team.getStatus()))
        {
            throw new ServiceException("队伍已提交或已审核，无法退出");
        }
        if (team.getLeaderId().equals(userId))
        {
            throw new ServiceException("队长不可直接退出，请先解散队伍或移交队长权限");
        }

        memberMapper.deleteMember(member.getId());

        team.setCurrentMembers(team.getCurrentMembers() - 1);
        team.setUpdateBy(member.getUserName());
        teamMapper.updateTeam(team);
    }

    @Override
    @Transactional
    public void kickMember(Long teamId, Long leaderId, Long memberId)
    {
        CompTeam team = teamMapper.selectTeamById(teamId);
        if (team == null)
        {
            throw new ServiceException("队伍不存在");
        }
        if (!team.getLeaderId().equals(leaderId))
        {
            throw new ServiceException("仅队长可以踢出队员");
        }
        if (!"0".equals(team.getStatus()))
        {
            throw new ServiceException("队伍已提交或已审核，无法踢出队员");
        }
        if (team.getLeaderId().equals(memberId))
        {
            throw new ServiceException("队长不能被踢出，请使用解散队伍或移交队长");
        }

        CompTeamMember member = memberMapper.selectMemberByTeamIdAndUserId(teamId, memberId);
        if (member == null)
        {
            throw new ServiceException("该用户不在队伍中");
        }

        memberMapper.deleteMember(member.getId());

        team.setCurrentMembers(team.getCurrentMembers() - 1);
        team.setUpdateBy(String.valueOf(leaderId));
        teamMapper.updateTeam(team);
    }

    @Override
    @Transactional
    public void disbandTeam(Long teamId, Long userId)
    {
        CompTeam team = teamMapper.selectTeamById(teamId);
        if (team == null)
        {
            throw new ServiceException("队伍不存在");
        }
        if (!team.getLeaderId().equals(userId))
        {
            throw new ServiceException("仅队长可以解散队伍");
        }
        if (!"0".equals(team.getStatus()))
        {
            throw new ServiceException("队伍已提交或已审核，无法解散");
        }

        List<CompTeamMember> members = teamMapper.selectMembersByTeamId(teamId);
        for (CompTeamMember m : members)
        {
            memberMapper.deleteMember(m.getId());
        }

        teamMapper.deleteTeam(teamId);
    }

    @Override
    @Transactional
    public void transferLeader(Long teamId, Long currentLeaderId, Long newLeaderId)
    {
        CompTeam team = teamMapper.selectTeamById(teamId);
        if (team == null)
        {
            throw new ServiceException("队伍不存在");
        }
        if (!team.getLeaderId().equals(currentLeaderId))
        {
            throw new ServiceException("仅队长可以移交权限");
        }
        if (team.getLeaderId().equals(newLeaderId))
        {
            throw new ServiceException("不能移交给自己");
        }
        if (!"0".equals(team.getStatus()))
        {
            throw new ServiceException("队伍已提交或已审核，无法移交队长");
        }

        CompTeamMember newLeader = memberMapper.selectMemberByTeamIdAndUserId(teamId, newLeaderId);
        if (newLeader == null)
        {
            throw new ServiceException("目标用户不在该队伍中");
        }

        teamMapper.transferLeader(teamId, newLeaderId, newLeader.getUserName());
    }

    @Override
    public List<CompTeam> getPublicTeams(Long competitionId)
    {
        return teamMapper.selectPublicTeams(competitionId);
    }

    @Override
    public void togglePublic(Long teamId, Long userId, boolean isPublic)
    {
        CompTeam team = teamMapper.selectTeamById(teamId);
        if (team == null)
        {
            throw new ServiceException("队伍不存在");
        }
        if (!team.getLeaderId().equals(userId))
        {
            throw new ServiceException("仅队长可以修改");
        }
        if (!"0".equals(team.getStatus()))
        {
            throw new ServiceException("队伍已提交或已审核，无法修改公开状态");
        }
        teamMapper.togglePublic(teamId, isPublic ? "1" : "0");
    }

    @Override
    public void updateNeededSkills(Long teamId, Long userId, String skills)
    {
        CompTeam team = teamMapper.selectTeamById(teamId);
        if (team == null)
        {
            throw new ServiceException("队伍不存在");
        }
        if (!team.getLeaderId().equals(userId))
        {
            throw new ServiceException("仅队长可以修改");
        }
        if (!"0".equals(team.getStatus()))
        {
            throw new ServiceException("队伍已提交或已审核，无法修改技能需求");
        }
        teamMapper.updateNeededSkills(teamId, skills);
    }

    @Override
    public CompTeam getTeamById(Long teamId)
    {
        return teamMapper.selectTeamById(teamId);
    }

    @Override
    public CompTeam getMyTeamByCompetitionId(Long competitionId, Long userId)
    {
        return teamMapper.selectTeamByCompIdAndUserId(competitionId, userId);
    }

    @Override
    public List<CompTeam> getMyTeams(Long userId)
    {
        return teamMapper.selectTeamsByUserId(userId);
    }

    @Override
    public List<CompTeamMember> getTeamMembers(Long teamId)
    {
        return teamMapper.selectMembersByTeamId(teamId);
    }

    @Override
    public void submitTeam(Long teamId, Long leaderId)
    {
        int rows = teamMapper.submitTeam(teamId, leaderId);
        if (rows == 0)
        {
            throw new ServiceException("队伍不存在、不是队长、或队伍状态不可提交");
        }
    }

    @Override
    public void auditTeam(CompTeam team)
    {
        int rows = teamMapper.auditTeam(team);
        if (rows == 0)
        {
            throw new ServiceException("该队伍已被审核或不存在，请刷新列表");
        }
    }

    @Override
    public List<CompTeam> selectTeamAuditList(CompTeam team)
    {
        return teamMapper.selectTeamAuditList(team);
    }

    @Override
    public List<CompTeam> getTeacherTeams(Long teacherId)
    {
        return teamMapper.selectTeamsByTeacherId(teacherId);
    }

    private CompTeam selectTeamWithRole(Long teamId, Long userId)
    {
        CompTeam team = teamMapper.selectTeamById(teamId);
        if (team != null)
        {
            if (team.getLeaderId().equals(userId))
            {
                team.setUserRole("leader");
            }
            else
            {
                team.setUserRole("member");
            }
        }
        return team;
    }

    private String generateUniqueInviteCode()
    {
        SecureRandom random = new SecureRandom();
        for (int attempt = 0; attempt < MAX_RETRY; attempt++)
        {
            StringBuilder sb = new StringBuilder(INVITE_LENGTH);
            for (int i = 0; i < INVITE_LENGTH; i++)
            {
                sb.append(INVITE_CHARS.charAt(random.nextInt(INVITE_CHARS.length())));
            }
            String code = sb.toString();
            CompTeam existing = teamMapper.selectTeamByInviteCode(code);
            if (existing == null)
            {
                return code;
            }
        }
        throw new ServiceException("生成邀请码失败，请重试");
    }
}
