<template>
	<div id="Role">
		<el-card class="box-card">
			<div class="roleTop">
				<div class="baseOperate">
					<el-button @click="add=true" type="primary" round class="el-icon-plus">增 加</el-button>

					<!-- 增加弹框 -->
					<el-dialog title="添加角色" :visible.sync="add" width="50%" >
						<div class="addRole">
							<el-form label-width="80px">
								
								 <el-form-item label="角色名">
								    <el-input v-model="inputRoleName" maxlength="6"
									clearable></el-input>
								  </el-form-item>
								 
								  	<el-form-item label="角色权限">
								  		<el-checkbox :indeterminate="isIndeterminate" v-model="checkAll" @change="handleCheckAllChange">全选</el-checkbox>
								  		<el-checkbox-group v-model="checkRootList" @change="handleCheckedRootsChange">
								  			<el-checkbox v-for="root in roots" :label="root.id" :key="root.id">{{root.permissionName}}</el-checkbox>
								  		</el-checkbox-group>
								  
								  	</el-form-item>
								 
							</el-form>
						</div>
						<span slot="footer" class="dialog-footer">
							<el-button @click="cancelAdd">取 消</el-button>
							<el-button type="primary" @click="confirmAdd">提 交</el-button>
						</span>
					</el-dialog>
					<!-- end增加弹框 -->

				</div>
			</div>
			<div class="roleContent">
				<el-table :data="roleData" border style="width: 100%">
					
					<el-table-column prop="id" label="编号">
					</el-table-column>
					<el-table-column prop="rolename" label="角色名">
					</el-table-column>
					<el-table-column  label="权限">
						<template slot-scope="scope">	
							<el-tag v-for="(permission,id) in scope.row.permissions"
							:key="id" style="margin-left: 0.3125rem; margin-bottom: 0.3125rem;"
							type="success">{{permission.permissionName}}</el-tag>
						</template>
					</el-table-column>
					<el-table-column label="操作">
						<template slot-scope="scope">
							<el-tooltip effect="dark" content="编辑" placement="top-start">
							<el-button size="mini" @click="startModify(scope)" circle type="primary" icon="el-icon-edit"></el-button>
							</el-tooltip>
							<el-tooltip effect="dark" content="删除" placement="top-start">
							<el-button size="mini" @click="deleteOneRole(scope.row.id)" circle type="danger" class="el-icon-delete"></el-button>
							</el-tooltip>
							<!-- 修改权限弹框 -->
							<div id="modify">
								<el-dialog title="修改角色" :visible.sync="modify" width="50%" >
									
									<el-form  label-width="80px" label-position="top">
										<el-form-item label="角色名">
										   <el-input v-model="inputRoleName" maxlength="6"
											clearable></el-input>
										 </el-form-item>
										
										<el-form-item>
											<el-checkbox :indeterminate="isIndeterminate" v-model="checkAll" @change="handleCheckAllChange">全选</el-checkbox>
											<el-checkbox-group v-model="checkRootList" @change="handleCheckedRootsChange">
												<el-checkbox v-for="root in roots" :label="root.id" :key="root.id">{{root.permissionName}}</el-checkbox>

											</el-checkbox-group>

										</el-form-item>
									</el-form>

									<span slot="footer" class="dialog-footer">
										<el-button @click="cancelModify">取 消</el-button>
										<el-button type="primary" @click="submit">提 交</el-button>
									</span>
								</el-dialog>
							</div>
							<!-- end修改弹框 -->

						</template>
					</el-table-column>
				</el-table>

			</div>
			<div class="roleBottom">
				
				<el-pagination background layout="total,prev, pager, next,jumper" 
				:total="total"
				@current-change="handleCurrentChange"
				:page-size="pageSize"
				 
				  :current-page="currentPage">
				</el-pagination>
			</div>
		</el-card>
	</div>
</template>

