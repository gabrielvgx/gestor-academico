<?php

namespace App\Provider;

use App\Util\DB;
use App\Util\Query;

class Dashboard {
  static function getPlanning($startDate, $endDate) {
    return (new DB())->fetch(Query::get('DSB_PLANNING'), []);
  }
}