<template>
  <div class="app-container">
    <span style="margin-bottom: 20px">材料条目:</span>
    <el-button v-if="applicationStatus == '未提交' && userInfo.role.indexOf('6') !== -1 && userInfo.id === originalManager" type="primary" size="mini" style="float: right" @click="add">添加条目</el-button>
    <el-table :key="tableKey" v-loading="loading" :data="list" border fit highlight-current-row>
      <!-- <el-table-column label="类别" width="150px" align="center">
        <template slot-scope="{row}">
          <span>{{ row.applicant }}</span>
        </template>
      </el-table-column> -->
      <el-table-column label="编号" width="50px" align="center">
        <template slot-scope="{row}">
          <span>{{ row.id }}</span>
        </template>
      </el-table-column>
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
      <el-table-column label="添加日期" width="160px" align="center">
        <template slot-scope="{row}">
          <span>{{ row.createtime_text }}</span>
        </template>
      </el-table-column>
      <el-table-column label="材料名称" width="160px" align="center">
        <template slot-scope="{row}">
          <span>{{ row.mp_cl_name }}</span>
        </template>
      </el-table-column>
      <el-table-column label="材料规格" min-width="150px" align="center">
        <template slot-scope="{row}">
          <span>{{ row.mp_cl_specifications }}</span>
        </template>
      </el-table-column>
      <el-table-column label="材料单价" width="150px" align="center">
        <template slot-scope="{row}">
          <span>{{ row.mp_unit }}</span>
        </template>
      </el-table-column>
      <el-table-column label="材料品牌" width="150px" align="center">
        <template slot-scope="{row}">
          <span>{{ row.mp_cl_brand }}</span>
        </template>
      </el-table-column>
      <el-table-column label="材料型号" width="150px" align="center">
        <template slot-scope="{row}">
          <span>{{ row.mp_cl_model }}</span>
        </template>
      </el-table-column>
      <el-table-column label="预算数量" align="center" width="150">
        <template slot-scope="{row}">
          <span>{{ row.mp_budget_quantity }}</span>
        </template>
      </el-table-column>
      <el-table-column label="已购数量" class-name="status-col" width="150" align="center">
        <template slot-scope="{row}">
          <span>{{ row.mp_purchased_quantity }}</span>
        </template>
      </el-table-column>
      <el-table-column label="申请数量" class-name="status-col" width="150" align="center">
        <template slot-scope="{row}">
          <span>{{ row.mp_sq_quantity }}</span>
        </template>
      </el-table-column>
      <el-table-column label="材料合计价" class-name="status-col" width="150" align="center">
        <template slot-scope="{row}">
          <span>{{ row.mp_total }}</span>
        </template>
      </el-table-column>
      <el-table-column v-if="applicationStatus == '未提交' && userInfo.role.indexOf('6') !== -1 && userInfo.id === originalManager" label="操作" align="center" width="230" fixed="right" class-name="small-padding fixed-width">
        <template slot-scope="{row, $index}">
          <el-button type="primary" size="mini" @click="handleUpdate(row)">
            编辑
          </el-button>
          <el-button type="danger" size="mini" @click="handleDelete(row)">
            删除
          </el-button>
        </template>
      </el-table-column>
    </el-table>
    <div style="margin-bottom: 15px;">申请状态：{{ applicationStatus }}</div>
    <div class="remark-wrapper">
      <div class="remark-title">
        审核意见：
      </div>
      <div class="remark">
        {{ auditRemark }}
      </div>
    </div>
    <div class="remark-wrapper">
      <div class="remark-title">
        复核意见：
      </div>
      <div class="remark">
        {{ reauditRemark }}
      </div>
    </div>
    <div class="foot">
      <el-button v-if="canSubmit && applicationStatus == '未提交' && userInfo.id === originalManager" type="primary" size="mini" :loading="addLoading" @click="submit">提交申请</el-button>
      <el-button v-if="canAudit && applicationStatus != '复核已通过' && applicationStatus != '复核未通过'" type="primary" size="mini" :loading="addLoading" @click="audit">审核</el-button>
      <el-button v-if="canReaudit && applicationStatus == '审核通过'" type="primary" size="mini" :loading="addLoading" @click="reaudit">复核</el-button>
      <el-button size="mini" @click="cancel">返回</el-button>
    </div>
    <concentDialog ref="concentDialog" :visible.sync="submitVisible" :form.sync="form" :purchase-item-change-type="purchaseItemChangeType" :item-id="purchaseItemId" :title="title"
      v-on:success="success"/>
    <auditDialog ref="auditDialog" :visible.sync="auditVisible" title="审核" />
    <reauditDialog ref="reauditDialog" :visible.sync="reauditVisible" title="复核" />
  </div>
</template>

<script>
import concentDialog from './concentDialog.vue'
import auditDialog from './auditDialog.vue'
import reauditDialog from './reauditDialog.vue'
import { getPurchaseItemList, deletePurchaseItem, getApproval, editApproval, getUserInfo, getProjectInfo } from '@/api/table'
import { mapGetters, mapMutations } from 'vuex'

