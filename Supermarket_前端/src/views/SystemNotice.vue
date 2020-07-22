<template>

	<div>
		<el-card class="box-card">
		<el-tabs v-model="activeName" type="card" @tab-click="handleClick">
			<el-tab-pane label="库存不足" name="first">
				<el-table :data="myData1" style="width: 100%">
					<el-table-column prop="goodsId" label="商品编号" width="350">
					</el-table-column>
					<el-table-column prop="goods_name" label="商品名" width="350">
					</el-table-column>
					<el-table-column prop="goodsAmount" label="库存数">
					</el-table-column>
				</el-table>
				<div class="block">
					<span class="demonstration"></span>
					<el-pagination 
					@current-change="handleCurrentChange1" 
					:current-page="currentPage1" 
					:page-size="10"
					layout="total, prev, pager, next, jumper"
					:total="total1" 
					style="float: right;margin-top: 2%;">
					</el-pagination>
				</div>

			</el-tab-pane>

			<el-tab-pane label="剩余过期时间" name="second" @tab-click="getdata">
				<el-table :data="myData2" style="width: 100%">
					<el-table-column prop="goods_id" label="商品编号" width="350">
					</el-table-column>
					<el-table-column prop="goods_name" label="商品名" width="350">
					</el-table-column>
					<el-table-column prop="remain" label="剩余时间/天">
					</el-table-column>
				</el-table>

				<div class="block">
					<span class="demonstration"></span>
					<el-pagination 
					@current-change="handleCurrentChange2" 
					:page-size="10"
					:current-page="currentPage1" layout="total, prev, pager, next, jumper"
					:total="total2" 
					style="float: right;margin-top: 2%;">
					</el-pagination>
				</div>

			</el-tab-pane>

		</el-tabs>
		</el-card>
	</div>


</template>
<script>
	import {
		systemNotice
	} from '../util/api.js'
	import http from '../util/http.js'
	
	export default {
		data() {
			return {
				total1:0,
				total2:0,
				myData1:[],
				myData2:[],
				activeName: 'first',
				currentPage1: 1,

			};
		},
		methods: {
			getdata(){
				
				http({
					method:'get',
					url:systemNotice.change,
					params:{
						pageNo:1
					}
				}).then((res)=>{
					this.total2=res.data.total;
					this.myData2=res.data.list;
					console.log(this.myData2);	
				}).catch(()=>{
					this.$messege({
						type:'error',
						messege:'服务器错误'
					})
				})
			},
			handleClick(tab, event) {
				console.log(tab, event);
				this.getdata();
			},
			
			handleCurrentChange1(val1) {
				var _this= this;
				http({
					method:'get',
					url:systemNotice.notify,
					params:{
						pageNo:val1,
					}
				}).then((res)=>{
					
					_this.myData1=res.data.list;
					console.log(this.myData1);
				})
				console.log(`当前页: ${val1}`);
				
			},
			handleCurrentChange2(val2) {
				http({
					method:'get',
					url:systemNotice.change,
					params:{
						pageNo:val2,
					}
				}).then((res)=>{
					
					this.myData2=res.data.list;
					console.log(this.myData2);
					
					// console.log(res.data.list);
					
					
				})
				console.log(`当前页: ${val2}`);
				
			}

		},
		mounted() {
			var _this= this;
			http({
				method:'get',
				url:systemNotice.notify,
				params:{
					pageNo:1
				}
			}).then((res)=>{
				console.log(res);
				this.total1=res.data.total;
				_this.myData1=res.data.list;
				console.log(_this.myData1);
				
				// console.log(res.data.list);
				
				
			}).catch(()=>{
				this.$messege({
					type:'error',
					messege:'服务器错误'
				})
			})
		}
	};
</script>

<style scoped>

</style>
/style>
