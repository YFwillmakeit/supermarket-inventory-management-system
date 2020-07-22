图片懒加载原理（前端做懒加载，img的src）
代理的原理
判断链表有环吗
登录后端存储什么



<template>
  <div>
    <div id="main_left" style="width: 400px;height:410px;float: left;"></div>
    <div id="main_right" style="width: 400px;height:410px;float: right;margin-right: 100px;"></div>
    <div>
      <el-table
              :data="tableData"
              stripe
              style="width: 100%;line-height: 78px">
        <el-table-column
                prop="goodsName"
                label="商品名"
                width="180">
        </el-table-column>
        <el-table-column
                prop="typeName"
                label="商品类型"
                width="180">
        </el-table-column>
        <el-table-column
                prop="amount"
                label="商品数量"
                width="180">
        </el-table-column>
        <el-table-column
                prop="outInType"
                label="出入库"
                width="180">
          <template slot="header" slot-scope="scope">
            <el-dropdown @command="handleCommand" trigger="click">
                        <span class="el-dropdown-link">
                            {{inOutType}}<i class="el-icon-arrow-down el-icon--right"></i>
                        </span>
              <el-dropdown-menu slot="dropdown">
                <el-dropdown-item command="a">出库</el-dropdown-item>
                <el-dropdown-item command="b">入库</el-dropdown-item>
                <el-dropdown-item command="c">出入库</el-dropdown-item>
              </el-dropdown-menu>
            </el-dropdown>
          </template>
        </el-table-column>
        <el-table-column
                prop="OperateTime"
                label="日期"
                width="180">
          <template slot="header" slot-scope="scope">
            <el-dropdown @command="handleCommand" trigger="click">
                        <span class="el-dropdown-link">
                            {{inOutDate}}<i class="el-icon-arrow-down el-icon--right"></i>
                        </span>
              <el-dropdown-menu slot="dropdown">
                <el-dropdown-item command="d">近一日</el-dropdown-item>
                <el-dropdown-item command="e">近一周</el-dropdown-item>
                <el-dropdown-item command="f">近一月</el-dropdown-item>
              </el-dropdown-menu>
            </el-dropdown>
          </template>
        </el-table-column>
        <el-table-column
                prop="username"
                label="操作者"
                width="180">
        </el-table-column>
      </el-table>
      <div class="block" style="margin-left: 500px;margin-top: 20px;">
        <span class="demonstration"> </span>
        <el-pagination
                @current-change="handleCurrentChange"
                :current-page="currentPage"
                :page-size="pageSize"
                layout="total, prev, pager, next, jumper"
                :total="total">
        </el-pagination>
      </div>
    </div>
  </div>

</template>

