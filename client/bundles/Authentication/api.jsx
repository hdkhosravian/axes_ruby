import axios from 'axios';

export default {
  authentications: {
    sign_in: (user) => axios.post('/api/v1/sign_in', user).then(res => res.data),
    sign_up: (user) => axios.post('/api/v1/sign_up', user).then(res => res.data),
    logout: () => axios.delete('/api/v1/logout').then(res => res),
  },
}