import Alert from "@/util/Alert";
import { Messages } from "@/util/Messages";
import Request from "@/util/Request";

class Login {

  async auth(formData) {
    try {
      const { user, token } = await Request.post('/auth', formData);
      localStorage.setItem('ID', user.ID);
      localStorage.setItem('token', token);
    } catch (err) {
      console.log(err);
      const message = Messages[err.message] || 'AUTH_FAIL';
      Alert.showError(message);
      return Promise.reject(err);
    }
  }
}

export default new Login();
