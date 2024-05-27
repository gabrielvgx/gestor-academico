import Alert from "@/util/Alert";
import Request from "@/util/Request";

class School {
  async list() {
    try {
      const { data } = await Request.get('/school');
      return data;
    } catch(err) {
      Alert.showError('Ocorreu um erro ao buscar as escolas');
      return [];
    }
  }
}

export default new School();
