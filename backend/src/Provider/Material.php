<?php

namespace App\Provider;

use App\Util\DB;
use App\Util\Query;

class Material {

  static function create($params) {
    return (new DB())->execute(Query::get('CREATE_MATERIAL'), $params);
  }

  static function read($params) {
    return (new DB())->fetch(Query::get('READ_MATERIAL'), $params);
  }

  static function readCount() {
    return (new DB())->fetch(Query::get('READ_MATERIAL_COUNT'));
  }

  static function delete($params) {
    return (new DB())->execute(Query::get('DELETE_MATERIAL'), $params);
  }

  static function readMaterialRequest($params) {
    return (new DB())->fetch(Query::get('READ_MATERIAL_REQUEST'), $params);
  }

  static function readMaterialRequestCount($params) {
    return (new DB())->fetch(Query::get('READ_MATERIAL_REQUEST_COUNT'), $params);
  }

  static function readMaterialRequestById($params) {
    return (new DB())->fetch(Query::get('READ_MATERIAL_REQUEST_BY_ID'), $params);
  }
}