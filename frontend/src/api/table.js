import request from '@/utils/request'
import qs from 'qs'

export function getList(params) {
  return request({
    url: '/project/indexAjax',
    method: 'get',
    params
  })
}

export function getProjectInfo(params, id) {
  return request({
    url: '/project/edit/ids/' + id,
    method: 'get',
    params
  })
}

export function editProjectInfo(params, data, id) {
  return request({
    url: '/project/edit/ids/' + id,
    method: 'post',
    params,
    data: qs.stringify({ row: data })
  })
}

export function addProject(params, data) {
  return request({
    url: '/project/add',
    method: 'post',
    params,
    data: qs.stringify({ row: data })
  })
}

export function deleteProject(params, id) {
  return request({
    url: '/project/del/ids/' + id,
    method: 'post',
    params
  })
}

export function getUserInfo(params) {
  return request({
    url: '/project/getUserInfo',
    method: 'get',
    params
  })
}

export function uploadProjectRecord(params, data) {
  return request({
    url: '/project_record/add',
    method: 'post',
    params,
    data: qs.stringify({ row: data })
  })
}

export function getMaterialApprovalList(params) {
  return request({
    url: '/material_approval/indexAjax',
    method: 'get',
    params
  })
}

export function getApproval(params, id) {
  return request({
    url: '/material_approval/edit/ids/' + id,
    method: 'get',
    params
  })
}

export function addMaterialApproval(params, data) {
  return request({
    url: '/material_approval/add',
    method: 'post',
    params,
    data: qs.stringify({ row: data })
  })
}

export function deleteApproval(params, id) {
  return request({
    url: '/material_approval/del/ids/' + id,
    method: 'post',
    params
  })
}

export function editApproval(params, data, id) {
  return request({
    url: '/material_approval/edit/ids/' + id,
    method: 'post',
    params,
    data: qs.stringify({ row: data })
  })
}

export function auditApproval(params, data) {
  return request({
    url: '/material_approval/audit',
    method: 'post',
    params,
    data: qs.stringify(data)
  })
}

export function getPurchaseItemList(params, id) {
  return request({
    url: 'material_purchase/indexAjax/ids/' + id,
    method: 'get',
    params
  })
}

export function addPurchaseItem(params, data) {
  return request({
    url: 'material_purchase/add',
    method: 'post',
    params,
    data: data
  })
}

export function editPurchaseItem(params, data, id) {
  return request({
    url: 'material_purchase/edit/ids/' + id,
    method: 'post',
    params,
    data: data
  })
}

export function deletePurchaseItem(params, id) {
  return request({
    url: '/material_purchase/del/ids/' + id,
    method: 'post',
    params
  })
}

// 获取图片列表
export function getImgList(params) {
  return request({
    url: 'project_record/getProjectRecordImg',
    method: 'get',
    params
  })
}

// 获取附件列表
export function getFileList(params) {
  return request({
    url: 'project_record/getProjectRecordFile',
    method: 'get',
    params
  })
}

// 获取施工前六大项
export function getPreContructNotice(params) {
  return request({
    url: '/project_check/indexAjax',
    method: 'get',
    params
  })
}

// 添加施工前六大项
export function addPreContructNotice(params, data) {
  return request({
    url: '/project_check/add',
    method: 'post',
    params,
    data: qs.stringify({ row: data })
  })
}

// 更新施工前六大项
export function editPreContructNotice(params, id, data) {
  return request({
    url: '/project_check/edit/ids/' + id,
    method: 'post',
    params,
    data: qs.stringify({ row: data })
  })
}

// 获取待付款材料
export function getToPayList(params) {
  return request({
    url: 'material_forpay/index',
    method: 'get',
    params
  })
}

// 获取是否有新消息
export function doseHaveNewMsg(params) {
  return request({
    url: 'new_msg',
    method: 'get',
    params
  })
}

// 获取待付款打款信息
export function getPaymentInfo(params) {
  return request({
    url: 'material_forpay/info',
    method: 'get',
    params
  })
}

// 编辑打款信息
export function editPaymentInfo(params, data) {
  return request({
    url: 'material_forpay/edit',
    method: 'post',
    params,
    data: qs.stringify({ row: data })
  })
}

// 获取项目经理列表
export function getManagerList(params) {
  return request({
    url: 'project/manager_list',
    method: 'get',
    params
  })
}
