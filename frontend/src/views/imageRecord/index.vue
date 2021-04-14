<template>
  <div v-loading="loading" class="app-container">
    <div v-for="item in imgList" class="img-wrapper">
      <div class="imgDate">{{ item.date }}</div>
      <el-col v-for="item1 in item.imgs" :xs="12" :sm="12" :lg="6" class="singImg">
        <img :src="assetsUrl + item1" alt="" width="120px" @click="showBigImg(item1)" />
      </el-col>
    </div>
    <el-pagination background layout="prev, pager, next" :total="total" :page-size="5" @current-change="handleCurrentChange"
                    style="margin-top:10px;">
    </el-pagination>
    <br>
    <hr class="hr">
    <div class="img">
      <el-upload
        :action="assetsUrl + '/QPpNbWlorZ.php/ajax/upload'"
        list-type="picture-card"
        with-credentials
        :on-success="getFileList"
        :on-preview="handlePictureCardPreview"
        :on-remove="handleRemove"
      >
        <i class="el-icon-plus" />
      </el-upload>
      <el-dialog :visible.sync="dialogVisible">
        <img width="100%" :src="dialogImageUrl" alt="">
      </el-dialog>
      <div style="margin-top:10px;">
        <el-button @click="uploadImgRecord">上传项目图片</el-button>
      </div>
    </div>
  </div>
</template>

<script>
import { uploadProjectRecord, getImgList } from '@/api/table'

export default {
  data() {
    return {
      assetsUrl: process.env.VUE_APP_ASSETS_URL,
      dialogImageUrl: '',
      dialogVisible: false,
      upLoadlist: [],
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
      },
      loading: false,
      imgList: [],
      total: 0
    }
  },
  created() {
    this.getImgList()
  },
  methods: {
    getImgList(currentPage) {
      this.loading = true
      getImgList({
        id: this.$route.query.projectId,
        offset: currentPage ? (currentPage - 1) * 5 : 0
      }).then(res => {
        console.log(res)
        this.imgList = res.data.rows
        this.loading = false
        this.total = res.data.total
      })
    },
    handleCurrentChange(currentPage) {
      this.getImgList(currentPage)
    },
    handleRemove(file, fileList) {
      console.log(file, fileList)
    },
    handlePictureCardPreview(file) {
      this.dialogImageUrl = file.url
      this.dialogVisible = true
    },
    getFileList(response, file, fileList) {
      this.upLoadlist = fileList
    },
    uploadImgRecord() {
      if (this.upLoadlist.length > 0) {
        this.loading = true
        this.row.pid = this.$route.query.projectId
        let imagesStr = ''
        for (let a = 0; a < this.upLoadlist.length; a++) {
          if (a === 0) {
            imagesStr = this.upLoadlist[a].response.data.url
          } else {
            imagesStr = imagesStr + ',' + this.upLoadlist[a].response.data.url
          }
        }
        this.row.images = imagesStr
        uploadProjectRecord({}, this.row).then(res => {
          // window.location.reload()
        })
      } else {
        this.$alert('需要先上传图片才可以提交')
      }
    },
    showBigImg(url) {
      window.location.href = process.env.VUE_APP_ASSETS_URL + url
    }
  }
}
</script>

<style lang="scss" scoped>
.img-wrapper {
  overflow: hidden;
  margin-bottom: 10px;
}
.imgDate {
  margin-bottom: 10px;
}
.singImg {
  margin-bottom: 10px;
}
.hr {
  opacity: 0.3;
}
</style>

