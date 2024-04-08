import Alert from "@/util/Alert";

class Login {
  //todo Implementar rotina comunicando com backend para login
  async auth(formData) {
    console.log(formData.email);
    if(formData.email === 'error') { // demonstracao de erro
      Alert.showError('AUTH_FAIL');
    } else if (formData.email === 'error_not_found') {
      Alert.showError('USER_NOT_FOUND');
    } else {
      return true;
    }
    return false;
  }
}

export default new Login();
