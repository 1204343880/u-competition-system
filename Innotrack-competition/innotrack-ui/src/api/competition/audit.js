import request from '@/utils/request'

export function listApplyAudit(query) {
  return request({
    url: '/system/competition/audit/apply/list',
    method: 'get',
    params: query
  })
}

export function auditApply(data) {
  return request({
    url: '/system/competition/audit/apply',
    method: 'put',
    data: data
  })
}

export function listTeamAudit(query) {
  return request({
    url: '/system/competition/audit/team/list',
    method: 'get',
    params: query
  })
}

export function auditTeam(data) {
  return request({
    url: '/system/competition/audit/team',
    method: 'put',
    data: data
  })
}

export function listResultAudit(query) {
  return request({
    url: '/system/competition/result/audit/list',
    method: 'get',
    params: query
  })
}

export function auditResult(data) {
  return request({
    url: '/system/competition/result/audit',
    method: 'put',
    data: data
  })
}
