import Alert from "@/util/Alert";
import Request from "@/util/Request";

class User {
  async create(data) {
    try {
      await Request.post('/user', data);
      Alert.showSuccess('Usuário salvo com sucesso');
    } catch(err) {
      Alert.showError('Falha ao salvar usuario. Tente novamente');
    }
  }

  async remove(users) {
    try {
      const usersToRemove = users.filter(user => user.ID !== localStorage.getItem('ID')).map(user => user.ID);
      await Request.delete('/user', { users: usersToRemove });
      Alert.showSuccess('Usuário(s) removido(s) com sucesso');
    } catch(err) {
      Alert.showError('Falha ao remover o(s) usuário(s) selecionado(s)');
    }
  }
}

export default new User();
