import request from '@/utils/request'

export function listCompetition(query) {
  return request({ url: '/system/competition/list', method: 'get', params: query })
}

export function getCompetition(id) {
  return request({ url: '/system/competition/' + id, method: 'get' })
}

export function addCompetition(data) {
  return request({ url: '/system/competition', method: 'post', data })
}

export function updateCompetition(data) {
  return request({ url: '/system/competition', method: 'put', data })
}

export function delCompetition(ids) {
  return request({ url: '/system/competition/' + ids, method: 'delete' })
}
