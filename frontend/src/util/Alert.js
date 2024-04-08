import { notify } from '@kyvg/vue3-notification';
import { Messages } from '@/util/Messages';

class Alert {
  static showNotification(options = {}) {
    //todo translate text notification before emit
    if (options.text in Messages) {
      options.text = Messages[options.text];
    }
    notify({ ...options });
  }

  static showInfo(text, title = '') {
    Alert.showNotification({
      title,
      text,
      type: 'info',
    });
  }

  static showWarn(text, title = '') {
    Alert.showNotification({
      title,
      text,
      type: 'warn',
    });
  }

  static showError(text, title = '') {
    Alert.showNotification({
      title,
      text,
      type: 'error',
    });
  }

  static showSuccess(text, title = '') {
    Alert.showNotification({
      title,
      text,
      type: 'success',
    });
  }
}


export { Alert };
export default Alert;

