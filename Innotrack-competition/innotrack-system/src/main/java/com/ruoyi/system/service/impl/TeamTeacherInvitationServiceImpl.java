package com.ruoyi.system.service.impl;

import java.util.Date;
import java.util.List;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import com.ruoyi.common.exception.ServiceException;
import com.ruoyi.system.domain.TeamTeacherInvitation;
import com.ruoyi.system.mapper.CompTeamMapper;
import com.ruoyi.system.mapper.TeamTeacherInvitationMapper;
import com.ruoyi.system.service.ITeamTeacherInvitationService;

@Service
public class TeamTeacherInvitationServiceImpl implements ITeamTeacherInvitationService
{
    @Autowired
    private TeamTeacherInvitationMapper invitationMapper;

    @Autowired
    private CompTeamMapper compTeamMapper;

    @Override
    public TeamTeacherInvitation selectInvitationById(Long invitationId)
    {
        return invitationMapper.selectInvitationById(invitationId);
    }

    @Override
    public List<TeamTeacherInvitation> selectInvitationsByTeamId(Long teamId)
    {
        return invitationMapper.selectInvitationsByTeamId(teamId);
    }

    @Override
    public List<TeamTeacherInvitation> selectPendingByTeacherId(Long teacherId)
    {
        return invitationMapper.selectPendingByTeacherId(teacherId);
    }

    @Override
    public List<TeamTeacherInvitation> selectHistoryByTeacherId(Long teacherId)
    {
        return invitationMapper.selectHistoryByTeacherId(teacherId);
    }

    @Override
    public int insertInvitation(TeamTeacherInvitation invitation)
    {
        invitation.setCreateTime(new Date());
        return invitationMapper.insertInvitation(invitation);
    }

    @Override
    @Transactional
    public int acceptInvitation(Long invitationId, String replyMessage, Long teacherId)
    {
        TeamTeacherInvitation invitation = invitationMapper.selectInvitationById(invitationId);
        if (invitation == null)
        {
            throw new ServiceException("邀请记录不存在");
        }
        if (!"0".equals(invitation.getStatus()))
        {
            throw new ServiceException("该邀请已被处理");
        }
        if (!invitation.getTeacherId().equals(teacherId))
        {
            throw new ServiceException("无权操作此邀请");
        }
        TeamTeacherInvitation update = new TeamTeacherInvitation();
        update.setInvitationId(invitationId);
        update.setStatus("1");
        update.setReplyMessage(replyMessage);
        update.setUpdateTime(new Date());
        int rows = invitationMapper.updateStatus(update);
        if (rows == 0)
        {
            throw new ServiceException("该邀请已被处理，请刷新列表");
        }
        compTeamMapper.setTeacher(invitation.getTeamId(), teacherId, invitation.getTeacherName());
        return rows;
    }

    @Override
    public int rejectInvitation(Long invitationId, String replyMessage, Long teacherId)
    {
        TeamTeacherInvitation invitation = invitationMapper.selectInvitationById(invitationId);
        if (invitation == null)
        {
            throw new ServiceException("邀请记录不存在");
        }
        if (!"0".equals(invitation.getStatus()))
        {
            throw new ServiceException("该邀请已被处理");
        }
        if (!invitation.getTeacherId().equals(teacherId))
        {
            throw new ServiceException("无权操作此邀请");
        }
        TeamTeacherInvitation update = new TeamTeacherInvitation();
        update.setInvitationId(invitationId);
        update.setStatus("2");
        update.setReplyMessage(replyMessage);
        update.setUpdateTime(new Date());
        return invitationMapper.updateStatus(update);
    }

    @Override
    public int cancelInvitation(Long invitationId, Long studentId)
    {
        TeamTeacherInvitation invitation = invitationMapper.selectInvitationById(invitationId);
        if (invitation == null)
        {
            throw new ServiceException("邀请记录不存在");
        }
        if (!invitation.getStudentId().equals(studentId))
        {
            throw new ServiceException("无权撤销此邀请");
        }
        if (!"0".equals(invitation.getStatus()))
        {
            throw new ServiceException("该邀请已被处理，无法撤销");
        }
        TeamTeacherInvitation update = new TeamTeacherInvitation();
        update.setInvitationId(invitationId);
        update.setStatus("3");
        update.setUpdateTime(new Date());
        return invitationMapper.updateStatus(update);
    }
}
