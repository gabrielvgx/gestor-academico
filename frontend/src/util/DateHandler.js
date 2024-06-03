import { format, parse } from 'date-fns';
import { ptBR as locale } from 'date-fns/locale';

class DateHandler {
  formatStr(dateStr, { from, to }) {
    const parsedDate = parse(dateStr, from, new Date());
    return format(parsedDate, to);
  }
  formatStrLocale(dateStr, { from, to }) {
    const parsedDate = this.toDate(dateStr, { from });
    return format(parsedDate, to, { locale });
  }
  formatDate(date, { to }) {
    return format(date, to);
  }
  toDate(dateStr, { from }) {
    const parsedDate = parse(dateStr, from, new Date());
    return parsedDate;
  }
}

export default new DateHandler();
