import request from '@/utils/request'
import { parseStrEmpty } from "@/utils/ruoyi";

export function listCompetition(query) {
  return request({
    url: '/competition/admin/list',
    method: 'get',
    params: query
  })
}

export function getCompetition(competitionId) {
  return request({
    url: '/competition/admin/' + parseStrEmpty(competitionId),
    method: 'get'
  })
}

export function addCompetition(data) {
  return request({
    url: '/competition/admin',
    method: 'post',
    data: data
  })
}

export function updateCompetition(data) {
  return request({
    url: '/competition/admin',
    method: 'put',
    data: data
  })
}

export function delCompetition(competitionIds) {
  return request({
    url: '/competition/admin/' + competitionIds,
    method: 'delete'
  })
}
