<template>
    <div class="stockIn">
		<el-card class="box-card">
        <div class="header">
            <el-button @click="change(0)">入库记录</el-button>
            <el-button @click="change(1)">商品入库</el-button>
        </div>
        <div :class="[isShow == 0?'mainActive':'main']" id="show1">
            <div>
                <el-table
                        :data="tableData"
                        style="width: 100%">
                    <el-table-column
                            fixed
                            label="编号"
                            width="150"
                            prop="id">
                    </el-table-column>
                    <el-table-column
                            label="商品名称"
                            width="150"
                            prop="goods_name">
                    </el-table-column>
                    <el-table-column
                            prop="name"
                            label="商品分类"
                            width="150">
                    </el-table-column>
                    <el-table-column
                            prop="amount"
                            label="入库数量"
                            width="120">
                    </el-table-column>
                    <el-table-column
                            prop="time"
                            label="入库日期"
                            width="120">
                    </el-table-column>
                    <el-table-column
                            prop="username"
                            label="操作人员"
                            width="100">
                    </el-table-column>
                    <el-table-column
                            align="right">
                        <template slot="header" slot-scope="scope">
                            <el-input
                                    v-model="searchMes"
                                    size="mini"
                                    placeholder="输入商品名称关键字搜索" style="width: 230px;margin-right: 10px"/>
                            <el-button icon="el-icon-search" circle @click="click(searchMes)"></el-button>
                        </template>
                        <template slot-scope="scope">
                            <el-button
                                    size="mini"
                                    @click="mesEdit(scope)">编辑</el-button>
                            <el-button
                                    size="mini"
                                    type="danger"
                                    @click="handleDelete(scope)">删除</el-button>
                        </template>
                    </el-table-column>
                </el-table>
            </div>
            <!--编辑弹框-->
            <div id="edit">
                <el-dialog title="入库商品信息修正" :visible.sync="dialogFormVisible">
                    <el-form>
                        <el-form-item label="商品名称" :label-width="formLabelWidth">
                            <el-input v-model="mesForm.goodsName"></el-input>
                        </el-form-item>
                        <el-form-item label="商品分类" :label-width="formLabelWidth">
                            <el-input v-model="mesForm.name" ></el-input>
                        </el-form-item>
                        <el-form-item label="入库数量" :label-width="formLabelWidth">
                            <el-input v-model="mesForm.goodsAmount" ></el-input>
                        </el-form-item>
                        <el-form-item label="入库时间" :label-width="formLabelWidth">
							<el-date-picker
							      v-model="mesForm.time"
							      type="date"
							      placeholder="生产日期">
							    </el-date-picker>
                            
                        </el-form-item>
                    </el-form>
                    <div slot="footer" class="dialog-footer">
                        <el-button @click="dialogFormVisible = false">取消</el-button>
                        <el-button type="primary" @click=saveMes(index)>确定</el-button>
                    </div>
                </el-dialog>
            </div>
			
            <!--分页效果-->
            <!--page-size:每页显示条目个数,默认值10；
            pager-count:页码按钮的数量，当总页数超过该值时会折叠
            page-count:总页数，total 和 page-count 设置任意一个就可以达到显示页码的功能；-->
			<div style="text-align: right;margin-top:1.25rem ;">
			    <el-pagination
			            @current-change="handleCurrentChange"
			            :current-page.sync="currentPage1"
			            :page-size="10"
			            layout="total, prev, pager, next"
			            :total="totalsize">
			    </el-pagination>
			</div>
           
        </div>
        <!--入库详情-->
        <div :class="[isShow==1?'mainActive':'main']" id="show2">
            <div id="add">
                <el-form :label-position="labelPosition" label-width="80px" :model="stockMes">
                    <el-form-item label="商品名称" required>
                        <el-input v-model="stockMes.name"></el-input>
                    </el-form-item>
                   <el-form-item label="生产日期" required>
                        <el-date-picker
                              v-model="stockMes.time"
                              type="date"
                              placeholder="生产日期">
                            </el-date-picker>
                    </el-form-item>
					
                    <el-form-item label="入库时间" required>
						<el-date-picker
						      v-model="stockMes.stockInTime"
						      type="date"
						      placeholder="入库时间">
						    </el-date-picker>
                       
                    </el-form-item>
                    <el-form-item label="数量" required>
                        <el-input v-model="stockMes.count"></el-input>
                    </el-form-item>
                    <el-form-item>
                        <el-button type="primary" @click="onSubmit" style="float: right">入库</el-button>
                    </el-form-item>
                </el-form>
            </div>
        </div>
		
		</el-card>
    </div>
