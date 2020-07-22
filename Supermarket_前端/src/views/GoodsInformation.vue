
<template>
	<div>
		<el-card class="box-card">
		<el-tabs v-model="activeName" @tab-click="handleClick">
			<!--        第一个页面商品基础信息-->
			<el-tab-pane label="商品信息" name="first" >
				<!--            商品信息table-->
				<el-table ref="multipleTable" 
				:data="tableData" 
				tooltip-effect="dark" 
				style="width: 100%" 
				@selection-change="handleSelectionChange">
					<!-- <el-table-column type="selection" width="55">
					</el-table-column> -->
					<el-table-column prop="id" label="商品ID" width="120">
						<!--                    <template slot-scope="scope">{{ scope.row.date }}</template>-->
					</el-table-column>
					<el-table-column prop="goodsName" label="商品名称" width="140">
					</el-table-column>
					<el-table-column prop="name" label="商品分类" width="140">
					</el-table-column>
					<el-table-column prop="shelfLife" label="保质日期" width="230">
					</el-table-column>
					<!--<el-table-column
                            prop="goodsCount"
                            label="商品数量"
                            width="120">
                    </el-table-column>-->
					<el-table-column prop="goodsDesc" label="商品描述" width="230">
					</el-table-column>


					<el-table-column prop="goodsEdit" label="操作" width="80">
						<template slot-scope="scope">
							<!-- dialogFormVisible = true -->
							<el-button type="primary" icon="el-icon-edit" circle @click="update_search(scope)"></el-button>
						</template>
						<!--                    <el-button type="text" @click="dialogFormVisible = true">打开嵌套表单的 Dialog</el-button>-->
					</el-table-column>

					<el-table-column prop="goodsDelete" label="删除" width="80">
						<template slot-scope="scope">
							<el-button type="danger" icon="el-icon-delete" circle @click="delete1(scope)"></el-button>
						</template>

					</el-table-column>
					<!--                分页-->
				</el-table>
				<div class="block">
					<el-pagination 
					@size-change="handleSizeChange" 
					@current-change="handleCurrentChange" 
					:current-page.sync="currentPage"
					:page-size="size" 
					layout="total, prev, pager, next" 
					:total="total"
					style="float: right;margin-top: 2%;">
					</el-pagination>
				</div>

				<el-form>
					<!--                编辑商品按钮-->
					<el-dialog title="编辑商品" :visible.sync="dialogFormVisible">
						<el-form :model="form">
							<el-form-item label="商品名称" :label-width="formLabelWidth">
								<el-input v-model="form.goodsName" autocomplete="off"></el-input>
							</el-form-item>
							<el-form-item label="商品分类" :label-width="formLabelWidth">
								<el-select v-model="types" value-key="key" >
										<el-option  v-for="(n,i) in lab" :label="n.display_name" :value="n.key" :key="n.key"></el-option>
									<!--                                <el-option label="服饰 value="fushi"></el-option>-->
								</el-select>
							</el-form-item>
							<el-form-item label="保质日期" :label-width="formLabelWidth">
								<el-input v-model="form.goodsTime" autocomplete="off"></el-input>
							</el-form-item>
							<!--                            <el-form-item label="商品数量" :label-width="formLabelWidth">-->
							<!--                                <el-input v-model="form.goodsCount" autocomplete="off"></el-input>-->
							<!--                            </el-form-item>-->
							<el-form-item label="商品描述" :label-width="formLabelWidth">
								<el-input v-model="form.desc" autocomplete="off"></el-input>
							</el-form-item>
						</el-form>
						<div slot="footer" class="dialog-footer" >
							<!-- ialogFormVisible = false -->
							<el-button @click="clean()">取 消</el-button>
							<el-button type="primary" @click="update(index)">确 定</el-button>
						</div>
					</el-dialog>
				</el-form>
			</el-tab-pane>

			<!--        第二个页面添加商品-->
			<el-tab-pane label="添加商品" name="second">
				<div id="add" style="vertical-align: middle">
					<span> 商品名称：</span>
					<el-input v-model="form.goodsName" placeholder="请输入商品名称" style="width:50%;margin-left: 50px;"></el-input>
					<br>
					<span> 商品分类：</span>
					<el-select v-model="types" placeholder="请选择" style="width:50%;margin-left: 50px;">
						<el-option v-for="item in lab" :key="item.key" :label="item.display_name" :value="item.key">
						</el-option>
					</el-select>
					<br>
					<span> 保质期：</span>
					
					<el-input v-model="form.goodsTime" placeholder="请输入商品保质期/天" style="width:50%;margin-left: 66px;"></el-input>
					<br>
					<span> 生产日期：</span>
					<el-date-picker
					      v-model="form.productTime"
					      type="date"
					      placeholder="请输入生产日期"
						   style="width:50%;margin-left: 50px;">
					    </el-date-picker>
					<!-- <el-input v-model="form.productTime" placeholder="请输入生产日期" style="width:50%;margin-left: 50px;"></el-input> -->
					<br>
					<span> 商品描述：</span>
					<el-input v-model="form.desc" placeholder="请输入商品描述" style="width:50%;margin-left: 50px;"></el-input>
					<br>

					<el-button type="primary" plain style="margin-left:260px;margin-top: 100px;" @click="add">添加商品
					</el-button>

				</div>
			</el-tab-pane>

		</el-tabs>
		</el-card>
	</div>
