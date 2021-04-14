<template>
  <div class="app-container">
    <span style="margin-bottom: 20px">材料待付款表:</span>
    <div class="total">
      <span style="margin-right: 15px;">总已付款：{{ totalPaid }}</span>
      <span>总待付款：{{ totalToPay }}</span>
    </div>
    <el-table :key="tableKey" v-loading="loading" :data="list" empty-text="暂无数据" border fit highlight-current-row>
      <el-table-column label="供货商" width="150px" align="center">
        <template slot-scope="{row}">
          <span>{{ row.mp_ghs_name }}</span>
        </template>
      </el-table-column>
      <el-table-column label="供货商电话" width="150px" align="center">
        <template slot-scope="{row}">
          <span>{{ row.mp_ghs_tel }}</span>
        </template>
      </el-table-column>
      <el-table-column label="申请单编号" width="100px" align="center">
        <template slot-scope="{row}">
          <span>{{ row.id }}</span>
        </template>
      </el-table-column>
      <el-table-column label="申请时间" min-width="160px" align="center">
        <template slot-scope="{row}">
          <span>{{ row.applicant_time_text }}</span>
        </template>
      </el-table-column>
      <el-table-column label="材料合计价" class-name="status-col" width="150" align="center">
        <template slot-scope="{row}">
          <span>{{ row.mp_all_money }}</span>
        </template>
      </el-table-column>
      <el-table-column label="已付款" class-name="status-col" fixed="right" width="100" align="center">
        <template slot-scope="{row}">
          <span>{{ row.mp_paid }}</span>
        </template>
      </el-table-column>
      <el-table-column label="待付款" class-name="status-col" fixed="right" width="100" align="center">
        <template slot-scope="{row}">
          <span>{{ row.mp_to_pay }}</span>
        </template>
      </el-table-column>
      <el-table-column label="操作" align="center" width="120px" fixed="right" class-name="small-padding fixed-width">
        <template slot-scope="{row, $index}">
          <el-button v-if="row.mp_to_pay > 0" type="danger" size="mini" @click="recordPayment(row)">
            打款记录
          </el-button>
          <el-button v-else type="success" size="mini" @click="recordPayment(row)">
            打款记录
          </el-button>
        </template>
      </el-table-column>
    </el-table>
    <el-pagination
      background
      layout="prev, pager, next"
      :total="total"
      :page-size="pageSize"
      style="margin-top:10px;"
      @current-change="handleCurrentChange"
    />
    <el-dialog :title="title" :visible="visible" width="500px" class="recordPayment" @close="cancel">
      <el-form v-loading="dialogLoading" ref="form" :model="form" :rules="rules" label-width="100px" class="demo-form">
        <el-form-item label="第一期" prop="ghs_name">
          <el-input v-if="form.price1 == '0.00' || form.price1 == ''" v-model="form1.price1" size="mini" style="width: 50%;" />
          <span v-else> {{ form.price1 }} </span>
          <span style="margin-left: 5px;">元</span>
          <div>打款时间: {{ payTime.time1 }}</div>
        </el-form-item>
        <el-form-item label="第二期" prop="ghs_name">
          <el-input v-if="form.price2 == '0.00' || form.price2 == ''" v-model="form1.price2" size="mini" style="width: 50%;" />
          <span v-else> {{ form.price2 }} </span>
          <span style="margin-left: 5px;">元</span>
          <div>打款时间: {{ payTime.time2 }}</div>
        </el-form-item>
        <el-form-item label="第三期" prop="ghs_name">
          <el-input v-if="form.price3 == '0.00' || form.price3 == ''" v-model="form1.price3" size="mini" style="width: 50%;" />
          <span v-else> {{ form.price3 }} </span>
          <span style="margin-left: 5px;">元</span>
          <div>打款时间: {{ payTime.time3 }}</div>
        </el-form-item>
        <el-form-item label="第四期" prop="ghs_name">
          <el-input v-if="form.price4 == '0.00' || form.price4 == ''" v-model="form1.price4" size="mini" style="width: 50%;" />
          <span v-else> {{ form.price4 }} </span>
          <span style="margin-left: 5px;">元</span>
          <div>打款时间: {{ payTime.time4 }}</div>
        </el-form-item>
        <el-form-item label="第五期" prop="ghs_name">
          <el-input v-if="form.price5 == '0.00' || form.price5 == ''" v-model="form1.price5" size="mini" style="width: 50%;" />
          <span v-else> {{ form.price5 }} </span>
          <span style="margin-left: 5px;">元</span>
          <div>打款时间: {{ payTime.time5 }}</div>
        </el-form-item>
      </el-form>
      <span slot="footer" class="dialog-footer">
        <el-button size="mini" @click="cancel">取 消</el-button>
        <el-button type="primary" :loading="addLoading" size="mini" @click="submit">确 定</el-button>
      </span>
    </el-dialog>
  </div>
