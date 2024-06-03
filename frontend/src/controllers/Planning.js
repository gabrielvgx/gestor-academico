import Alert from "@/util/Alert";
import DateHandler from "@/util/DateHandler";
import { Messages } from "@/util/Messages";
import Request from "@/util/Request";
import { format, parse } from "date-fns";

class Planning {
  async applyFilter(filter) {
    try {
      const {
        school,
        month,
        year,
      } = filter;

      const { data } = await Request.get('/planning', { school, month: month+1, year });
      return data;
    } catch(err) {
      console.error(err.message);
      Alert.showError('Ocorreu um erro ao buscar os planejamentos. Tente novamente');
      return [];
    }
  }

  async save(formValue) {
    try {
      const {
        schoolId: school,
        classId,
        data,
      } = formValue;
      const payload = {
        school,
        classId,
        data: data.map(dayInfo => {
          const { DTPLANO, TURNO, BNCC } = dayInfo;
          const BNCC_DATASET = BNCC.map(({ ID }) => ID);
          let IDBNCC = '';
          if (BNCC_DATASET.length) {
            IDBNCC = `;${BNCC_DATASET.join(';')};`;
          }
          return ({
            DTPLANO: DateHandler.formatStr(DTPLANO, { from: 'dd/MM/yyyy', to: 'yyyy-MM-dd'}),
            TURNO: TURNO.map(period => {
              const { ID, DSATIVIDADE } = period;
              return { ID, DSATIVIDADE };
            }),
            IDBNCC,
          });
        }),
      };
      await Request.post('/planning', payload);
      Alert.showSuccess('Planejamento salvo com sucesso');
      return true;
    } catch(err) {
      const message = Messages[err.message] || 'Ocorreu um erro ao salvar o planejamento. Tente novamente';
      Alert.showError(message);
      return false;
    }
  }

  async getDetail({ item }) {
    try {
      const {
        IDESCOLA: school,
        IDTURMA: classId,
        DTINICIAL,
        DTFINAL,
      } = item;
      const start = format(parse(DTINICIAL, 'dd/MM/yyyy', new Date()), 'yyyy-MM-dd');
      const end = format(parse(DTFINAL, 'dd/MM/yyyy', new Date()), 'yyyy-MM-dd');
      const { data } = await Request.get('/planning-detail', { school, classId, start, end })
      const [{ NMUSUARIO, IDESCOLA, NMESCOLA, IDTURMA, NMTURMA }] = data;
      const result = {
        username: NMUSUARIO,
        schoolId: IDESCOLA,
        classId: IDTURMA,
        schools: [{ ID: IDESCOLA, NMESCOLA }],
        allClass: [{ ID: IDTURMA, NMTURMA }],
        planningDate: data.map(({ DTPLANO }) => DateHandler.toDate(DTPLANO, { from: 'dd/MM/yyyy' })),
        data,
      };
      return result;
    } catch(err) {
      console.error(err);
      const message = Messages[err.message] || 'Ocorreu um erro ao retornar o planejamento';
      Alert.showError(message);
      return null;
    }
  }
}

export default new Planning();
