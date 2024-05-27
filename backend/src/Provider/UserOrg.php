<?php

namespace App\Provider;

use App\Util\DB;
use App\Util\Query;

class UserOrg {

  static function create($params) {
    return (new DB())->execute(Query::get('CREATE_USER_ORG'), [
      $params['id'],
      $params['school'],
      $params['classId'],
    ]);
  }

}