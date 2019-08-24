import axios from 'axios'

export default {
  update(params, callback, failedCallback) {
    axios.post(`/widget_customization/update`, params)
         .then(response => callback(response.data))
         .catch(errors => failedCallback(errors))
  },
}
