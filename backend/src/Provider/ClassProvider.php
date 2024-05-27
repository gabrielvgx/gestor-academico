<?php

namespace App\Provider;

use App\Util\DB;
use App\Util\Query;

class ClassProvider {

  static function read($params) {
    return (new DB())->fetch(Query::get('READ_CLASS'), $params);
  }

}