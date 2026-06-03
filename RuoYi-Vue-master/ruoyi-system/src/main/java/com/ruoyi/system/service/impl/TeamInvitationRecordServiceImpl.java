package com.ruoyi.system.service.impl;

import java.util.List;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import com.ruoyi.common.exception.ServiceException;
import com.ruoyi.system.domain.CompTeam;
import com.ruoyi.system.domain.CompTeamMember;
import com.ruoyi.system.domain.TeamInvitationRecord;
import com.ruoyi.system.mapper.CompTeamMapper;
import com.ruoyi.system.mapper.CompTeamMemberMapper;
import com.ruoyi.system.mapper.TeamInvitationRecordMapper;
import com.ruoyi.system.service.ITeamInvitationRecordService;

@Service
public class TeamInvitationRecordServiceImpl implements ITeamInvitationRecordService
{
    @Autowired
    private TeamInvitationRecordMapper recordMapper;

    @Autowired
    private CompTeamMapper teamMapper;

    @Autowired
    private CompTeamMemberMapper memberMapper;

    @Override
    @Transactional
    public TeamInvitationRecord inviteFromMarket(Long teamId, Long inviterId, Long inviteeId)
    {
        CompTeam team = teamMapper.selectTeamById(teamId);
        if (team == null)
        {
            throw new ServiceException("队伍不存在");
        }
        if (!team.getLeaderId().equals(inviterId))
        {
            throw new ServiceException("仅队长可以发起邀请");
        }
        if (!"0".equals(team.getStatus()))
        {
            throw new ServiceException("队伍不在组队中状态，无法邀请");
        }
        if (team.getCurrentMembers() >= team.getMaxMembers())
        {
            throw new ServiceException("队伍已满员");
        }

        int cnt = teamMapper.countMemberByCompIdAndUserId(team.getCompetitionId(), inviteeId);
        if (cnt > 0)
        {
            throw new ServiceException("该用户已在当前竞赛的队伍中");
        }

        int dup = recordMapper.checkDuplicatePending(teamId, inviteeId);
        if (dup > 0)
        {
            throw new ServiceException("已向该用户发送过待处理的邀请");
        }

        TeamInvitationRecord record = new TeamInvitationRecord();
        record.setTeamId(teamId);
        record.setInviterId(inviterId);
        record.setInviteeId(inviteeId);
        recordMapper.insertInvitation(record);

        return recordMapper.selectById(record.getId());
    }

    @Override
    @Transactional
    public void acceptInvitation(Long recordId, Long userId)
    {
        TeamInvitationRecord record = recordMapper.selectById(recordId);
        if (record == null)
        {
            throw new ServiceException("邀请记录不存在");
        }
        if (!record.getInviteeId().equals(userId))
        {
            throw new ServiceException("该邀请不是发给您的");
        }
        if (!"0".equals(record.getStatus()))
        {
            throw new ServiceException("该邀请已处理");
        }

        CompTeam team = teamMapper.selectTeamById(record.getTeamId());
        if (team == null)
        {
            throw new ServiceException("队伍不存在");
        }
        if (!"0".equals(team.getStatus()))
        {
            throw new ServiceException("队伍已不可加入");
        }
        if (team.getCurrentMembers() >= team.getMaxMembers())
        {
            throw new ServiceException("队伍已满员");
        }

        int cnt = teamMapper.countMemberByCompIdAndUserId(team.getCompetitionId(), userId);
        if (cnt > 0)
        {
            throw new ServiceException("您已在当前竞赛的队伍中");
        }

        recordMapper.updateStatus(recordId, "1");

        CompTeamMember member = new CompTeamMember();
        member.setTeamId(record.getTeamId());
        member.setUserId(userId);
        member.setUserName(String.valueOf(userId));
        member.setNickName(String.valueOf(userId));
        member.setCreateBy(String.valueOf(userId));
        memberMapper.insertMember(member);

        team.setCurrentMembers(team.getCurrentMembers() + 1);
        team.setUpdateBy(String.valueOf(userId));
        teamMapper.updateTeam(team);
    }

    @Override
    @Transactional
    public void rejectInvitation(Long recordId, Long userId)
    {
        TeamInvitationRecord record = recordMapper.selectById(recordId);
        if (record == null)
        {
            throw new ServiceException("邀请记录不存在");
        }
        if (!record.getInviteeId().equals(userId))
        {
            throw new ServiceException("该邀请不是发给您的");
        }
        if (!"0".equals(record.getStatus()))
        {
            throw new ServiceException("该邀请已处理");
        }
        recordMapper.updateStatus(recordId, "2");
    }

    @Override
    public List<TeamInvitationRecord> getMyInvitations(Long userId)
    {
        return recordMapper.selectByInviteeId(userId);
    }

    @Override
    public List<TeamInvitationRecord> getMySentInvitations(Long userId)
    {
        return recordMapper.selectByInviterId(userId);
    }
}
