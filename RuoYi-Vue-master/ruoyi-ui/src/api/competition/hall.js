import request from '@/utils/request'

export function listCompetition(query) {
  return request({
    url: '/student/hall/list',
    method: 'get',
    params: query
  })
}

export function getCompetition(competitionId) {
  return request({
    url: '/student/hall/' + competitionId,
    method: 'get'
  })
}

export function applyCompetition(competitionId) {
  return request({
    url: '/student/hall/' + competitionId + '/apply',
    method: 'post'
  })
}

export function listMyApplies() {
  return request({
    url: '/student/hall/my-applies',
    method: 'get'
  })
}

export function cancelApply(competitionId) {
  return request({
    url: '/student/hall/' + competitionId + '/apply',
    method: 'delete'
  })
}
