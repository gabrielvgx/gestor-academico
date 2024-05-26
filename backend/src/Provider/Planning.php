<?php

namespace App\Provider;

use App\Util\DB;
use App\Util\Query;

class Planning {

  static function readQtPending($params) {
    return (new DB())->fetch(Query::get('COUNT_PENDING_PLANNING'), $params);
  }

}