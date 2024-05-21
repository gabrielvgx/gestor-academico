import Alert from "@/util/Alert";
import Request from "@/util/Request";

class ClassController {
  async list(IDESCOLA) {
    try {
      const { data } = await Request.get('/class', { IDESCOLA });
      return data;
    } catch(err) {
      Alert.showError('Ocorreu um erro ao buscar as turmas');
      return [];
    }
  }
}

export default new ClassController();
