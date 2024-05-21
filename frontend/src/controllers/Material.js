import Alert from "@/util/Alert";
import Request from "@/util/Request";

class Material {
  async list() {
    try {
      const result = await Request.get('/material');
      return result;
    } catch (err) {
      Alert.showError(err.message);
      return [];
    }
  }
}

export default new Material();