<script>
	// 引入http
	import http from '../util/http.js'
	//引入接口
	import {role} from '../util/api.js'
	// 引入验证函数
	import validator from '../util/validator.js'
	export default {
		name: 'Role',
		data: function() {
			return {
				// 提示词
				tip:{
					roleName:'',
					rIsHidden:false
				},
				// 当前页
				currentPage:1,
				// 数据总条数
				total:1,
				// 页面数据条数
				pageSize:10,
				// 页面显示最大页数
				pageCount:4,
				// 添加选中权限数据
				checkRootList:[],
				// 全选的标志
				checkAll:false,
				// 不确定状态
				isIndeterminate: false,
				// 添加弹出框
				add: false,
				// 添加输入角色名
				 inputRoleName:'',
				// 修改弹出框
				modify: false,
				// 搜索输入
				searchInput: '',
				//角色的数据 
				roleData: [],
				roots:[],
				// 修改的角色的id
				modifyRoleId:''
			}
		},
		mounted: function() {
			//初始化角色数据
			this.getDataByPage(1);
			http({
				method:'get',
				url:role.showAllRoot
			}).then((res)=>{
				
				if(res.data.code==200){
					this.roots=res.data.data;
				}
				
			}).catch(()=>{
			
				console.log('err');
				this.$message({
					type: 'error',
					message: '服务器错误！'
				});
			})
		},

		methods: {
			///////////////////////////////////////////
			//分页
			//根据页码请求数据
			getDataByPage(page){
				http({
					method:'get',
					url:role.showRole,
					params:{
						pageNo:page
					}
				}).then((res)=>{
					if(res.data.code==200){
						this.roleData=res.data.data.userList;
						this.total=res.data.data.total;
						this.currentPage=page;
					}
				}).catch(()=>{
					this.$message({
						type: 'error',
						message: '服务器错误'
					});
				})
			},
			// 当前页变化事件
			handleCurrentChange(val) {
				console.log("当前页"+val);
				this.getDataByPage(val); //获取当前页数据的函数
			},
			//////////////////////////////////////////////
			//增加
			//全选处理
			 handleCheckAllChange(val) {
					let checkRootList1=[];
			       if(val){
					   let i=0;
					   this.roots.forEach((root)=>{
						   checkRootList1[i++]=root.id;
					   })
				   }else{
					   this.checkRootList=[];
				   }
				  
				  this.checkRootList=checkRootList1;
			        this.isIndeterminate = false;
			},
			// 多选框被选中
			handleCheckedRootsChange(value){
				let checkedCount = value.length;
				this.checkAll = checkedCount === this.roots.length;
				this.isIndeterminate = checkedCount > 0 && checkedCount < this.roots.length;
			},
			
			// 取消添加
			cancelAdd(){
				this.inputRoleName='',
				this.checkAll=false;
				this.add=false;
				this.checkRootList =[];
				 this.isIndeterminate = false;
			},
			// 确认添加
			confirmAdd(){
				if(this.checkRootList==[] || !validator.vCharLength(this.inputRoleName,1,6)){
					this.$message({
						type:'info',
						message:'请输入'
					})
				}else{
					http({
						method:'post',
						url:role.addRole,
						data:{
							 permissionIdList:this.checkRootList,
							 roleName:this.inputRoleName
						}
					}).then((res)=>{
						console.log(res);
						if(res.data.code==200){
							this.$message({
								type:'success',
								message:'添加成功'
							})
							this.getDataByPage(1111);
							this.cancelAdd();
						}else{
							this.$message({
								type:'error',
								message:'添加失败'
							})
						}
					}).catch(()=>{
						this.$message({
							type:'error',
							message:'服务器错误'
						})
					})
				}
			},
			
			/////////////////////////////////////////////////
			// 开始修改
			startModify(scope){
				console.log(this.roleData);
				this.modify=true;
				this.modifyRoleId=scope.row.id;
				this.inputRoleName=this.roleData[scope.$index].rolename;
				
				// let i=0;
				// this.roleData[scope.$index].permissions.forEach((root)=>{
				// 	console.log(this);
				// 	this.$set(this.checkRootList,i++,root.id) ;
				// })
				// console.log(this.checkRootList);
			},
			// 取消修改
			cancelModify(){
				this.modify = false;
				this.checkRootList = [];
				this.inputRoleName="";
				this.isIndeterminate=false;
				this.checkAll=false;
			},
			// 提交修改后的角色权限
			submit() {
				console.log()
				if(this.inputRoleName=="" || this.checkRootList.length==0){
					this.$message({
						type: 'info',
						message: '用户名或权限不能为空'
					});
				}else{
					http({
						method:'post',
						url:role.roleUpdate,
						data:{
							rolename:this.inputRoleName,
							permissionIdList: this.checkRootList,
							roleId:this.modifyRoleId
						}
					}).then((res) => {
						console.log(res);
						if(res.data.code==200){
							this.getDataByPage(this.currentPage);
							this.$message({
								type: 'success',
								message: '修改成功!'
							});
							this.cancelModify();
						}else{
							this.$message({
								type: 'error',
								message: '修改失败'
							});
						}
					}).catch(function() {
						this.$message({
							type: 'error',
							message: '服务器错误'
						});
					})
				}
			},
			
			
			///////////////////////////////////////////////
			// 单条数据删除
			deleteOneRole(roleId){
				this.$confirm('此操作将永久删除该数据, 是否继续?', '提示', {
					confirmButtonText: '确定',
					cancelButtonText: '取消',
					type: 'warning'
				}).then(() => {
					console.log(roleId);
					http({
						method:'get',
						url:role.deleteOneRole,
						params:{
							roleId:roleId,
						}
					}).then((res)=>{
						if(res.data.code==200){
							this.$message({
								type: 'success',
								message: '删除成功!'
							});
						}else{
							this.$message({
								type: 'error',
								message: '删除失败!'
							});
						}
					})
					this.getDataByPage(this.currentPage);
					
				})
			}
		}
	}
</script>

<style>
	

	/* 上面 */
	#Role .roleTop {
		display: flex;
	}

	#Role .roleTop .baseOperate {
		flex: 2;
	}

	#Role .roleTop .baseOperate .el-button {
		margin-right: 1.25rem;
	}

	#Role .roleTop .search {
		flex: 1;
		display: flex;
	}

	#Role .roleTop .search el-input {

		flex: 2;
	}

	#Role .roleTop .search .el-input__inner {
		border-radius: 4px 0 0 4px;
	}

	#Role .roleTop .search .el-button {
		flex: 1;
		border-radius: 0 4px 4px 0;
		border-left: none;
	}

	/* 内容 */
	#Role .roleContent {
		margin-top: 1.875rem;
	}

	#Role .roleContent .el-table td,
	#Role .roleContent .el-table th {
		text-align: center;
	}

	#modify {
		text-align: left !important;
	}

	/* 底部分页 */
	#Role .roleBottom {
		display: flex;
		justify-content: flex-end;
		margin-top: 3.125rem;
		
	}
	#Role .roleBottom span{
		font-size: 0.875rem;
		color: #aaa;
		line-height: 2rem;
	}
</style>
