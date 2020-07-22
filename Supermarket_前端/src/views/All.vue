<template>
    <div id="All">
    	<el-container>
    		<el-header>
    			<el-row type="flex" class="row-bg" justify="space-around">
    				<el-col :span="6">
    					<div class="grid-content bg-purple"><span style="float: left; font-size: 30px;"><strong>超市库存系统</strong></span></div>
    				</el-col>
    				<el-col :span="6">
    					<div class="grid-content bg-purple-light" style="clear: both;"></div>
    				</el-col>
    				<el-col :span="12">
    					<div class="grid-content bg-purple">
    						<el-row class="demo-avatar demo-basic">
    							<div class="demo-basic--circle" style=" height: 60px; float: right;">
    								<el-avatar :size="50" :src="circleUrl" style="vertical-align: middle;margin-right: 0.625rem;">
    								</el-avatar>
    								<el-dropdown>
    									<el-button type="primary" round>
    										{{userName}}<i class="el-icon-arrow-down el-icon--right"></i>
    									</el-button>
    									<el-dropdown-menu slot="dropdown">
    										<el-dropdown-item @click.native="shutDown">注销</el-dropdown-item>
    									</el-dropdown-menu>
    								</el-dropdown>
    								</el-dropdown>
    							</div>
    						</el-row>
    					</div>
    				</el-col>
    			</el-row>
    		</el-header>
    		<el-container>
    			<el-aside width="200px">
    				<el-col>
    					<el-menu class="el-menu-vertical-demo" background-color="#545c64"  text-color="#fff"
    					 active-text-color="#ffd04b" :default-active="this.$route.path" router>
    						<el-menu-item-group v-for="(v,i) in data1" :key="i">
    							<el-menu-item  router="true"  v-for="(children,n) in v.children"  :index="children.path" :key="n">								
    									{{children.name}}
    							</el-menu-item>
    						</el-menu-item-group>
    					</el-menu>
    				</el-col>
					
    			</el-aside>
    			<el-main>
    				<router-view></router-view>
    			</el-main>
    		</el-container>
    	</el-container>
    </div>
</template>

<script>
	import http from '../util/http.js'
    export default {
        name: "All",
		data() {
			return {
				circleUrl: "https://images.pexels.com/photos/839011/pexels-photo-839011.jpeg?auto=compress&cs=tinysrgb&dpr=1&w=500",
				data1:[],
				userName:""
			}
		},
		mounted(){
			console.log(this.$router.options.routes)
			this.data1=this.$router.options.routes
		},
		methods:{
			shutDown(){
				http({
					method:'get',
					url:'/logout'
				}).then((res)=>{
					console.log(res)
					if(res.data.code === 200){
						console.log(res)
						this.$router.push("/")
						window.localStorage.removeItem("userName")
					}else{
						alert("失败")
					}
				}).catch(()=>{
					console.log("注销失败")
				})
			}
		},
		created() {
			this.userName = localStorage.getItem("userName")
			console.log(this.userName)
		}
    }
</script>

<style scoped>
	.el-header,
	.el-footer {
		background-color: #B3C0D1;
		color: #333;
		text-align: center;
		line-height: 60px;
	}

	.el-aside {
		height: 792px;
		background-color: #545c64;
		color: #333;
		text-align: center;
		line-height: 200px;
		overflow: hidden;
	}

	

	body>.el-container {
		margin-bottom: 40px;
	}

	.el-container:nth-child(4) .el-aside {
		line-height: 320px;
	}
</style>