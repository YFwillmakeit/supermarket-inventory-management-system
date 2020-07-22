<template>

    <div>
		<el-card class="box-card">
        <h1>库存记录</h1>
        <div id="table">
            <el-table
                    :data="tableData"
                    style="width: 100%">
                <el-table-column
                        label="产品编号"
                        prop="id">
                </el-table-column>
                <el-table-column
                        label="产品名称"
                        prop="goodsName">
                </el-table-column>
                <el-table-column
                        label="类型"
                        prop="name">
                </el-table-column>
                <el-table-column
                        label="当前库存数"
                        prop="goodsAmount">
                </el-table-column>
                <el-table-column
                        label="标准数据库"
                        prop="standardAmount">
                </el-table-column>
                <el-table-column>
                    <template slot="header" slot-scope="scope">
                        <el-input
                                v-model="search"
                                style="width: 100px"
                                placeholder="输入产品名称搜索"/>
                        <el-button icon="el-icon-search" circle @click="searchMes(search)"></el-button>
                    </template>
                </el-table-column>
            </el-table>
        </div>
        <div id="block">
            <el-pagination
                    @current-change="handleCurrentChange"
                    :current-page="currentPage"
                    :page-size="10"
                    layout="total,  prev, pager, next, jumper"
                    :total="total">
            </el-pagination>
        </div>
		</el-card>
    </div>

</template>

<script>
    import {
        stockAll
    } from "../util/api.js";
    import http from '../util/http.js'

    export default {
        name: 'StockAll',
        data() {
            return {
                tableData: [],
                search: '',
                currentPage: 1,
                total: 0,
            }
        },
        methods: {
            handleCurrentChange(val) {
                http({
                    method:'post',
                    url:'/stock',
                    params:{
                        page:val
                    }
                }).then((res)=>{
                    console.log(res.data);
                    if (res.status == 200){
                        this.tableData = res.data.data.stock;
                        this.total = res.data.data.count;
                        console.log(this.total)
                    }
                })
            },
            searchMes(mes){
                console.log(mes);
                http({
                    method:'post',
                    url:'/stock/search',
                    params:{
                        goodsName:mes
                    }
                }).then((res)=>{
                    if(res.status==200){
                        console.log(res.data)
                        console.log(res.data.data)
                        this.tableData=res.data.data
                        this.total = 1;
                    }
                })
            }
        },
        mounted() {
            http({
                method: 'post',
                url: '/stock',
                params: {
                    page: 1
                }
            }).then((res) => {
                this.tableData = res.data.data.stock;
                this.total = res.data.data.count;
            })
        }


    }
</script>

<style scoped>
    #table {
        margin-top: 2%;
    }

    #block {
        float: right;
        margin-top: 2%;
    }
</style>
