<template>
  <div v-loading="loading" class="app-container">
    <el-form ref="form" :model="form" label-width="120px">
      <el-form-item label="施工图，效果图">
        <el-select v-model="row.sgtxgt" placeholder="请选择">
          <el-option
            v-for="item in options"
            :key="item.value"
            :label="item.value"
            :value="item.value"
          />
        </el-select>
        <el-input
          v-model="row.check_remark1"
          class="note"
          type="textarea"
          :rows="3"
          placeholder="请输入内容"
        />
      </el-form-item>
      <el-form-item label="施工进度表">
        <el-select v-model="row.sgjdb" placeholder="请选择">
          <el-option
            v-for="item in options"
            :key="item.value"
            :label="item.value"
            :value="item.value"
          />
        </el-select>
        <el-input
          v-model="row.check_remark2"
          class="note"
          type="textarea"
          :rows="3"
          placeholder="请输入内容"
        />
      </el-form-item>
      <el-form-item label="施工组织计划">
        <el-select v-model="row.sgzcwd" placeholder="请选择">
          <el-option
            v-for="item in options"
            :key="item.value"
            :label="item.value"
            :value="item.value"
          />
        </el-select>
        <el-input
          v-model="row.check_remark3"
          class="note"
          type="textarea"
          :rows="3"
          placeholder="请输入内容"
        />
      </el-form-item>
      <el-form-item label="相对应施工工艺文档">
        <el-select v-model="row.gywd" placeholder="请选择">
          <el-option
            v-for="item in options"
            :key="item.value"
            :label="item.value"
            :value="item.value"
          />
        </el-select>
        <el-input
          v-model="row.check_remark4"
          class="note"
          type="textarea"
          :rows="3"
          placeholder="请输入内容"
        />
      </el-form-item>
      <el-form-item label="熟悉本项目的预算范围及工程量">
        <el-select v-model="row.sxgcl" placeholder="请选择">
          <el-option
            v-for="item in options"
            :key="item.value"
            :label="item.value"
            :value="item.value"
          />
        </el-select>
        <el-input
          v-model="row.check_remark5"
          class="note"
          type="textarea"
          :rows="3"
          placeholder="请输入内容"
        />
      </el-form-item>
      <el-form-item label="材料小样准备">
        <el-select v-model="row.clxyzb" placeholder="请选择">
          <el-option
            v-for="item in options"
            :key="item.value"
            :label="item.value"
            :value="item.value"
          />
        </el-select>
        <el-input
          v-model="row.check_remark6"
          class="note"
          type="textarea"
          :rows="3"
          placeholder="请输入内容"
        />
      </el-form-item>
      <el-form-item label="下包方合同、及下包的预算范围及工程量">
        <el-select v-model="row.ysfwhgcl" placeholder="请选择">
          <el-option
            v-for="item in options"
            :key="item.value"
            :label="item.value"
            :value="item.value"
          />
        </el-select>
        <el-input
          v-model="row.check_remark7"
          class="note"
          type="textarea"
          :rows="3"
          placeholder="请输入内容"
        />
      </el-form-item>
      <el-form-item label="下包方安全、消防协议、安全文明宣导签章">
        <el-select v-model="row.wmsdqz" placeholder="请选择">
          <el-option
            v-for="item in options"
            :key="item.value"
            :label="item.value"
            :value="item.value"
          />
        </el-select>
        <el-input
          v-model="row.check_remark8"
          class="note"
          type="textarea"
          :rows="3"
          placeholder="请输入内容"
        />
      </el-form-item>

      <el-form-item>
        <el-button type="primary" @click="onSubmit">提交</el-button>
        <el-button @click="onCancel">取消</el-button>
      </el-form-item>
    </el-form>
  </div>
</template>

<script>
import { getPreContructNotice, addPreContructNotice, editPreContructNotice } from '@/api/table'
export default {
  data() {
    return {
      row: {
        pid: this.$route.query.projectId,
        sgtxgt: '否',
        check_remark1: '',
        sgjdb: '否',
        check_remark2: '',
        sgzcwd: '否',
        check_remark3: '',
        gywd: '否',
        check_remark4: '',
        sxgcl: '否',
        check_remark5: '',
        clxyzb: '否',
        check_remark6: '',
        ysfwhgcl: '否',
        check_remark7: '',
        wmsdqz: '否',
        check_remark8: ''
      },
      options: [{
        value: '是'
      },
      {
        value: '否'
      }],
      loading: false,
      sixRulesList: [],
      sixRulesId: ''
    }
  },
  created() {
    this.fetchData()
  },
  methods: {
    onSubmit() {
      if (this.sixRulesList.length === 0) {
        this.loading = true
        addPreContructNotice({}, this.row).then(res => {
          if (res.data.msg === '暂无权限') {
            this.$message({
              message: res.data.msg,
              type: 'success'
            })
          } else {
            this.$message({
              message: '操作成功',
              type: 'success'
            })
          }

          this.fetchData()
        })
      } else {
        this.loading = true
        editPreContructNotice({}, this.sixRulesId, this.row).then(res => {
          if (res.data.msg === '暂无权限') {
            this.$message({
              message: res.data.msg,
              type: 'success'
            })
          } else {
            this.$message({
              message: '操作成功',
              type: 'success'
            })
          }
          this.fetchData()
        })
      }
    },
    onCancel() {
      this.$message({
        message: 'cancel!',
        type: 'warning'
      })
    },
    fetchData() {
      this.loading = true
      getPreContructNotice({ pid: this.$route.query.projectId }).then(res => {
        console.log(res.data.rows)
        this.sixRulesList = res.data.rows
        if (this.sixRulesList.length > 0) {
          // eslint-disable-next-line prefer-const
          for (let key in this.row) {
            this.row[key] = this.sixRulesList[0][key]
          }
          this.row.pid = this.$route.query.projectId
          this.sixRulesId = this.sixRulesList[0].id
        }
        this.loading = false
      })
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
  .note {
    width: 500px;
    display: block;
    margin-top: 10px;
  }
</style>

