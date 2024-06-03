import Alert from "@/util/Alert";
import Request from "@/util/Request";

class MaterialRequest {
  async applyFilter(filter) {
    try {
      const {
        school,
        month,
        year,
      } = filter;
      const { data } = await Request.get('/material-request', { school, month: month+1, year })
      return data;
    } catch(err) {
      Alert.showError('Ocorreu um erro ao buscar as solicitações de material. Tente novamente');
      return [];
    }
  }

  async getRequestDetail(id) {
    try {
      const { data } = await Request.get('/material-request', { id });
      const { DSJUSTIFICATIVA, NMUSUARIO, DTUTILIZCAO, MATERIAL, ...otherParams } = data;
      return {
        reason: DSJUSTIFICATIVA,
        username: NMUSUARIO,
        utilizationDate: DTUTILIZCAO,
        material: MATERIAL.reduce((result, item) => {
          result[item.IDMATERIAL] = { QUANTITY: item.QTMATERIAL, NMMATERIAL: item.NMMATERIAL };
          return result;
        }, {}),
        data: otherParams
      };
    } catch(err) {
      Alert.showError('Ocorreu um erro ao buscar a solicitação de material. Tente novamente');
      return null;
    }
  }
}

export default new MaterialRequest();
