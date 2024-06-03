<?php

namespace App\Provider;

use App\Util\DB;
use App\Util\Query;

class Food {

  static function read($params) {
    return (new DB())->fetch(Query::get('READ_FOOD'), $params);
  }

}