import Vue from 'vue'
import App from './App.vue'
import router from './router'
import store from './store'
// 引入axios
// import http from './util/http.js'
//import vueAxios from 'vue-axios'

// Vue.prototype.axios=http

import echarts from "echarts";
Vue.prototype.$echarts = echarts;

import './plugins/element.js'


Vue.config.productionTip = false;
new Vue({
  router,
  store,
  render: h => h(App)
}).$mount('#app');
