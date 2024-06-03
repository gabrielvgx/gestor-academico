import Alert from "@/util/Alert";
import Request from "@/util/Request";

class Food {
  async applyFilter(filter) {
    try {
      filter.month = filter.month+1;
      const { data } = await Request.get('/food', filter);
      return data;
    } catch (err) {
      console.error(err.message);
      Alert.showError('Falha ao buscar registros alimentares. Tente novamente');
    }
  }
}

export default new Food();
