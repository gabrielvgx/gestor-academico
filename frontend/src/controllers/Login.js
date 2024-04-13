import Alert from "@/util/Alert";
import { Messages } from "@/util/Messages";
import Request from "@/util/Request";

class Login {

  async auth(formData) {
    try {
      const { user } = await Request.post('/auth', formData);
      localStorage.setItem('ID', user.ID);
      localStorage.setItem('token', Date.now().toString());
    } catch (err) {
      console.log(err);
      const message = Messages[err.message] || 'AUTH_FAIL';
      Alert.showError(message);
      return Promise.reject(err);
    }
  }
}

export default new Login();