export default {
  components: {
    concentDialog,
    auditDialog,
    reauditDialog
  },
  data() {
    return {
      tableKey: 0,
      loading: false,
      addLoading: false,
      list: [],
      submitVisible: false,
      auditVisible: false,
      reauditVisible: false,
      title: '新增购买条目',
      purchaseItemChangeType: '',
      purchaseItemId: '',
      applicationStatus: '',
      auditRemark: '',
      reauditRemark: '',
      form: {
        mp_ghs_name: '',
        mp_ghs_tel: '',
        mp_cl_name: '',
        mp_cl_specifications: '',
        mp_unit: '',
        mp_cl_brand: '',
        mp_cl_model: '',
        mp_budget_quantity: 0,
        mp_purchased_quantity: 0,
        mp_sq_quantity: 0,
        mp_total: 0
      },
      editApprovalForm: {
        audit: 2
      },
      canAudit: false,
      canSubmit: false,
      canReaudit: false,
      canDoubleCheck: false,
      originalManager: ''
    }
  },
  computed: {
    ...mapGetters([
      'userInfo'
    ])
  },
  created() {
    this.fetchData()
    console.log(this.userInfo)
    this.authorizeRole()
  },
  methods: {
    ...mapMutations('user', ['SET_USERINFO']),
    authorizeRole() {
      if (this.userInfo) {
        if (this.userInfo.username === 'shenhe001') {
          this.canAudit = true
          this.canSubmit = false
          this.canReaudit = false
        } else if (this.userInfo.role.indexOf('6') !== -1) {
          this.canAudit = false
          this.canSubmit = true
          this.canReaudit = false
        } else if (this.userInfo.role.indexOf('8') !== -1) {
          this.canAudit = false
          this.canSubmit = false
          this.canReaudit = true
        }
      } else {
        getUserInfo({}).then(res => {
          this.userInfo = res.data.userInfo
          this.SET_USERINFO(this.userInfo)
          if (this.userInfo.username === 'shenhe001') {
            this.canAudit = true
            this.canSubmit = false
            this.canReaudit = false
          } else if (this.userInfo.role.indexOf('6') !== -1) {
            this.canAudit = false
            this.canSubmit = true
            this.canReaudit = false
          } else if (this.userInfo.role.indexOf('8') !== -1) {
            this.canAudit = false
            this.canSubmit = false
            this.canReaudit = true
          }
        })
      }
    },
    fetchData() {
      this.loading = true
      getPurchaseItemList({}, this.$route.query.applicationId).then(res => {
        this.list = res.data.rows
        this.loading = false
      })
      getApproval({}, this.$route.query.applicationId).then(res => {
        this.applicationStatus = res.data.audit
        this.auditRemark = res.data.audit_remark
        this.reauditRemark = res.data.reaudit_remark
        if (this.applicationStatus == 1) {
          this.applicationStatus = '审核通过'
        } else if (this.applicationStatus == 2) {
          this.applicationStatus = '待审核'
        } else if (this.applicationStatus == 3) {
          this.applicationStatus = '审核未通过'
        } else if (this.applicationStatus == 4) {
          this.applicationStatus = '复核已通过'
        } else if (this.applicationStatus == 5) {
          this.applicationStatus = '复核未通过'
        } else if (this.applicationStatus == 6) {
          this.applicationStatus = '未提交'
        }
      })
      getProjectInfo({}, this.$route.query.projectId).then(response => {
        this.originalManager = response.data.manager
      })
    },
    add() {
      this.submitVisible = true
      this.purchaseItemChangeType = 'add'
    },
    handleUpdate(row) {
      this.purchaseItemChangeType = 'update'
      this.purchaseItemId = row.id
      this.submitVisible = true
      for (const key in this.form) {
        this.form[key] = row[key]
      }
    },
    handleDelete(row) {
      this.loading = true
      deletePurchaseItem({}, row.id).then(res => {
        this.loading = false
        this.fetchData()
      })
    },
    submit() {
      this.addLoading = true
      editApproval({}, this.editApprovalForm, this.$route.query.applicationId).then(res => {
        console.log(res)
        this.addLoading = false
        window.location.reload()
      })
    },
    audit() {
      this.auditVisible = true
    },
    reaudit() {
      this.reauditVisible = true
    },
    cancel() {
      this.clean()
      this.$router.go(-1)
    },
    clean() {
      this.list = []
    },
    success() {
      this.fetchData();
      this.form = {
          mp_ghs_name: '',
          mp_ghs_tel: '',
          mp_cl_name: '',
          mp_cl_specifications: '',
          mp_unit: '',
          mp_cl_brand: '',
          mp_cl_model: '',
          mp_budget_quantity: 0,
          mp_purchased_quantity: 0,
          mp_sq_quantity: 0,
          mp_total: 0
      };
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
  .remark {
    display: inline-block;
    width: 300px;
    word-wrap: break-word;
  }
  .remark-wrapper {
    position: relative;
    margin-bottom: 15px;
  }
  .remark-title {
    display: inline;
    float: left;
  }
</style>
