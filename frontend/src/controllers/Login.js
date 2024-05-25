import Alert from "@/util/Alert";
import { Messages } from "@/util/Messages";
import Request from "@/util/Request";
import StorageHandler from "@/util/StorageHandler";

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

  logout() {
    localStorage.clear();
    window.location.reload();
  }

  async forgotPassword({ email }) {
    try {
      await Request.post('/forgot-password', { email });
      return true;
    } catch (err) {
      Alert.showError(err.message);
      return false;
    }
  }

  async redefinePassword(password) {
    try {
      const token = StorageHandler.getNewPassToken();
      await Request.post('/redefine-password', { password, token });
      return true;
    } catch (err) {
      Alert.showError(err.message);
      return false;
    }
  }

  async submitCode(otp) {
    try {
      const email = StorageHandler.getForgotPassUser();
      const { token } = await Request.post('/verify-otp', { email, otp });
      return token;
    } catch(err) {
      Alert.showError(err.message);
      return null;
    }
  }
}

export default new Login();