</template>
<script>
	import http from "../util/http";
	import {
		initGF,
		GFadd
	} from "../util/api";


	export default {
		data() {
			return {
				
				activeName: 'first',
				types:'',
				index:'',
				lab:[
					{
						key:"生活用品",display_name:'生活用品'
					},
					{
						key:"生鲜水果",display_name:'生鲜水果'
					},
					{
						key:"家电",display_name:'家电'
					},
					{
						key:"数码",display_name:'数码'
					},
					{
						key:"食品",display_name:'食品'
					},
					{
						key:"其他",display_name:'其他'
					},
				],
				tableData: [
				],
				currentPage: 1,
				multipleSelection: [],
				dialogFormVisible: false,
				form: {
					productTime:'',
					goodsName: '',
					goodsTime: '',
					goodsCount: '',
					goodsMs: '',
					goodsType: '',
					delivery: false,
					type: [],
					resource: '',
					desc: ''
				},
				formLabelWidth: '120px',
				dialogVisible: false,
				total:0,
				size:1,
				value: '',
				visible: false,
			};
		},
		created() {
			http({
				method: 'post',
				url: initGF,
				params: {
					pageNo: 1
				}
			}).then((res) => {
				this.total = res.data.data.total;
				this.size = res.data.data.list.length
				console.log(res.data.data)
				// console.log(res);
				if (res.status === 200) {
					this.tableData = res.data.data.list;
				}
			}).catch(() => {
				alert("err")
			})
		},
		methods: {
			update(index){
				this.dialogFormVisible=false,
				http({
					method:'get',
					url:'/goods/update',
					params:{
						id: this.tableData[index].id,
						goodsName: this.form.goodsName,
						name: this.types,
						shelfLife: this.form.goodsTime,
						goodsDesc: this.form.desc
					}
				}).then((res)=>{
					this.form.goodsName=''
					this.form.goodsTime=''
					this.form.desc=''
					this.types=''
					this.$message({
						type: 'success',
						message: '更新成功!'
					});
					http({
						method: 'post',
						url: initGF,
						params: {
							pageNo: 1
						}
					}).then((res) => {
						// console.log(res);
						if (res.status === 200) {
							this.tableData = res.data.data.list;
						}
					}).catch(() => {
						alert("err")
					})
				}).catch(()=>{
					this.$message({
						type: 'info',
						message: '更新失败'
					});
				})
				console.log("id",this.tableData[index].id)
			},
			update_search(scope){
				this.dialogFormVisible = true 
				console.log(scope.$index)
				http({
					method:"get",
					url:'/goods/search',
					params:{
						goodsName:this.tableData[scope.$index].goodsName
					}
				}).then((res) =>{
					
					/* goodsTime: '',
					goodsCount: '',
					goodsMs: '',
					goodsType: '',
					delivery: false,
					type: [],
					resource: '',
					desc: '' */
					console.log(res.data.data.list[0].shelfLife)
					/* res.data.data.list.goodsName */
					this.form.goodsName = this.tableData[scope.$index].goodsName
					this.form.goodsTime = res.data.data.list[0].shelfLife
					this.types = scope.row.name
					this.form.desc = this.tableData[scope.$index].goodsDesc
					this.index = scope.$index
					console.log(this.tableData[scope.$index].goodsDesc)
				}).catch(()=>{
					console.log("搜索方法出错")
					console.log(this.tableData[scope.$index].goodsName)
				})
				
			},
			delete1(scope) {
				this.dialogVisible = false;
				http({
					method:"get",
					url:'/goods/delete',
					params: {
						id:this.tableData[scope.$index].id
					}
				}).then((res)=>{
					this.tableData.splice(scope.$index-1,1)
					console.log(this.tableData[scope.$index].id)
					http({
						method: 'post',
						url: initGF,
						params: {
							pageNo: 1
						}
					}).then((res) => {
						// console.log(res);
						if (res.status === 200) {
							this.tableData = res.data.data.list;
						}
					}).catch(() => {
						alert("err")
					})
				}).catch(()=>{
					console.log("error")
					console.log(this.tableData[scope.$index].id)
				})
			},
			handleClick(tab, event) {
				console.log(tab, event);
			},
			toggleSelection(rows) {
				if (rows) {
					rows.forEach(row => {
						this.$refs.multipleTable.toggleRowSelection(row);
					});
				} else {
					this.$refs.multipleTable.clearSelection();
				}
			},
			handleSelectionChange(val) {
				this.multipleSelection = val;
			},
			handleSizeChange(val) {
				console.log(`每页 ${val} 条`);
			},
			handleCurrentChange(val) {
				console.log(val);
				http({
					method: 'post',
					url: '/goods',
					params: {
						pageNo: val
					}
				}).then((res) => {
					if (res.status === 200) {
						this.tableData = res.data.data.list;
					}
				})
			},
			handleClose(done) {
				this.$confirm('确认关闭？')
					.then(_ => {
						done();
					})
					.catch(_ => {});
			},
			add() {
				http({
					method:"get",
					url:'/goods/add',
					params:{
						goodsName:this.form.goodsName,
						shelfLife: this.form.goodsTime,
						goodsDesc: this.form.desc,
						name: this.types,
						productTime: this.form.productTime
					}
				}).then((res)=>{
					console.log(res)
					this.$message({
						type: 'success',
						message: '添加成功!'
					});	
						/* console.log(res.data.data.msg)
						console.log(res.data.data.code) */
				}).catch(()=>{
					this.$message({
						type: 'info',
						message: '添加出错'
					});
				})
			},
			clean(){
				this.dialogFormVisible = false
				this.form.goodsName=''
				this.form.goodsTime=''
				this.form.desc=''
				this.types=''
			}
			
		}

	};
	/* this.$confirm('是否添加此商品？', '提示', {
		confirmButtonText: '确定',
		cancelButtonText: '取消',
		type: 'warning'
	}).then(() => {
		this.$message({
			type: 'success',
			message: '添加成功!'
		});
	}).catch(() => {
		this.$message({
			type: 'info',
			message: '已取消添加'
		});
	}); */
	/* http({
		
	}) */

</script>
