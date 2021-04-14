<template>
  <div :class="{'has-logo':showLogo}">
    <logo v-if="showLogo" :collapse="isCollapse" />
    <div class="projectName">{{ $route.query.projectName }}</div>
    <el-scrollbar wrap-class="scrollbar-wrapper">
      <el-menu
        :default-active="activeMenu"
        :collapse="isCollapse"
        :background-color="variables.menuBg"
        :text-color="variables.menuText"
        :unique-opened="false"
        :active-text-color="variables.menuActiveText"
        :collapse-transition="false"
        :select="refreshMenu"
        mode="vertical"
      >
        <sidebar-item v-for="route in routes" :key="route.path" :item="route" :base-path="route.path" @click.native="refreshMenu" />
      </el-menu>
    </el-scrollbar>
  </div>
</template>

<script>
import { mapGetters } from 'vuex'
import Logo from './Logo'
import SidebarItem from './SidebarItem'
import variables from '@/styles/variables.scss'
import { getUserInfo, doseHaveNewMsg } from '@/api/table'

export default {
  components: { SidebarItem, Logo },
  data() {
    return {
      routes: []
    }
  },
  computed: {
    ...mapGetters([
      'sidebar',
      'currentProject',
      'name',
      'userInfo'
    ]),
    /* eslint-disable */
    routes1() {
      if (this.userInfo) {
        this.$router.options.routes.filter(v => {
          if (v.children && v.children[0].meta.role) {
            v.hidden = !(v.children[0].meta.role.indexOf(this.userInfo.username) !== -1)
          }
        })
        this.showMenuItem()
        return this.$router.options.routes
      } else {
        getUserInfo({}).then(res => {
          this.$store.commit('user/SET_USERINFO', res.data.userInfo)
          this.userInfo = res.data.userInfo
          this.$router.options.routes.filter(v => {
            if (v.children && v.children[0].meta.role) {
              v.hidden = !(v.children[0].meta.role.indexOf(this.userInfo.username) !== -1)
            }
          })
          
          this.showMenuItem()
          return this.$router.options.routes
        })
        
      }
    },
    /* eslint-enable */
    activeMenu() {
      const route = this.$route
      const { meta, path } = route
      // if set path, the sidebar will highlight the path you set
      if (meta.activeMenu) {
        return meta.activeMenu
      }
      return path
    },
    showLogo() {
      return this.$store.state.settings.sidebarLogo
    },
    variables() {
      // console.log(variables)
      return variables
    },
    isCollapse() {
      return !this.sidebar.opened
    }
  },
  created() {
    this.loadData()
  },
  methods: {
    showMenuItem() {
      doseHaveNewMsg({
        pid: this.$route.query.projectId,
        username: this.userInfo.username
      }).then(res => {
        console.log('new', res)
        this.$router.options.routes = this.$router.options.routes.filter(v => {
          if (v.children && v.children[0].meta) {
            switch (v.children[0].meta.title) {
              case '图片记录':
                v.children[0].meta.new = res.data.data.hasNewPics
                break
              case '每日自查项目':
                v.children[0].meta.new = res.data.data.hasNewZcxm
                break
              case '计划安排':
                v.children[0].meta.new = res.data.data.hasNewZjjh
                break
              case '施工节点控制记录':
                v.children[0].meta.new = res.data.data.hasNewSgjdkz
                break
              case '采购申请':
                v.children[0].meta.new = res.data.data.hasNewUnAudit
                break
            }
          }
          return v
        })
        this.routes = this.$router.options.routes
      })
    },
    loadData() {
      if (this.userInfo) {
        this.$router.options.routes.filter(v => {
          if (v.children && v.children[0].meta.role) {
            for (let i = 0; i < this.userInfo.role.length; i++) {
              if (v.children[0].meta.role.indexOf(this.userInfo.role[i]) !== -1) {
                v.hidden = false
              } else {
                v.hidden = true
              }
            }
          }
        })
        this.showMenuItem()
      } else {
        getUserInfo({}).then(res => {
          this.$store.commit('user/SET_USERINFO', res.data.userInfo)
          this.userInfo = res.data.userInfo
          this.$router.options.routes.filter(v => {
            if (v.children && v.children[0].meta.role) {
              for (let i = 0; i < this.userInfo.role.length; i++) {
                if (v.children[0].meta.role.indexOf(this.userInfo.role[i]) !== -1) {
                  v.hidden = false
                } else {
                  v.hidden = true
                }
              }
            }
          })
          this.showMenuItem()
        })
      }
    },
    refreshMenu() {
      this.loadData()
    }
  }
}
</script>
<style lang="scss" scoped>
  .projectName {
    font-size: 22px;
    color: #fff;
    padding-left: 20px;
    padding-top: 10px;
    padding-bottom: 10px;
    font-weight: 800;
  }
</style>
