<?php

namespace App\Provider;

use App\Util\DB;
use App\Util\Query;

class School {

  static function read($params) {
    return (new DB())->fetch(Query::get('READ_SCHOOL'), $params);
  }

  static function readSchoolAndClass($params) {
    return (new DB())->fetch(Query::get('READ_SCHOOL_AND_CLASS'), [$params['userId']]);
  }

  static function getSchoolCount($params) {
    return (new DB())->fetch(Query::get('GET_SCHOOL_COUNT'), [$params['userId']]);
  }

}