<script>
  import http from '../util/http'
  export default {
    name: "ExcelTotal",
    data() {
      return {
        tableData: [],
        tempData: [],
        currentPage: 1, // 当前页
        pageSize: 4, // 每页多少条
        total: 0, // 总条数
        inOutType: '出入库', // 出入库类型下拉菜单
        inOutDate: '日期', // 出入库日期下拉菜单
        start: 1, // 后端接口----当前页
        typeCode: 0, // 后端接口----出入库类型
        dateCode: 0, // 后端接口----出入库日期
        leftSeriesData: [], // 保存左方echarts下面series里的data数据
        rightSeriesData: [], // 保存右方echarts下面series里的data数据
        leftLegendData: [], // 保存左方echarts下面legend里的data数据
        rightLegendData: [], // 保存右方echarts下面legend里的data数据
      }
    },
    computed:{
      out: function () {
        return this.tempData.filter((item)=>item.outInType === 0)
      },
      in: function () {
        return this.tempData.filter((item)=>item.outInType === 1)
      }
    },
    mounted: function () {
      // 初始显示表格数据
      http({
        url: `/statistics/check/list?start=${this.start}&dateCode=${this.dateCode}&typeCode=${this.typeCode}`
      }).then(response =>{
        let res = response.data.data;
        this.total = res.total;
        this.tableData = res.list;
        this.tempData = res.list;
      });
      // echarts请求后端数据
      http({
        url: `/statistics/check`
      }).then(response =>{
        let res = response.data.data;
        for (let i in res) {
          this.leftSeriesData.push({value:res[i],name: i==='checkin'?'一周的总入库数量':'一周的总出库数量'});
          this.leftLegendData.push(i==='checkin'?'一周的总入库数量':'一周的总出库数量');
        }
        // echarts调用函数
        this.drawChartLeft();
      });

      http({
        url: `/statistics/stock`
      }).then(response =>{
        let res = response.data.data;
        for (let i in res) {
          this.rightSeriesData.push({value:res[i].goodsAmount,name: res[i].typeName});
          this.rightLegendData.push(res[i].typeName);
        }
        // echarts调用函数
        this.drawChartRight();
      });


    },
    methods: {
      // 分页操作
      handleCurrentChange(val) {// val代表当前页
        this.start = val;
        this.currentPage = val;
        http({
          url: `/statistics/check/list?start=${this.start}&dateCode=${this.dateCode}&typeCode=${this.typeCode}`
        }).then(response =>{
          let res = response.data.data;
          this.total = res.total;
          this.tableData = res.list;
          this.tempData = res.list;
        })
      },
      // 下拉菜单选择
      handleCommand(command) {
        // 出入库类型的下拉菜单
        if (command === 'a') {
          this.inOutType = '出库';
          this.typeCode = 2;
          this.currentPage = 1;
          this.start = 1;
          http({
            url: `/statistics/check/list?start=${this.start}&dateCode=${this.dateCode}&typeCode=${this.typeCode}`
          }).then(response =>{
            let res = response.data.data;
            this.total = res.total;
            this.tableData = res.list;
            this.tempData = res.list;
          });
          return
        }
        if (command === 'b') {
          this.inOutType = '入库';
          this.typeCode = 1;
          this.currentPage = 1;
          this.start = 1;
          http({
            url: `/statistics/check/list?start=${this.start}&dateCode=${this.dateCode}&typeCode=${this.typeCode}`
          }).then(response =>{
            let res = response.data.data;
            this.total = res.total;
            this.tableData = res.list;
            this.tempData = res.list;
          })
          return
        }
        if (command === 'c') {
          this.inOutType = '出入库';
          this.typeCode = 0;
          this.currentPage = 1;
          this.start = 1;
          http({
            url: `/statistics/check/list?start=${this.start}&dateCode=${this.dateCode}&typeCode=${this.typeCode}`
          }).then(response =>{
            let res = response.data.data;
            this.total = res.total;
            this.tableData = res.list;
            this.tempData = res.list;
          })
          return
        }
        // 出入库日期的下拉菜单
        if (command === 'd') {
          this.inOutDate = '近一日';
          this.dateCode = 1;
          this.currentPage = 1;
          this.start = 1;
          http({
            url: `/statistics/check/list?start=${this.start}&dateCode=${this.dateCode}&typeCode=${this.typeCode}`
          }).then(response =>{
            let res = response.data.data;
            this.total = res.total;
            this.tableData = res.list;
            this.tempData = res.list;
          })
          return
        }
        if (command === 'e') {
          this.inOutDate = '近一周';
          this.dateCode = 2;
          this.currentPage = 1;
          this.start = 1;
          http({
            url: `/statistics/check/list?start=${this.start}&dateCode=${this.dateCode}&typeCode=${this.typeCode}`
          }).then(response =>{
            let res = response.data.data;
            this.total = res.total;
            this.tableData = res.list;
            this.tempData = res.list;
          })
          return
        }
        if (command === 'f') {
          this.inOutDate = '近一月';
          this.dateCode = 3;
          this.currentPage = 1;
          this.start = 1;
          http({
            url: `/statistics/check/list?start=${this.start}&dateCode=${this.dateCode}&typeCode=${this.typeCode}`
          }).then(response =>{
            let res = response.data.data;
            this.total = res.total;
            this.tableData = res.list;
            this.tempData = res.list;
          })
          return
        }

      },

      // echarts饼状图
      drawChartLeft () {
        // 基于准备好的dom，初始化echarts实例
        let myChartLeft = this.$echarts.init(document.getElementById("main_left"));

        // 指定图表的配置项和数据
        let option = {
          tooltip: {
            trigger: 'item',
            formatter: '{a} <br/>{b}: {c} ({d}%)'
          },
          legend: {
            orient: 'vertical',
            left: 10,
            data: this.leftLegendData
          },
          series: [
            {
              name: '一周的总出/入库的数量',
              type: 'pie',
              radius: ['60%', '80%'],
              avoidLabelOverlap: false,
              label: {
                show: false,
                position: 'center'
              },
              emphasis: {
                label: {
                  show: true,
                  fontSize: '30',
                  fontWeight: 'bold'
                }
              },
              labelLine: {
                show: false
              },
              data: this.leftSeriesData
            }
          ]
        };
        // 使用刚指定的配置项和数据显示图表。
        myChartLeft.setOption(option);
      },
      drawChartRight () {
        // 基于准备好的dom，初始化echarts实例
        let myChartRight = this.$echarts.init(document.getElementById("main_right"));

        // 指定图表的配置项和数据
        let option = {
          tooltip: {
            trigger: 'item',
            formatter: '{a} <br/>{b}: {c} ({d}%)'
          },
          legend: {
            orient: 'vertical',
            left: 10,
            data: this.rightLegendData
          },
          series: [
            {
              name: '商品类型',
              type: 'pie',
              radius: ['50%', '70%'],
              avoidLabelOverlap: false,
              label: {
                show: false,
                position: 'center'
              },
              emphasis: {
                label: {
                  show: true,
                  fontSize: '30',
                  fontWeight: 'bold'
                }
              },
              labelLine: {
                show: false
              },
              data: this.rightSeriesData
            }
          ]
        };
        // 使用刚指定的配置项和数据显示图表。
        myChartRight.setOption(option);
      }
    }
  }
</script>

<style scoped>
  .el-dropdown-link {
    cursor: pointer;
    color: #909399;
  }
  .el-icon-arrow-down {
    font-size: 12px;
  }

</style>   



















