<template>
	<div id="app">
		<router-view></router-view>
	</div>
</template>

<script>
	import HelloWorld from './components/HelloWorld.vue'
	import http from "./util/http.js";


	export default {
		name: 'App',
		components: {

		}
		
		
		/* 测试axios连接 */
		/* created() {
			http({
				method: 'get',
				url: '/pinpai/chaXunFenYe',
				params: {
					yeMa: 1
				}
			}).then((res) => {
				console.log(res);
			})
		
		}, */

	}
</script>

<style>
	
</style>
