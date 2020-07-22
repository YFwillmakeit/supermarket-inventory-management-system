import Vue from 'vue'
import VueRouter from 'vue-router'
import Login from "../views/Login.vue";


Vue.use(VueRouter)

const routes = [
	{
		path:'/all',
		name:'guanli',
		component: () => import('../views/All.vue'),
		redirect: "/all/role",
		children:[
			{
				path: '/all/role',
				name: '角色管理',
				component: () => import( '../views/Role.vue')
			},
			{
				path: '/all/workersManagement',
				name: '员工管理',
				component: () => import( '../views/WorkersManagement.vue')
			},
			{
				path: '/all/StockAll',
				name: '库存记录',
				component: () => import( '../views/StockAll.vue')
			},
			{
			
				path: '/all/stockOut',
				name: '出库管理',
				component: () => import('../views/StockOut.vue')
			},
			{
				path: '/all/stockIn',
				name: '入库管理',
				component: () => import( '../views/StockIn.vue')
			},
			{
				path: '/all/goodsInformation',
				name: '商品信息',
				component: () => import('../views/GoodsInformation.vue')
			},
			{
				path: '/all/systemNotice',
				name: '系统通知',
				component: () => import( '../views/SystemNotice.vue')
			},
			{
				path: '/all/excelTotal',
				name: '报表统计',
				component: () => import(  '../views/ExcelTotal.vue')
			}
			
		]
	},
	{
			path: '/',
			name: 'Login',
			component: Login
	}
]

const router = new VueRouter({
	mode: 'history',
	base: process.env.BASE_URL,
	routes
})
router.beforeEach(function(to, from, next) {

    if (!localStorage.getItem("userName")) {
        if (to.path !== '/') {
            return next('/')
        }
    }
    next()
})

export default router
