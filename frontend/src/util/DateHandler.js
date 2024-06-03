import { format, parse } from 'date-fns';

class DateHandler {
  formatStr(dateStr, { from, to }) {
    const parsedDate = parse(dateStr, from, new Date());
    return format(parsedDate, to);
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
