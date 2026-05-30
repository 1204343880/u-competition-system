import request from '@/utils/request'
import { parseStrEmpty } from "@/utils/ruoyi";

export function listPortalCompetition(query) {
  return request({
    url: '/competition/portal/list',
    method: 'get',
    params: query
  })
}

export function getCompetition(competitionId) {
  return request({
    url: '/competition/portal/' + parseStrEmpty(competitionId),
    method: 'get'
  })
}

export function applyCompetition(data) {
  return request({
    url: '/competition/portal/apply',
    method: 'post',
    data: data
  })
}
