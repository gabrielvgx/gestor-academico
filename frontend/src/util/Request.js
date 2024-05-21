import axios from 'axios';
import Env from './Env';

class Request {
  static setInterceptor() {
    axios.interceptors.response.use(resp => resp, async (error) => {
      const isRefreshRoute = (route) => route.includes('/access/refresh-token');
      const { config } = error;
      const refreshToken = localStorage.getItem('control-auth-refresh-token');
      if (error.response && error.response.status === 401 && !isRefreshRoute(config.url)) {
        return Request.post('/access/refresh-token', { refreshToken }).then(response => {
          const { token } = response;
          localStorage.setItem('control-auth-token', token);
          config.headers.Authorization = `Bearer ${token}`;
          return axios(config);
        }).catch(err => {
          return Promise.reject(err);
        });
      }
      return Promise.reject(error);
    });
  }

  static getQueryParams(paramToBuild) {
    const searchParams = new URLSearchParams(Object.entries(paramToBuild));
    return searchParams.toString();
  }

  static removeStartEndBar(text) {
    return text.replace(/^\/|\/+$/g, '');
  }

  static getServerUri() {
    const serverUri = Env.get('SERVER_URL') || '';
    return Request.removeStartEndBar(serverUri);
  }

  static async sendCustom(url, options) {
    const defaultHeaders = {
      'Content-Type': 'application/json',
    };
    const { method, data, headers = {} } = options;
    return axios({
      method,
      url,
      data,
      headers: Object.assign(defaultHeaders, headers),
    }).then((response) => response.data);
  }

  static async send(endPoint, options) {
    const serverUri = Request.getServerUri();
    const endPointSanitized = Request.removeStartEndBar(endPoint);
    const URI = endPoint.includes('http') ? endPoint : `${serverUri}/${endPointSanitized}`;
    const { method, data, headers = {} } = options;
    const token = localStorage.getItem('token');
    const defaultHeaders = {
      'Content-Type': 'application/json',
      // 'Authorization': '',
    };
    if (token) {
      defaultHeaders.Authorization = `Bearer ${token}`;
    }
    return axios({
      method,
      url: URI,
      data,
      headers: Object.assign(defaultHeaders, headers),
    }).then((response) => response.data).catch(err => {
      if (err.response && err.response.data) {
        return Promise.reject(err.response.data);
      }
      return Promise.reject(err);
    });
  }

  static async post(endPoint, data = {}, options = {}) {
    return Request.send(endPoint, {
      ...options,
      method: 'POST',
      data,
    });
  }

  static async put(endPoint, data = {}, options = {}) {
    return Request.send(endPoint, {
      ...options,
      method: 'PUT',
      data,
    });
  }

  static async get(endPoint, params = {}, options = {}) {
    const hasParams = Object.keys(params).length;
    const URI = `${endPoint}${
      hasParams ? '?' + Request.getQueryParams(params) : ''
    }`;
    return Request.send(URI, { ...options, method: 'GET' });
  }

  static async delete(endPoint, data = {}, options = {}) {
    return Request.send(endPoint, {
      ...options,
      method: 'DELETE',
      data,
    });
  }
}

export { Request };
export default Request;
