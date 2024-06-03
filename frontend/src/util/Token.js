class Token {
  getToken() {
    return localStorage.getItem('token');
  }
  getTokenData() {
    try {
      const token = this.getToken();
      if (!token) {
        throw new Error('TOKEN_NOT_FOUND');
      }
      const [, data,] = token.split('.');
      return JSON.parse(atob(data)).data;
    } catch (err) {
      console.error(err);
      return null;
    }
  }
  getUserProfile() {
    return this.getTokenData()?.PROFILE;
  }
  getUserId() {
    return this.getTokenData()?.ID;
  }
  getUserName() {
    return this.getTokenData()?.NAME;
  }
}

export default new Token();
