import Alert from "@/util/Alert";
import Request from "@/util/Request";

class Period {
  async list() {
    try {
      const { data } = await Request.get('/period');
      return data;
    } catch (err) {
      Alert.showError('Ocorreu um erro ao buscar os turnos. Tente novamente');
      return [];
    }
  }
}

export default new Period();
