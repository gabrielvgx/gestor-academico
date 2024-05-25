import Request from '@/util/Request';
import Env from './Env';

class GoogleAuth {
  async getGoogleBtnElement() {
    let element = document.getElementById('g_id_onload');
    let resolve, reject;
    let trie = 1;
    const elementPromise = new Promise((_resolve, _reject) => {
      resolve = _resolve;
      reject = _reject;
    })
    if (!element) {
      const elInterval = setInterval(() => {
        element = document.getElementById('g_id_onload');
        if (element) {
          resolve();
          clearInterval(elInterval);
        } else if(trie > 5) {
          console.error('Falha ao carregar componentes');
          reject();
          clearInterval(elInterval);
        } else {
          trie++;
        }
      }, 1000);
      await elementPromise;
    }
    return element;
  }
  register() {
    window.onload = async () => {
      if (['/', '/login'].includes(location.pathname) && false) {
        const googleBtn = await this.getGoogleBtnElement();
        const googleApi = window.google.accounts.id;
        googleApi.initialize({
          client_id: Env.get('GOOGLE_CLIENT_ID'),
          callback: function() { console.log('success_callback', ...arguments) },
        });
        googleApi.renderButton(googleBtn, {
          'scope': 'profile email',
          'width': '100%',
          'height': 40,
          'size': 'medium',
          'theme': 'outline',
          'shape': 'pill',
        });
      }
    }
  }
}

export default new GoogleAuth();
