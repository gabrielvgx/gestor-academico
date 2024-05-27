import Alert from "@/util/Alert";
import Request from "@/util/Request";

class Planning {
  async applyFilter(filter) {
    try {
      const {
        school,
        status = 'PENDENTE',
        planningMonth: month,
        planningYear: year,
      } = filter;

      const { data } = await Request.get('/planning', { school, status, month: month+1, year });
      return data;
    } catch(err) {
      console.error(err.message);
      Alert.showError('Ocorreu um erro ao buscar os planejamentos. Tente novamente');
      return [];
    }
  }
}

export default new Planning();
