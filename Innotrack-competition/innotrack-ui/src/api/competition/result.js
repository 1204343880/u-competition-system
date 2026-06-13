import request from '@/utils/request'

export function listResult(query) {
  return request({
    url: '/system/competition/result/list',
    method: 'get',
    params: query
  })
}

export function getResult(resultId) {
  return request({
    url: '/system/competition/result/' + resultId,
    method: 'get'
  })
}

export function addResult(data) {
  return request({
    url: '/system/competition/result',
    method: 'post',
    data: data
  })
}

export function updateResult(data) {
  return request({
    url: '/system/competition/result',
    method: 'put',
    data: data
  })
}

export function delResult(resultIds) {
  return request({
    url: '/system/competition/result/' + resultIds,
    method: 'delete'
  })
}

export function auditResult(data) {
  return request({
    url: '/system/competition/result/audit',
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

export function getMyResults() {
  return request({
    url: '/system/competition/result/my',
    method: 'get'
  })
}
