<template>
  <div v-loading="loading" class="app-container">
    <div style="margin-bottom: 20px">采购申请表:</div>
    <el-button v-if="userInfo.role.indexOf('6') !== -1 && userInfo.id === originalManager" type="primary" size="mini" @click="addPurchaseApproval" :loading="addLoading" style="margin-bottom: 20px">添加采购申请单</el-button>
    <el-table :key="tableKey" :data="list" border fit highlight-current-row>
      <el-table-column label="ID" prop="id" sortable="custom" align="center" width="80">
        <template slot-scope="{row}">
          <span>{{ row.id }}</span>
        </template>
      </el-table-column>
      <el-table-column label="申请人" width="150px" align="center">
        <template slot-scope="{row}">
          <span>{{ row.applicant }}</span>
        </template>
      </el-table-column>
      <el-table-column label="申请时间" width="150px" align="center">
        <template slot-scope="{row}">
          <span>{{ row.applicant_time }}</span>
        </template>
      </el-table-column>
      <el-table-column label="状态" width="150px" align="center">
        <template slot-scope="{row}">
          <span>{{ row.audit }}</span>
        </template>
      </el-table-column>
      <el-table-column label="审核时间" width="160px" align="center">
        <template slot-scope="{row}">
          <span>{{ row.audit_time_text }}</span>
        </template>
      </el-table-column>
      <el-table-column label="复核时间" width="160px" align="center">
        <template slot-scope="{row}">
          <span>{{ row.reaudit_time_text }}</span>
        </template>
      </el-table-column>
      <el-table-column label="操作" align="center" width="230" class-name="small-padding fixed-width">
        <template slot-scope="{row, $index}">
          <el-button type="primary" size="mini" @click="edit(row.id)">
            进入
          </el-button>
          <el-button
            v-if="((row.audit=='待审核' || row.audit=='未提交') && userInfo.role.indexOf('6') !== -1 && userInfo.id === originalManager)"
            type="danger"
            size="mini"
            @click="deleteApproval(row.id)">
            删除
          </el-button>
        </template>
      </el-table-column>
    </el-table>
    <el-pagination background layout="prev, pager, next" :total="total" :page-size="pageSize" @current-change="handleCurrentChange"
                    style="margin-top:10px;">
    </el-pagination>
  </div>
</template>

<script>
import { getMaterialApprovalList, addMaterialApproval, deleteApproval, getProjectInfo } from '@/api/table'
import { mapGetters } from 'vuex'
const pageSize = 10
export default {
  data() {
    return {
      tableKey: 0,
      loading: false,
      addLoading: false,
      list: [],
      total: 0,
      pageSize: pageSize,
      approvalSubmitData: {
        name: 'default',
        pid: this.$route.query.projectId,
        numer: '001',
        order: 0,
        status: 'normal'
      },
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
  },
  methods: {
    edit(id) {
      this.addLoading = true
      this.$router.push({
        path: '/project/purchaseDetail',
        query: {
          projectName: this.$route.query.projectName,
          projectId: this.$route.query.projectId,
          applicationId: id
        }
      })
    },
    handleUpdate(row) {

    },
    handleDelete(row) {

    },
    addPurchaseApproval() {
      this.loading = true
      addMaterialApproval({}, this.approvalSubmitData).then(res => {
        this.loading = false
        this.$message({
          message: '添加成功',
          type: 'success',
          duration: 2000,
          onClose: () => {
            window.location.reload()
          }
        })
      })
    },
    deleteApproval(id) {
      this.loading = true
      deleteApproval({}, id).then(res => {
        this.loading = false
        this.$message({
          message: '删除成功',
          type: 'success',
          duration: 2000,
          onClose: () => {
            window.location.reload()
          }
        })
      })
    },
    onCancel() {
      this.$message({
        message: 'cancel!',
        type: 'warning'
      })
    },
    fetchData(currentPage) {
      this.loading = true
      getMaterialApprovalList({
        pid: this.$route.query.projectId,
        limit: pageSize,
        offset: currentPage ? (currentPage - 1) * pageSize : 0
      }).then(response => {
        console.log(response)
        this.list = response.data.rows
        this.total = response.data.total
        this.loading = false
      })
      getProjectInfo({}, this.$route.query.projectId).then(response => {
        this.originalManager = response.data.manager
      })
    },
    handleCurrentChange(currentPage) {
      console.log(currentPage)
      this.fetchData(currentPage)
    }
  }
}
</script>

<style scoped>
 .el-table {
  width: max-content;
}
</style>

