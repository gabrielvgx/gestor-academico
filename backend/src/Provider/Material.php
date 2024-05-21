<?php

namespace App\Provider;

use App\Util\DB;
use App\Util\Query;

class Material {

  static function create($params) {
    return (new DB())->execute(Query::get('CREATE_MATERIAL'), [
      // ...materialData
    ]);
  }

  static function read($params) {
    return (new DB())->fetch(Query::get('READ_MATERIAL'), $params);
  }

  static function getNumberUser() {
    return (new DB())->fetch(Query::get('NUMBER_USER'));
  }
}