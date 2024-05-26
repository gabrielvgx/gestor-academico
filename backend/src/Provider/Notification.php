<?php

namespace App\Provider;

use App\Util\DB;
use App\Util\Query;

class Notification {

  static function readSupervisorNotification($params) {
    return (new DB())->fetch(Query::get('READ_SUPERVISOR_NOTIFICATION'), $params);
  }

  static function readTeacherNotification($params) {
    return (new DB())->fetch(Query::get('READ_NOTIFICATION'), $params);
  }

}