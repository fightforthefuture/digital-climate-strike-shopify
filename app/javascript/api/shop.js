import axios from 'axios'

export default {
  update(params, callback, failedCallback) {
    axios.post('/shop/update', params)
         .then(response => callback(response.data))
         .catch(errors => failedCallback(errors))
  },

  get(callback, failedCallback) {
    axios.get('/shop')
         .then(response => callback(response.data))
         .catch(errors => failedCallback(errors))
  }

}