</template>

<script>
import { getToPayList, getPaymentInfo, editPaymentInfo } from '@/api/table'
import { mapGetters, mapMutations } from 'vuex'

export default {
  components: {
  },
  data() {
    return {
      tableKey: 0,
      loading: false,
      dialogLoading: false,
      addLoading: false,
      list: [],
      form: {
        price1: '0.00',
        price2: '0.00',
        price3: '0.00',
        price4: '0.00',
        price5: '0.00'
      },
      form1: {
        price1: '',
        price2: '',
        price3: '',
        price4: '',
        price5: ''
      },
      payTime: {
        time1: '',
        time2: '',
        time3: '',
        time4: '',
        time5: ''
      },
      total: 0,
      pageSize: 10,
      visible: false,
      editRowId: '',
      totalToPay: '',
      totalPaid: ''

    }
  },
  computed: {
    ...mapGetters([
      'userInfo'
    ])
  },
  watch: {
    userInfo() {
      console.log(this.userInfo, 11111)
      this.fetchData()
    }
  },
  created() {
    this.fetchData()
  },
  methods: {
    ...mapMutations('user', ['SET_USERINFO']),
    fetchData(currentPage) {
      this.loading = true
      getToPayList({
        pid: this.$route.query.projectId,
        limit: this.pageSize,
        offset: currentPage ? (currentPage - 1) * this.pageSize : 0,
        username: this.userInfo.username
      }).then(res => {
        this.list = res.data.rows
        this.total = res.data.total
        this.loading = false
        this.totalToPay = res.data.all_wait_pay
        this.totalPaid = res.data.all_paid
      })
    },
    handleCurrentChange(currentPage) {
      this.fetchData(currentPage)
    },
    resetPaymentInfo() {
      this.form.price1 = '0.00'
      this.form.price2 = '0.00'
      this.form.price3 = '0.00'
      this.form.price4 = '0.00'
      this.form.price5 = '0.00'
      this.payTime.time1 = ''
      this.payTime.time2 = ''
      this.payTime.time3 = ''
      this.payTime.time4 = ''
      this.payTime.time5 = ''
      this.form1.price1 = ''
      this.form1.price2 = ''
      this.form1.price3 = ''
      this.form1.price4 = ''
      this.form1.price5 = ''
    },
    recordPayment(row) {
      this.resetPaymentInfo()
      this.visible = true
      this.dialogLoading = true
      this.editRowId = row.id
      getPaymentInfo({
        maid: row.id,
        username: this.userInfo.username
      }).then(res => {
        this.dialogLoading = false
        console.log(res)
        if (!(res.data.data instanceof Array)) {
          for (let key in this.form) {
            this.form[key] = res.data.data[key]
            if (res.data.data[key] !== '0.00') {
              this.form1[key] = res.data.data[key]
            }
          }
          for (let key in this.payTime) {
            this.payTime[key] = res.data.data[key]
          }
        }
      })
    },
    submit() {
      this.addLoading = true
      this.form1.pid = this.$route.query.projectId
      this.form1.maid = this.editRowId
      editPaymentInfo({
        pid: this.$route.query.projectId,
        maid: this.editRowId,
        username: this.userInfo.username
      }, this.form1).then(res => {
        this.addLoading = false
        this.visible = false
        this.$message({
          message: res.data.msg,
          type: 'success'
        })
        this.fetchData()
      })
    },
    cancel() {
      this.visible = false
    }
  }
}
</script>

<style scoped>
  .el-table {
    width: max-content;
    margin-top: 20px;
    margin-bottom: 20px;
  }
  .foot {
    position: fixed;
    bottom: 20px;
  }
  .total {
    margin-top: 10px;
    font-size: 14px;
    color: #606266;
  }
</style>
