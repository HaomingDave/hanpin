<template>
  <el-dialog :title="title" :visible="visible" width="600px" @close="close">
    <el-form ref="form" :model="form" :rules="rules" label-width="100px" class="demo-form">
      <el-form-item label="复核结果" prop="ghs_name">
        <el-select v-model="auditOptionValue" placeholder="请选择">
          <el-option
            v-for="item in auditOptions"
            :key="item.value"
            :label="item.label"
            :value="item.value"
          />
        </el-select>
      </el-form-item>
      <el-form-item label="复核结果" prop="ghs_name">
        <el-input
          v-model="auditMark"
          type="textarea"
          :rows="3"
          placeholder="请输入复核意见"
        />
      </el-form-item>
    </el-form>
    <span slot="footer" class="dialog-footer">
      <el-button size="mini" @click="cancel">取 消</el-button>
      <el-button type="primary" :loading="loading" size="mini" @click="submit">确 定</el-button>
    </span>
  </el-dialog>
</template>

<script>
import { auditApproval } from '@/api/table'
export default {
  props: {
    visible: {
      type: Boolean,
      default: false
    },
    title: {
      type: String,
      default: ''
    },
    itemId: {
      type: String,
      default: ''
    }
  },
  data() {
    return {
      loading: false,
      submitData: {},
      rules: {

      },
      auditOptions: [{
        label: '通过',
        value: 4
      }, {
        label: '不通过',
        value: 5
      }],
      auditOptionValue: 4,
      auditMark: ''
    }
  },
  methods: {
    submit() {
      this.loading = true
      this.submitData = {
        row: {
          audit: this.auditOptionValue,
          reaudit_remark: this.auditMark
        },
        id: this.$route.query.applicationId
      }
      auditApproval(
        { id: this.$route.query.applicationId,
          type: 2
        }, this.submitData).then(res => {
        this.loading = false
        window.location.reload()
      })
    },
    cancel() {
      this.loading = false
      this.$emit('update:visible', false)
    },
    close() {
      this.$emit('update:visible', false)
    }
  }
}
</script>

<style scoped>
  .demo-form {
    max-height: 500px;
  }
  /deep/ .el-input__inner {
    width: 400px;
  }
</style>
