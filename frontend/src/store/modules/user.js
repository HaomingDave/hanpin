import { login, logout, getInfo } from '@/api/user'
import { getToken, setToken, removeToken } from '@/utils/auth'
import { resetRouter } from '@/router'

const getDefaultState = () => {
  return {
    token: getToken(),
    name: '',
    avatar: '',
    userInfo: null,
    mpGhsName: [],
    mpGhsTel: [],
    mpClName: [],
    mpClSpecifications: []
  }
}

const state = getDefaultState()

const mutations = {
  RESET_STATE: (state) => {
    Object.assign(state, getDefaultState())
  },
  SET_TOKEN: (state, token) => {
    state.token = token
  },
  SET_NAME: (state, name) => {
    state.name = name
  },
  SET_AVATAR: (state, avatar) => {
    state.avatar = avatar
  },
  SET_USERINFO: (state, userInfo) => {
    state.userInfo = userInfo
  },
  SET_MPGHSNAME: (state, mpGhsName) => {
    if(state.mpGhsName.length == 0){
      state.mpGhsName.push(mpGhsName);
    } else {
      let values = [];
      for (let i = 0; i < state.mpGhsName.length; i ++) {
        values.push(state.mpGhsName[i].value);
      }
      if (values.includes(mpGhsName.value)) {
        return false;
      } else {
        if(state.mpGhsName.length < 5 ){
          state.mpGhsName.push(mpGhsName);
        }else {
          state.mpGhsName.splice(0, 1);
          state.mpGhsName.push(mpGhsName);
        }
      }
    }
  },
  SET_MPGHSTEL: (state, mpGhsTel) => {
    if(state.mpGhsTel.length == 0){
      state.mpGhsTel.push(mpGhsTel);
    } else {
      let values = [];
      for (let i = 0; i < state.mpGhsTel.length; i ++) {
        values.push(state.mpGhsTel[i].value);
      }
      if (values.includes(mpGhsTel.value)) {
        return false;
      } else {
        if(state.mpGhsTel.length < 5 ){
          state.mpGhsTel.push(mpGhsTel);
        }else {
          state.mpGhsTel.splice(0, 1);
          state.mpGhsTel.push(mpGhsTel);
        }
      }
    }
  },
  SET_MPCLNAME: (state, mpClName) => {
    if(state.mpClName.length == 0){
      state.mpClName.push(mpClName);
    } else {
      let values = [];
      for (let i = 0; i < state.mpClName.length; i ++) {
        values.push(state.mpClName[i].value);
      }
      if (values.includes(mpClName.value)) {
        return false;
      } else {
        if(state.mpClName.length < 5 ){
          state.mpClName.push(mpClName);
        }else {
          state.mpClName.splice(0, 1);
          state.mpClName.push(mpClName);
        }
      }
    }
  },
  SET_MPCLSPECIFICACTIONS: (state, mpClSpecifications) => {
    if(state.mpClSpecifications.length == 0){
      state.mpClSpecifications.push(mpClSpecifications);
    } else {
      let values = [];
      for (let i = 0; i < state.mpClSpecifications.length; i ++) {
        values.push(state.mpClSpecifications[i].value);
      }
      if (values.includes(mpClSpecifications.value)) {
        return false;
      } else {
        if(state.mpClSpecifications.length < 5 ){
          state.mpClSpecifications.push(mpClSpecifications);
        }else {
          state.mpClName.splice(0, 1);
          state.mpClSpecifications.push(mpClSpecifications);
        }
      }
    }
  }
}

const actions = {
  // user login
  login({ commit }, userInfo) {
    const { username, password } = userInfo
    return new Promise((resolve, reject) => {
      login({ username: username.trim(), password: password }).then(response => {
        const { data } = response
        commit('SET_TOKEN', data.token)
        setToken(data.token)
        resolve()
      }).catch(error => {
        reject(error)
      })
    })
  },

  // get user info
  getInfo({ commit, state }) {
    return new Promise((resolve, reject) => {
      getInfo(state.token).then(response => {
        const { data } = response

        if (!data) {
          reject('Verification failed, please Login again.')
        }

        const { name, avatar } = data

        commit('SET_NAME', name)
        commit('SET_AVATAR', avatar)
        resolve(data)
      }).catch(error => {
        reject(error)
      })
    })
  },

  // user logout
  logout({ commit, state }) {
    return new Promise((resolve, reject) => {
      logout(state.token).then(() => {
        removeToken() // must remove  token  first
        resetRouter()
        commit('RESET_STATE')
        resolve()
      }).catch(error => {
        reject(error)
      })
    })
  },

  // remove token
  resetToken({ commit }) {
    return new Promise(resolve => {
      removeToken() // must remove  token  first
      commit('RESET_STATE')
      resolve()
    })
  }
}

export default {
  namespaced: true,
  state,
  mutations,
  actions
}

