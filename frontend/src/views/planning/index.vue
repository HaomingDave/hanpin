<template>
  <div v-loading="loading" class="app-container">
      <el-row class="img-wrapper">
        <el-col v-for="item in fileList" :xs="24" :sm="24" :md="12" :lg="6" class="box">
          <img src="@/assets/excel.png" alt="" width="60px" style="margin-top: 10px">
          <div>{{ item.createtime }}</div>
          <el-button size="small">
            <a :href="'http://view.xdocin.com/xdoc?_xdoc=' + assetsUrl + item.zjjh">
              预览
            </a>
          </el-button>
          <el-button size="small">
            <a :href="assetsUrl + item.zjjh">
              下载
            </a>
          </el-button>
        </el-col>
      </el-row>
      <el-row class="">
        <el-col :xs="24" :sm="24" :md="12" :lg="6" class="box" style="border: 0px">
          <el-upload
            class="upload-demo"
            :action="assetsUrl + '/QPpNbWlorZ.php/ajax/upload'"
            with-credentials
            :on-preview="handlePreview"
            :limit="1"
            :on-exceed="handleExceed"
            :on-remove="handleRemove"
            :on-success="handleSuccess"
          >
            <el-button size="small" type="primary">选择文件</el-button>
            <!-- <div slot="tip" class="el-upload__tip">只能上传jpg/png文件，且不超过500kb</div> -->
          </el-upload>
          <el-button size="small" type="success" :disabled="!file" class="upload-but" @click="uploadZcxm">上传计划安排</el-button>
        </el-col>
      </el-row>
    <div class="foot">
      <el-pagination
        background
        style="text-align:left;"
        layout="prev, pager, next"
        :total="total"
        :page-size="pageSize"
        :current-page.sync="currentPage"
        @current-change="handleCurrentChange"
      />
    </div>

  </div>
</template>

<script>
import { getFileList, uploadProjectRecord } from '@/api/table'
export default {
  data() {
    return {
      assetsUrl: process.env.VUE_APP_ASSETS_URL,
      total: 0,
      pageSize: 3,
      currentPage: 0,
      file: null,
      loading: false,
      row: {
        pid_text: '',
        pid: '',
        report: '',
        zcxm: '',
        zjjh: '',
        xmjdb: '',
        sgjdkz: '',
        images: '',
        remark: '',
        order: ''
      }
    }
  },
  created() {
    this.getFileList()
  },
  methods: {
    getFileList(currentPage) {
      this.loading = true
      getFileList({
        type: 2,
        id: this.$route.query.projectId,
        limit: this.pageSize,
        offset: currentPage ? (currentPage - 1) * this.pageSize : 0
      }).then(res => {
        this.fileList = res.data.rows
        this.total = res.data.total
        this.loading = false
      })
    },
    handleCurrentChange(currentPage) {
      this.getFileList(currentPage)
    },
    handleExceed(files, fileList) {
      this.$message.warning(`当前限制选择 1 个文件，本次选择了 ${files.length} 个文件，共选择了 ${files.length + fileList.length} 个文件`)
    },
    handleRemove(file, fileList) {
      this.file = null
    },
    handleSuccess(res, file, fileList) {
      this.file = res.data.url
    },
    uploadZcxm() {
      this.loading = true
      this.row.zjjh = this.file
      this.row.pid = this.$route.query.projectId
      uploadProjectRecord({}, this.row).then(res => {
        window.location.reload()
      })
    }
  }
}
</script>

<style lang="scss" scoped>
  .app-container {
    height: calc(100vh - 50px);
    transform: scale3d(1, 1, 1);
    overflow-y: scroll;
    .img-wrapper {
      overflow: hidden;
      text-align: center;
    }
    .box {
      border: 1px solid #999999;
      border-radius: 5px;
      margin-right: 20px;
      margin-bottom: 20px;
      position: relative;
      .el-button--small {
        margin-top: 10px;
        margin-bottom: 10px;
      }
      .upload-demo{
        float: left;
      }
    }
    .upload-but{
      position: absolute;
      left: 100px;
      top: 0;
    }
    .foot {
      bottom: 20px;
    }
  }
</style>

