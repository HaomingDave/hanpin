<template>
  <el-dialog :title="title" :visible="visible" width="600px" @close="close">
    <el-form ref="form" :model="form" :rules="rules" label-width="100px" class="demo-form">
      <el-form-item label="供货商" prop="ghs_name">
        <!-- <el-input v-model="form.mp_ghs_name" size="mini" /> -->
        <el-autocomplete v-model="form.mp_ghs_name" class="inline-input" :fetch-suggestions="querySearch"
          placeholder="请输入内容" @select="handleSelect" size="mini"/>
      </el-form-item>
      <el-form-item label="供货商电话" prop="ghs_tel">
        <!--<el-input v-model="form.mp_ghs_tel" size="mini" />-->
        <el-autocomplete v-model="form.mp_ghs_tel" class="inline-input" :fetch-suggestions="queryGhsTel"
                         placeholder="请输入内容" @select="handleSelect" size="mini"/>
      </el-form-item>
      <el-form-item label="材料名称" prop="mp_cl_name">
        <!--<el-input v-model="form.mp_cl_name" size="mini" />-->
        <el-autocomplete v-model="form.mp_cl_name" class="inline-input" :fetch-suggestions="queryClName"
                         placeholder="请输入内容" @select="handleSelect" size="mini"/>
      </el-form-item>
      <el-form-item label="材料规格" prop="mp_cl_specifications">
        <!--<el-input v-model="form.mp_cl_specifications" size="mini" />-->
        <el-autocomplete v-model="form.mp_cl_specifications" class="inline-input" :fetch-suggestions="queryClSpeci"
                         placeholder="请输入内容" @select="handleSelect" size="mini"/>
      </el-form-item>
      <el-form-item label="材料单价" prop="materialPrice">
        <el-input v-model="form.mp_unit" size="mini" @change="caculateTotal" />
      </el-form-item>
      <el-form-item label="材料品牌" prop="region">
        <el-input v-model="form.mp_cl_brand" size="mini" />
      </el-form-item>
      <el-form-item label="材料型号" prop="region">
        <el-input v-model="form.mp_cl_model" size="mini" />
      </el-form-item>
      <el-form-item label="预算数量" prop="region">
        <el-input v-model="form.mp_budget_quantity" size="mini" />
      </el-form-item>
      <el-form-item label="已购数量" prop="region">
        <el-input v-model="form.mp_purchased_quantity" size="mini" />
      </el-form-item>
      <el-form-item label="申请数量" prop="region">
        <el-input v-model="form.mp_sq_quantity" size="mini" @change="caculateTotal" />
      </el-form-item>
      <el-form-item label="材料合计价" prop="region">
        <el-input v-model="form.mp_total" size="mini" />
      </el-form-item>
    </el-form>
    <span slot="footer" class="dialog-footer">
      <el-button size="mini" @click="cancel">取 消</el-button>
      <el-button type="primary" :loading="loading" size="mini" @click="submit">确 定</el-button>
    </span>
  </el-dialog>
</template>

<script>
import qs from 'qs'
import { addPurchaseItem, editPurchaseItem } from '@/api/table'
import { mapGetters, mapMutations } from 'vuex'
export default {
  props: {
    visible: {
      type: Boolean,
      default: false
    },
    form: {
      type: Object,
      default: () => {}
    },
    title: {
      type: String,
      default: ''
    },
    purchaseItemChangeType: {
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
      tableKey: 0,
      loading: false,
      submitData: {},
      rules: {

      }
    }
  },
  computed: {
    ...mapGetters(['mpGhsName', 'mpGhsTel', 'mpClName', 'mpClSpecifications'])
  },
  methods: {
    ...mapMutations('user', ['SET_MPGHSNAME', 'SET_MPGHSTEL', 'SET_MPCLNAME', 'SET_MPCLSPECIFICACTIONS']),
    submit() {
      this.loading = true;
      if (this.purchaseItemChangeType === 'add') {
        this.submitData = qs.stringify({ row: this.form, ma_id: this.$route.query.applicationId })
        addPurchaseItem({ mid: this.$route.query.applicationId }, this.submitData).then(res => {
          this.clear();
        })
      } else if (this.purchaseItemChangeType === 'update') {
        this.submitData = qs.stringify({ row: this.form, ma_id: this.$route.query.applicationId })
        editPurchaseItem({}, this.submitData, this.itemId).then(res => {
          // console.log(111, res)
          this.clear();
        })
      }
    },
    clear() {
      let ghsNmae = {value: this.form.mp_ghs_name};
      let ghsTel = {value: this.form.mp_ghs_tel};
      let clName = {value: this.form.mp_cl_name};
      let clSpe = {value: this.form.mp_cl_specifications};
      this.loading = false;
      this.SET_MPGHSNAME(ghsNmae);
      this.SET_MPGHSTEL(ghsTel);
      this.SET_MPCLNAME(clName);
      this.SET_MPCLSPECIFICACTIONS(clSpe);
      this.$emit("success");
      this.$emit('update:visible', false);
    },
    cancel() {
      this.loading = false;
      this.$emit('update:visible', false)
    },
    close() {
      this.$emit('update:visible', false)
    },
    querySearch(queryString, cb) {
      cb(this.mpGhsName)
    },
    queryGhsTel(queryString, cb) {
      cb(this.mpGhsTel)
    },
    queryClName(queryString, cb) {
      cb(this.mpClName)
    },
    queryClSpeci(queryString, cb) {
      cb(this.mpClSpecifications)
    },
    caculateTotal() {
      this.form.mp_total = (this.form.mp_sq_quantity * this.form.mp_unit).toFixed(2)
    }
  }
}
</script>

<style scoped>
  .demo-form {
    max-height: 500px;
    overflow-y: scroll;
  }
  /deep/ .el-input__inner {
    width: 400px;
  }
</style>
