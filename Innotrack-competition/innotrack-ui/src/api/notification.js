import request from '@/utils/request'

export function listNotifications() {
  return request({
    url: '/system/notification/list',
    method: 'get'
  })
}

export function getUnreadCount() {
  return request({
    url: '/system/notification/unread',
    method: 'get'
  })
}

export function markAsRead(id) {
  return request({
    url: '/system/notification/' + id + '/read',
    method: 'put'
  })
}

export function markAllAsRead() {
  return request({
    url: '/system/notification/read-all',
    method: 'put'
  })
}

export function deleteNotifications(ids) {
  return request({
    url: '/system/notification/' + ids,
    method: 'delete'
  })
}
