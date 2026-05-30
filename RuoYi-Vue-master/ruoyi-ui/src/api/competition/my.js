import request from '@/utils/request'
import { parseStrEmpty } from "@/utils/ruoyi";

// 查询竞赛列表
export function listCompetition(query) {
  return request({
    url: '/competition/list',
    method: 'get',
    params: query
  })
}

// 查询我的竞赛列表
export function listMyCompetition(query) {
  return request({
    url: '/competition/my/list',
    method: 'get',
    params: query
  })
}

// 查询竞赛详情
export function getCompetition(competitionId) {
  return request({
    url: '/competition/my/' + parseStrEmpty(competitionId),
    method: 'get'
  })
}

// 报名竞赛
export function applyCompetition(data) {
  return request({
    url: '/competition/my/apply',
    method: 'post',
    data: data
  })
}

// 取消报名
export function cancelCompetition(competitionId) {
  return request({
    url: '/competition/my/cancel/' + competitionId,
    method: 'delete'
  })
}

// 删除竞赛
export function deleteCompetition(competitionId) {
  return request({
    url: '/competition/list/' + competitionId,
    method: 'delete'
  })
}