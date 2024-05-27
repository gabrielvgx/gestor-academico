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

  async create({ name, description }) {
    try {
      await Request.post('/material', { NMMATERIAL: name, DSMATERIAL: description });
      return true;
    } catch(err) {
      Alert.showError(err.message);
      return false;
    }
  }

  async remove(rows) {
    try {
      await Request.delete('/material', { rows });
      Alert.showSuccess('Materiais removidos com sucesso');
      return true;
    } catch (err) {
      Alert.showError(err.message);
      return false;
    }
  }
}

export default new Material();
