<template>
  <div v-loading="loading" class="app-container">
    <el-form ref="form" :model="row" :rules="rules" label-width="120px">
      <el-form-item label="项目名" prop="name">
        <el-input v-model="row.name" size="small" />
      </el-form-item>
      <el-form-item label="项目经理">
        <el-select v-model="row.manager" placeholder="请选择" :disabled="userInfo && userInfo.username !== 'shenhe001'">
          <el-option v-for="item in managerList" :key="item.user_id" :label="item.nickname" :value="item.user_id" />
        </el-select>
      </el-form-item>
      <el-form-item label="开始时间">
        <!--<el-input v-model="row.start_time" />-->
        <el-date-picker v-model="row.start_time" type="datetime" placeholder="选择日期时间" style="width:100%" size="small" />
      </el-form-item>
      <el-form-item label="项目缩略图">
        <el-upload
          class="avatar-uploader"
          :action="assetsUrl + '/QPpNbWlorZ.php/ajax/upload'"
          :show-file-list="false"
          with-credentials
          :on-success="handleAvatarSuccess"
          :before-upload="beforeAvatarUpload"
          size="small"
        >
          <img v-if="imageUrl" :src="assetsUrl + imageUrl" class="avatar">
          <i v-else class="el-icon-plus avatar-uploader-icon" />
        </el-upload>
      </el-form-item>
      <el-form-item label="工期">
        <el-input v-model="row.gong_qi" size="small" />
      </el-form-item>
      <el-form-item label="是否超期">
        <el-radio v-model="row.is_overdue" label="1">是</el-radio>
        <el-radio v-model="row.is_overdue" label="0">否</el-radio>
      </el-form-item>
      <el-form-item label="项目备注信息">
        <el-input v-model="row.introduction" type="textarea" rows="5" size="small" />
      </el-form-item>

      <el-form-item>
        <el-button v-if="userInfo && (userInfo.username === 'shenhe001' || userInfo.id === originalManager) " type="primary" size="small" @click="onSubmit">修改</el-button>
        <el-button v-if="userInfo && userInfo.username === 'shenhe001'" type="danger" style="float:right;" size="small" @click="onCancel">删除该项目</el-button>
      </el-form-item>
    </el-form>
  </div>
</template>

<script>
import { getProjectInfo, editProjectInfo, deleteProject, getManagerList } from '@/api/table'
import { mapGetters } from 'vuex'
export default {
  data() {
    return {
      assetsUrl: process.env.VUE_APP_ASSETS_URL,
      row: {
        name: '',
        mobile: '',
        start_time: '',
        end_time: '',
        gong_qi: '',
        image: '',
        progress: '',
        introduction: '',
        order: '',
        status: '',
        is_overdue: '0',
        manager: '',
        currentUser: ''
      },
      rules: {
        name: [
          { required: true, message: '请输入项目名称', trigger: 'blur' }
        ]
      },
      loading: false,
      projectInfo: {},
      projectInfoOriginal: {},
      imageUrl: null,
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
    onSubmit() {
      this.row.currentUser = this.userInfo.id
      this.$refs['form'].validate((valid) => {
        if (valid) {
          this.loading = true
          this.row.image = this.imageUrl
          editProjectInfo({}, this.row, this.$route.query.projectId).then(res => {
            console.log(res)
            this.loading = false
            this.$message({
              message: '提交成功',
              type: 'success'
            })
            this.$router.push('/')
          })
        } else {
          return false
        }
      })
    },
    onCancel() {
      this.$confirm('此操作将删除该项目, 是否继续?', '提示', {
        confirmButtonText: '确定',
        cancelButtonText: '取消',
        type: 'warning'
      }).then(() => {
        this.$message({
          type: 'success',
          message: '删除成功!'
        })
        this.loading = true
        deleteProject({}, this.$route.query.projectId).then(res => {
          console.log('success')
          this.$router.push('/')
        })
      }).catch(() => {
        this.$message({
          type: 'info',
          message: '已取消删除'
        })
      })
    },
    fetchData() {
      this.loading = true
      getManagerList({}).then(res => {
        this.managerList = res.data.rows

        getProjectInfo({}, this.$route.query.projectId).then(response => {
          // console.log(response)
          this.projectInfo = response.data
          this.projectInfoOriginal = response.data
          this.imageUrl = response.data.image
          this.row.manager = response.data.manager
          this.originalManager = response.data.manager
          this.loading = false
          for (const key in this.row) {
            this.row[key] = this.projectInfo[key]
          }
          this.row.start_time = this.projectInfo.start_time_text
          this.row.end_time = this.projectInfo.end_time_text
          this.row.is_overdue = String(this.projectInfo.is_overdue)
        })
      })
    },
    handleAvatarSuccess(res, file) {
      this.imageUrl = res.data.url
    },
    beforeAvatarUpload() {

    }
  }
}
</script>

<style>
  .line{
    text-align: center;
  }
  .avatar-uploader .el-upload {
    border: 1px dashed #d9d9d9;
    border-radius: 6px;
    cursor: pointer;
    position: relative;
    overflow: hidden;
  }
  .avatar-uploader .el-upload:hover {
    border-color: #409EFF;
  }
  .avatar-uploader-icon {
    font-size: 28px;
    color: #8c939d;
    width: 178px;
    height: 178px;
    line-height: 178px;
    text-align: center;
  }
  .avatar {
    width: 178px;
    height: 178px;
    display: block;
  }
</style>

