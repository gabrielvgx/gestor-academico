<?php

namespace App\Provider;

use App\Util\DB;
use App\Util\Query;

class Dashboard {
  static function getPlanning($params) {
    return (new DB())->fetch(Query::get('DSB_PLANNING'), $params);
  }

  static function getDsbFood($params) {
    return (new DB())->fetch(Query::get('DSB_FOOD'), $params);
  }
}