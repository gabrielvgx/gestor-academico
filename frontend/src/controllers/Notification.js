import Request from "@/util/Request";

class Notification {
  async load() {
    try {
      const notifications = await Request.get('/notification');
      return notifications;
    } catch (err) {
      console.error(err.message);
    }
  }
}
new Notification().load();
export default new Notification();