</template>
<script>
    import http from "../util/http.js";
    import form from "../util/http.js"
    import {search} from "../util/api";
    export default {
        name: 'StockIn',
        data() {
            return {
                index:'',
                totalsize:100,  //数据的总条数
                currentPage :1,
                currentPage1:1,//当前的页数
                searchMes: '',  //搜索输入框的值
                isShow: 0,  //是否显示
                labelPosition: 'right',
                stockMes: {  //商品入库绑定的数据
                    id:'',
                    name: '',
                    time: '',
                    stockInTime: '',
                    count:''
                },
                dialogFormVisible: false,
                mesForm: {  //编辑弹框信息
                    name: '',
                    // delivery: false,
                    goodsName: '',
                    goodsAmount:'',
                    time:''
                },
                formLabelWidth: '120px',
                input: '',
                tableData: [ //渲染数据的信息
               ]
            }
        },
        mounted() {
            this.init();
        },
        methods: {
            init(){
                //初始化请求接口，请求数据
                // var formData = new FormData();
                // formData.append('page',2);
                http({
                    method:'post',
                    url:'/checkin',
                    params: {
                        page:1
                    },
                }).then((res)=>{
                    /*console.log(res);*/
                    if (res.status === 200){
                        // console.log(res.data);
                        this.tableData = res.data.data.stock;
                        this.totalsize = res.data.data.count;  //总数据条数
                        //this.size = this.totalsize/this.pageSize;   //有多少页
                       /* console.log(this.currentPage1);
                        console.log(this.totalsize)*/
                    }
                }).catch(err=>{
                    console.log(err)
                })
            },
            handleCurrentChange(val) {
                console.log(val);
                if(this.searchMes == ''){
                    this.currentPage = val;
                    http({
                        method:'post',
                        url:'/checkin',
                        params:{
                            page:this.currentPage
                        }
                    }).then((res)=>{
                        console.log(res.data);
                        if (res.status === 200){
                            this.tableData = res.data.data.stock;
                            this.totalsize = res.data.data.count;
                        }
                    })
                }else{
                        this.currentPage1 = val;
                        this.search(this.searchMes)

                }

            },
            click(mes){
                if(this.currentPage>1){
                    this.currentPage1 = 1;
                    this.currentPage = 1;
                    this.search(this.searchMes)
                }else{
                    this.search(this.searchMes)
                }
            },
            handleDelete(val){
/*                console.log(val);*/

                http({
                    method:"post",
                    url:'/checkinDelete',
                    params:{
                        id: this.tableData[val.$index].id
                    }
                }).then((res)=>{
					console.log(this.tableData[val.$index].id);
                    console.log(res);
                    this.tableData.splice(val.$index,1);  //删除点击的那一行
                    http({
                        method:'post',
                        url:'/checkin',
                        params: {
                            page:1
                        },
                    }).then((res)=>{
                        console.log(res);
                        if (res.status === 200){
                            console.log(res.data);
                            this.tableData = res.data.data.stock;
                            this.totalsize = res.data.data.count;  //总数据条数
                            //this.size = this.totalsize/this.pageSize;   //有多少页
                            console.log(this.currentPage1);
                            console.log(this.totalsize)
                        }
                    })
                    this.$message({
                        type: 'success',
                        message: '删除成功!'
                    });
                }).catch(()=>{
                    console.log("删除失败");
                })
            },
            onSubmit() {
                /*alert('入库成功');
                //location.href = 'all/stockAll';
                //this.$router.push("stockIn");
                document.getElementById('show1').className = 'mainActive';
                document.getElementById('show2').className = 'main';*/
                http({
                    method:'post',
                    url:'/checkinAdd',
                    data:JSON.stringify({
                        goodsName: this.stockMes.name,
                        num:this.stockMes.count,
                        productTime:this.stockMes.time,
                        checkinTime:this.stockMes.stockInTime
                    })
                }).then((res)=>{
                    if(this.stockMes.name==''||this.stockMes.count==''||this.stockMes.time==''||this.stockMes.stockInTime==''){
                        this.$message({
                            type: 'info',
                            message: '信息不完整!'
                        });
                    }else if (res.data.code === 100){
                        this.$message({
                            type: 'info',
                            message: res.data.msg
                        });
                    }
                    else {
                        this.$message({
                            type: 'success',
                            message: '添加成功!'
                        });
                        this.stockMes.name = ''
                        this.stockMes.count = ''
                        this.stockMes.time = ''
                        this.stockMes.stockInTime = ''
                        document.getElementById('show1').className = 'mainActive';
                        this.isShow = 0
                        document.getElementById('show2').className = 'main';
                        console.log(res);
                    }
                }).catch(()=>{
                    this.$message({
                        type: 'info',
                        message: '添加失败!'
                    });
                })
            },
            change(n) {
                this.isShow = n;
            },
            mesEdit(val){   //编辑信息弹框    //传id给后台，然后再获取数据，再显示
                this.dialogFormVisible = true;

                this.mesForm.goodsName = this.tableData[val.$index].goods_name;
                this.mesForm.goodsAmount = this.tableData[val.$index].amount;
                this.mesForm.name = this.tableData[val.$index].name;
                this.mesForm.time = this.tableData[val.$index].time;
                this.index = val;

                /*console.log(this.tableData[val.$index]);*/
            },
            //保存编辑后的信息
            saveMes(index){
                this.dialogFormVisible = false;
                /*this.mesForm = {};*/
                http({
                    method:'post',
                    url:'/checkinEdit',
                    data:JSON.stringify({
                        amount:this.tableData[index.$index].amount,
                        id:this.tableData[index.$index].id,
                        goodsId:this.tableData[index.$index].goods_id,
                        goodsName:this.mesForm.goodsName,
                        num:this.mesForm.goodsAmount,
                        checkinTime:this.mesForm.time
                    })
                }).then((res)=>{
                    console.log(this.tableData[index.$index].amount)
                    if(JSON.parse(res.data.code) === 200){
                        this.$message({
                            type: 'info',
                            message: "更新成功"
                        });
                        console.log(this.mesForm.goodsName)
                        this.init()
                    }else{
                        this.$message({
                            type: 'info',
                            message: res.data.msg
                        });
                    }

                }).catch(()=>{
                    console.log("失败")
                    console.log(this.tableData[index.$index].id)
                    console.log(this.mesForm.goodsName)
                    console.log(this.mesForm.goodsAmount)
                    console.log(this.mesForm.time)
                })
            },
            search(mes){
                console.log(mes);

                http({
                    method:'post',
                    url:'/checkinSearch',
                    params:{
                        goodsName:mes,
                        page:this.currentPage1
                    }
                }).then((res)=>{
                    if (res.status === 200){
                        console.log(res.data.data.mapList)
                        this.tableData = res.data.data.mapList;
                        this.totalsize = res.data.data.count;  //总数据条数
                        /*this.size = this.totalsize/this.pageSize;*/

                    }
                })
            }
        }
    }
</script>
<style scoped>
    .header {
        display: inline-block;
        margin-bottom: 10px;
    }


    .mainActive {
        display: block;
    }

    .main {
        display: none;
        position: relative;
    }

    .block {
        position: absolute;
        left: 940px;
        margin-top: 20px;
    }
</style>
