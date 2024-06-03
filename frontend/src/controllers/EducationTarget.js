import Alert from "@/util/Alert";
import Request from "@/util/Request";

class EducationTarget {
  async list() {
    try {
      const { data } = await Request.get('/education-target');
      return data;
    } catch(err) {
      Alert.showError('Ocorreu um erro ao buscar os objetivos educacionais (bncc). Tente novamente');
      return [];
    }
  }
}

export default new EducationTarget();
