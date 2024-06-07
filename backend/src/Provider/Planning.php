<?php

namespace App\Provider;

use App\Util\DB;
use App\Util\Query;

class Planning {

  static function create($params) {
    return (new DB())->execute(Query::get('CREATE_PLANNING'), $params);
  }

  static function read($params, $userId, $profile) {
    if ($profile === 'SUPERVISOR') {
      return (new DB())->fetch(Query::get('GET_PLANNING'), $params);
    }
    $params[] = $userId;
    
    return (new DB())->fetch(Query::get('GET_PLANNING_BY_USER'), $params);
  }

  static function readDetail($params) {
    return (new DB())->fetch(Query::get('DETAIL_PLANNING'), $params);
  }

  static function readQtPending($params) {
    return (new DB())->fetch(Query::get('COUNT_PENDING_PLANNING'), $params);
  }

  static function verifyExists($params) {
    return (new DB())->fetch(Query::get('EXISTS_PLANNING'), $params);
  }

}