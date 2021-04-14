<template>
  <div class="dashboard-container">
    <div class="dashboard-text">项目列表:</div>
    <panel-group />
  </div>
</template>

<script>
import { mapGetters } from 'vuex'
import PanelGroup from '@/views/projectList/PanelGroup'

export default {
  name: 'Dashboard',
  components: {
    PanelGroup
  },
  data() {
    return {
    }
  },

  computed: {
    ...mapGetters([
      'name'
    ])
  },
  created() {
  },
  methods: {
  }

}
</script>

<style lang="scss" scoped>
.dashboard {
  &-container {
    margin: 30px;
  }
  &-text {
    font-size: 30px;
    line-height: 46px;
  }
}
</style>
