<?php

namespace App\Provider;

use App\Util\DB;
use App\Util\Query;

class MaterialRequest {

  static function create($params) {
    return (new DB())->execute(Query::get('CREATE_MATERIAL_REQUEST'), $params);
  }

  static function read($params) {
    return (new DB())->fetch(Query::get('READ_MATERIAL_REQUEST'), $params);
  }
  
  static function readById($params) {
    return (new DB())->fetch(Query::get('READ_MATERIAL_REQUEST_BY_ID'), $params);
  }

  static function updateStatus($params) {
    return (new DB())->execute(Query::get('UPDATE_STATUS_MATERIAL_REQUEST'), $params);
  }

}