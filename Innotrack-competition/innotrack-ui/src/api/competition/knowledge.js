import request from '@/utils/request'

export function listRetrospect(query) {
  return request({
    url: '/student/knowledge/retrospect/list',
    method: 'get',
    params: query
  })
}

export function getRetrospect(retrospectId) {
  return request({
    url: '/student/knowledge/retrospect/' + retrospectId,
    method: 'get'
  })
}

export function addRetrospect(data) {
  return request({
    url: '/student/knowledge/retrospect',
    method: 'post',
    data: data
  })
}

export function updateRetrospect(data) {
  return request({
    url: '/student/knowledge/retrospect',
    method: 'put',
    data: data
  })
}

export function delRetrospect(retrospectIds) {
  return request({
    url: '/student/knowledge/retrospect/' + retrospectIds,
    method: 'delete'
  })
}

export function listExperience(query) {
  return request({
    url: '/student/knowledge/experience/list',
    method: 'get',
    params: query
  })
}

export function getExperience(experienceId) {
  return request({
    url: '/student/knowledge/experience/' + experienceId,
    method: 'get'
  })
}

export function addExperience(data) {
  return request({
    url: '/student/knowledge/experience',
    method: 'post',
    data: data
  })
}

export function updateExperience(data) {
  return request({
    url: '/student/knowledge/experience',
    method: 'put',
    data: data
  })
}

export function delExperience(experienceIds) {
  return request({
    url: '/student/knowledge/experience/' + experienceIds,
    method: 'delete'
  })
}

export function listAuditRetrospect(query) {
  return request({
    url: '/system/knowledge/audit/retrospect/list',
    method: 'get',
    params: query
  })
}

export function auditRetrospect(data) {
  return request({
    url: '/system/knowledge/audit/retrospect',
    method: 'put',
    data: data
  })
}

export function listAuditExperience(query) {
  return request({
    url: '/system/knowledge/audit/experience/list',
    method: 'get',
    params: query
  })
}

export function auditExperience(data) {
  return request({
    url: '/system/knowledge/audit/experience',
    method: 'put',
    data: data
  })
}

export function getAuditRetrospect(retrospectId) {
  return request({
    url: '/system/knowledge/audit/retrospect/' + retrospectId,
    method: 'get'
  })
}

export function getAuditExperience(experienceId) {
  return request({
    url: '/system/knowledge/audit/experience/' + experienceId,
    method: 'get'
  })
}

export function listMyRetrospects(query) {
  return request({
    url: '/student/knowledge/retrospect/my-submissions',
    method: 'get',
    params: query
  })
}

export function listMyExperiences(query) {
  return request({
    url: '/student/knowledge/experience/my-submissions',
    method: 'get',
    params: query
  })
}

export function getRetrospectRaw(retrospectId) {
  return request({
    url: '/student/knowledge/retrospect/raw/' + retrospectId,
    method: 'get'
  })
}

export function getExperienceRaw(experienceId) {
  return request({
    url: '/student/knowledge/experience/raw/' + experienceId,
    method: 'get'
  })
}
