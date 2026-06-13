import request from '@/utils/request'

export function createTeam(competitionId, teamName) {
  return request({
    url: '/student/team/create/' + competitionId,
    method: 'post',
    params: { teamName }
  })
}

export function joinTeam(competitionId, inviteCode) {
  return request({
    url: '/student/team/join/' + competitionId,
    method: 'post',
    data: { inviteCode }
  })
}

export function leaveTeam(teamId) {
  return request({
    url: '/student/team/' + teamId + '/leave',
    method: 'delete'
  })
}

export function disbandTeam(teamId) {
  return request({
    url: '/student/team/' + teamId + '/disband',
    method: 'delete'
  })
}

export function getMyTeam(competitionId) {
  return request({
    url: '/student/team/my-team/' + competitionId,
    method: 'get'
  })
}

export function getMyTeams() {
  return request({
    url: '/student/team/my-teams',
    method: 'get'
  })
}

export function getTeamMembers(teamId) {
  return request({
    url: '/student/team/' + teamId + '/members',
    method: 'get'
  })
}

export function transferLeader(teamId, memberId) {
  return request({
    url: '/student/team/' + teamId + '/transfer/' + memberId,
    method: 'post'
  })
}

export function getPublicTeams(competitionId) {
  return request({
    url: '/student/team/public',
    method: 'get',
    params: { competitionId }
  })
}

export function toggleTeamPublic(teamId, isPublic) {
  return request({
    url: '/student/team/' + teamId + '/toggle-public',
    method: 'put',
    params: { isPublic }
  })
}

export function updateTeamSkills(teamId, skills) {
  return request({
    url: '/student/team/' + teamId + '/skills',
    method: 'put',
    params: { skills }
  })
}

export function getMarketList(skills) {
  return request({
    url: '/student/market/list',
    method: 'get',
    params: { skills }
  })
}

export function toggleMarket() {
  return request({
    url: '/student/market/toggle',
    method: 'put'
  })
}

export function listTeacherTeams() {
  return request({
    url: '/teacher/team/list',
    method: 'get'
  })
}

export function submitTeam(teamId) {
  return request({
    url: '/student/team/' + teamId + '/submit',
    method: 'put'
  })
}

export function auditTeam(data) {
  return request({
    url: '/system/competition/audit/team',
    method: 'put',
    data: data
  })
}

export function listTeamAuditList(query) {
  return request({
    url: '/system/competition/audit/team/list',
    method: 'get',
    params: query
  })
}

export function getTeamDetail(teamId) {
  return request({
    url: '/system/competition/audit/team/' + teamId,
    method: 'get'
  })
}

export function inviteFromMarket(userId, teamId) {
  return request({
    url: '/student/market/invite/' + userId,
    method: 'post',
    params: { teamId }
  })
}

export function getMyInvitations() {
  return request({
    url: '/student/market/invitations',
    method: 'get'
  })
}

export function acceptInvitation(recordId) {
  return request({
    url: '/student/team/invite/accept/' + recordId,
    method: 'put'
  })
}

export function rejectInvitation(recordId) {
  return request({
    url: '/student/team/invite/reject/' + recordId,
    method: 'put'
  })
}
