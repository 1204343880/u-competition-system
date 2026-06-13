import request from '@/utils/request'

export function inviteTeacher(teamId, data) {
  return request({
    url: '/student/team/' + teamId + '/invite-teacher',
    method: 'post',
    data: data
  })
}

export function listTeamInvitations(teamId) {
  return request({
    url: '/student/team/' + teamId + '/invitations',
    method: 'get'
  })
}

export function cancelInvitation(invitationId) {
  return request({
    url: '/student/team/invitation/' + invitationId + '/cancel',
    method: 'delete'
  })
}

export function listPendingInvitations() {
  return request({
    url: '/teacher/invitation/pending',
    method: 'get'
  })
}

export function listInvitationHistory() {
  return request({
    url: '/teacher/invitation/history',
    method: 'get'
  })
}

export function acceptInvitation(invitationId, data) {
  return request({
    url: '/teacher/invitation/' + invitationId + '/accept',
    method: 'put',
    data: data
  })
}

export function rejectInvitation(invitationId, data) {
  return request({
    url: '/teacher/invitation/' + invitationId + '/reject',
    method: 'put',
    data: data
  })
}
