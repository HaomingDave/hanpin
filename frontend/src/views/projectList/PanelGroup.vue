<template>
  <el-row v-loading="listLoading" :gutter="40" class="panel-group">
    <el-col v-for="item in list" :key="item.id" :xs="12" :sm="12" :lg="6" class="card-panel-col">
      <router-link :to="{ name: userInfo && userInfo.role.indexOf('8') !== -1 ? 'materialPurchase' : 'projectInfo', query: {projectName: item.name, projectId: item.id}}">
        <div class="card-panel" :class="{ overdue: item.isOverdue }" @click="setCurrentProject(item)">
          <div class="card-panel-icon-wrapper icon-people">
            <img v-if="item.image" :src="assetsUrl + item.image" alt="" class="project-img">
            <img v-else src="@/assets/default-projImg.png" alt="" class="project-img">
          </div>
          <div class="card-panel-description">
            <div class="card-panel-text">
              {{ item.name }}
            </div>
            <div class="detail">
              {{ item.start_time_text }}
            </div>
            <div class="detail">
              {{ item.manager }}
            </div>
          </div>
        </div>
      </router-link>
    </el-col>
    <el-col v-if="userInfo && userInfo.username === 'shenhe001'" :xs="12" :sm="12" :lg="6" class="card-panel-col">
      <div class="card-panel flex-center add" @click="showAddModal" @mouseover="over" @mouseleave="leave">
        <img v-if="!hoverAdd" src="@/assets/add2.png" alt="" width="80px">
        <img v-if="hoverAdd" src="@/assets/add1.png" alt="" width="80px">
      </div>
    </el-col>
    <el-dialog title="新增项目" :visible.sync="dialogFormVisible">
      <el-form label-position="top" ref="addForm" :model="form" :rules="rules">
        <el-form-item label="项目名称" :label-width="formLabelWidth" prop="name">
          <el-input v-model="form.name" autocomplete="off" />
        </el-form-item>
        <el-form-item label="项目经理">
          <el-select v-model="selectManager" placeholder="请选择">
            <el-option v-for="item in managerList" :key="item.user_id" :label="item.nickname" :value="item.user_id" />
          </el-select>
        </el-form-item>
      </el-form>
      <div slot="footer" class="dialog-footer">
        <el-button @click="dialogFormVisible = false">取 消</el-button>
        <el-button type="primary" @click="submitAdd">确 定</el-button>
      </div>
    </el-dialog>
  </el-row>

</template>

<script>
import { getList, addProject, getManagerList } from '@/api/table'
import { mapGetters } from 'vuex'

export default {
  components: {
  },
  data() {
    return {
      assetsUrl: process.env.VUE_APP_ASSETS_URL,
      list: null,
      listLoading: false,
      hoverAdd: false,
      dialogFormVisible: false,
      newProjectName: '',
      formLabelWidth: 0,
      managerList: [],
      selectManager: '',
      form: {
        name: ''
      },
      rules: {
        name: [
          { required: true, message: '请输入项目名称', trigger: 'blur' }
        ]
      }
    }
  },
  created() {
    this.fetchData()
  },
  computed: {
    ...mapGetters([
      'userInfo'
    ])
  },
  watch: {
    userInfo: function(val) {
      this.test = 123456
    }
  },
  methods: {
    fetchData() {
      this.listLoading = true
      // getList({})
      getList({}).then(response => {
        // console.log(response)
        this.listLoading = false
        this.list = response.data.rows
        this.list.map((item) => {
          item.isOverdue = item.is_overdue != '0'
        })
      })
      getManagerList({}).then(res => {
        this.managerList = res.data.rows
        this.selectManager = res.data.rows[0].user_id
      })
    },
    setCurrentProject(item) {
      this.$store.commit('app/SET_CURRENT_PROJECT', item.name)
    },
    over() {
      this.hoverAdd = true
    },
    leave() {
      this.hoverAdd = false
    },
    showAddModal() {
      this.dialogFormVisible = true
    },
    submitAdd() {
      this.$refs['addForm'].validate((valid) => {
        if (valid) {
          var data = {
            name: this.form.name,
            manager: this.selectManager,
            mobile: '',
            start_time: '',
            end_time: '',
            gong_qi: '',
            image: '',
            progress: '',
            introduction: '',
            order: '',
            status: 'normal'
          }
          this.loading = true
          addProject({}, data).then(res => {
            this.dialogFormVisible = false
            this.loading = false
            this.$message({
              message: '添加成功',
              type: 'success'
            })
            this.fetchData()
          })
        } else {
          return false
        }
      })
    }
  }
}
</script>

<style lang="scss" scoped>
.panel-group {
  margin-top: 18px;

  .card-panel-col {
    margin-bottom: 32px;
    min-width: 400px;
  }
  .detail {
    margin-bottom: 10px;
  }
  .project-img {
    width: 100px;
    height: 60px;
  }
  .card-panel {
    height: 120px;
    cursor: pointer;
    font-size: 12px;
    position: relative;
    overflow: hidden;
    color: #666;
    background: #fff;
    box-shadow: 4px 4px 40px rgba(0, 0, 0, .05);
    border-color: rgba(0, 0, 0, .05);

    &:hover {
      .card-panel-icon-wrapper {
        color: #fff;
      }

      .icon-people {
        background: #40c9c6;
      }

      .icon-message {
        background: #36a3f7;
      }

      .icon-money {
        background: #f4516c;
      }

      .icon-shopping {
        background: #34bfa3
      }
    }

    .icon-people {
      color: #40c9c6;
    }

    .icon-message {
      color: #36a3f7;
    }

    .icon-money {
      color: #f4516c;
    }

    .icon-shopping {
      color: #34bfa3
    }

    .card-panel-icon-wrapper {
      float: left;
      margin: 14px 0 0 14px;
      padding: 16px;
      transition: all 0.38s ease-out;
      border-radius: 6px;
    }

    .card-panel-icon {
      float: left;
      font-size: 48px;
    }

    .card-panel-description {
      float: right;
      font-weight: bold;
      margin: 26px;
      margin-left: 0px;

      .card-panel-text {
        line-height: 18px;
        color: rgba(0, 0, 0, 0.45);
        font-size: 16px;
        margin-bottom: 12px;
      }

      .card-panel-num {
        font-size: 20px;
      }
    }
  }
}
.flex-center {
  display: flex;
  justify-content: center;
  align-items: center;
}
.overdue {
  background-color: rgba(253, 80, 110, 0.2)!important;
}

@media (max-width:550px) {
  .card-panel-description {
    // display: none;
    margin: 0!important;
    float: initial!important;
    text-align: center;
  }
  .card-panel-col {
    margin-bottom: 32px;
    min-width: initial!important;
  }
  .add {
    min-height: 200px;
  }
  .card-panel {
    height: auto!important;
  }
  .project-img {
    width: 100%!important;
    height: 100px!important;
  }
  .card-panel-icon-wrapper {
    float: none !important;
    margin: 0 !important;

    .svg-icon {
      display: block;
      margin: 14px auto !important;
      float: none !important;
    }
  }
}
</style>
