const getters = {
  sidebar: state => state.app.sidebar,
  device: state => state.app.device,
  token: state => state.user.token,
  avatar: state => state.user.avatar,
  name: state => state.user.name,
  currentProject: state => state.app.currentProject,
  userInfo: state => state.user.userInfo,
  mpGhsName: state => state.user.mpGhsName,
  mpGhsTel: state => state.user.mpGhsTel,
  mpClName: state => state.user.mpClName,
  mpClSpecifications: state => state.user.mpClSpecifications,
}
export default getters
