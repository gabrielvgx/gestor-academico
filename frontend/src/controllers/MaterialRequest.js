import Alert from "@/util/Alert";
import DateHandler from "@/util/DateHandler";
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

      const { DSJUSTIFICATIVA, NMUSUARIO, DTUTILIZACAO, MATERIAL, IDESCOLA, STATUS, DSRETORNO, DTINCLUSAO, ...otherParams } = data;
      return {
        reason: DSJUSTIFICATIVA,
        username: NMUSUARIO,
        schoolId: IDESCOLA,
        status: STATUS,
        feedback: DSRETORNO,
        utilizationDate: DateHandler.toDate(DTUTILIZACAO, { from: 'dd/MM/yyyy'}),
        solicitationDate: DTINCLUSAO,
        material: MATERIAL.reduce((result, item) => {
          result[item.IDMATERIAL] = { QUANTITY: item.QTMATERIAL, NMMATERIAL: item.NMMATERIAL };
          return result;
        }, {}),
        data: otherParams
      };
    } catch(err) {
      console.error(err.message);
      Alert.showError('Ocorreu um erro ao buscar a solicitação de material. Tente novamente');
      return null;
    }
  }

  async save(formValue) {
    try {
      const {
        schoolId,
        reason,
        material,
        utilizationDate,
      } = formValue;
      const payload = {
        schoolId,
        reason,
        utilizationDate: DateHandler.formatDate(utilizationDate, { to: 'yyyy-MM-dd' }),
        material: Object.values(material).map(({ ID, QUANTITY }) => {
          return { ID, QUANTITY }
        })
      };
      await Request.post('/material-request', payload);
      Alert.showSuccess('Solicitação de material enviada com sucesso');
      return true;
    } catch(err) {
      console.error(err.message);
      Alert.showError('Ocorreu um erro ao salvar a solicitação de material. Tente novamente');
      return false;
    }
  }

  async changeStatus(requestId, status, feedback) {
    try {
      await Request.put('/material-request', { requestId, status, feedback });
      Alert.showSuccess('Solicitação alterada com sucesso');
      return true;
    } catch (err) {
      console.error(err.message);
      Alert.showError('Ocorreu um erro ao alterar o status solicitação. Tente novamente');
      return false;
    }
  }
}

export default new MaterialRequest();
