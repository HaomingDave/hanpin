import Vue from 'vue'
import Router from 'vue-router'

Vue.use(Router)

/* Layout */
import Layout from '@/layout'
import ProjectLayout from '@/layout/projectLayout'

export const constantRoutes = [
  {
    path: '/login',
    component: () => import('@/views/login/index'),
    hidden: true
  },
  {
    path: '/404',
    component: () => import('@/views/404'),
    hidden: true
  },
  {
    path: '/',
    redirect: '/index/projectList'
  },
  {
    path: '/index',
    component: ProjectLayout,
    children: [{
      path: 'projectList',
      name: 'projectList',
      component: () => import('@/views/projectList/index'),
      meta: { title: '项目列表', icon: 'dashboard' },
      hidden: true
    }]
  },

  {
    path: '/project',
    component: Layout,
    children: [{
      path: 'info',
      name: 'projectInfo',
      component: () => import('@/views/form/index'),
      meta: { title: '基本信息', icon: 'dashboard', role: ['6', '7'], hidden: true }
    }]
  },

  {
    path: '/project',
    component: Layout,
    children: [
      {
        path: 'imgRecord',
        name: 'ImgRecord',
        component: () => import('@/views/imageRecord/index'),
        meta: { title: '图片记录', icon: 'form', role: ['6', '7'], hidden: true, new: false }
      }
    ]
  },

  {
    path: '/project',
    component: Layout,
    children: [
      {
        path: 'dayExamineItems',
        name: 'dayExamineItems',
        component: () => import('@/views/dayExamineItems/index'),
        meta: { title: '每日自查项目', icon: 'form', role: ['6', '7'], hidden: true, new: false }
      }
    ]
  },
  {
    path: '/project',
    component: Layout,
    children: [
      {
        path: 'planning',
        name: 'planning',
        component: () => import('@/views/planning/index'),
        meta: { title: '计划安排', icon: 'form', role: ['6', '7'], hidden: true, new: false }
      }
    ]
  },
  {
    path: '/project',
    component: Layout,
    children: [
      {
        path: 'controlNode',
        name: 'controlNode',
        component: () => import('@/views/controlNode/index'),
        meta: { title: '施工节点控制记录', icon: 'form', role: ['6', '7'], hidden: true, new: false }
      }
    ]
  },
  {
    path: '/project',
    component: Layout,
    children: [
      {
        path: 'sixRules',
        name: 'sixRules',
        component: () => import('@/views/sixRules/index'),
        meta: { title: '施工前六大项', icon: 'form', role: ['6', '7'], hidden: true }
      }
    ]
  },
  {
    path: '/project',
    component: Layout,
    children: [
      {
        path: 'materialPurchase',
        name: 'materialPurchase',
        component: () => import('@/views/materialPurchase/index'),
        meta: { title: '采购申请', icon: 'form', role: ['6', '7', '8'], hidden: true, new: false }
      }
    ]
  },
  {
    path: '/project',
    component: Layout,
    children: [
      {
        path: 'purchaseDetail',
        name: 'purchaseDetail',
        component: () => import('@/views/materialPurchase/detail'),
        meta: { title: '采购单列表', icon: 'form' },
        hidden: true
      }
    ]
  },
  {
    path: '/project',
    component: Layout,
    children: [
      {
        path: 'materialPayment',
        name: 'materialPayment',
        component: () => import('@/views/materialPayment/index'),
        meta: { title: '材料待付款表', icon: 'form', role: ['8', '7'], hidden: true }
      }
    ]
  },

  // 404 page must be placed at the end !!!
  { path: '*', redirect: '/404', hidden: true }
]

const createRouter = () => new Router({
  // mode: 'history', // require service support
  scrollBehavior: () => ({ y: 0 }),
  routes: constantRoutes
})

const router = createRouter()

// Detail see: https://github.com/vuejs/vue-router/issues/1234#issuecomment-357941465
export function resetRouter() {
  const newRouter = createRouter()
  router.matcher = newRouter.matcher // reset router
}

export default router
