<?php

namespace App\Provider;

use App\Util\DB;
use App\Util\Query;
use App\Util\UniqueId;

class User {
  static function getUserByEmailAndPassword($email, $password) {
    $encryptedPassword = hash('sha256', $password);
    return (new DB())->fetch(Query::get('USER_EMAIL_PASSWORD'), [
      $email,
      $encryptedPassword,
    ]);
  }

  static function create($userData) {
    $id = UniqueId::generate();
    $result = (new DB())->execute(Query::get('CREATE_USER'), [
      $id,
      $userData['name'],
      $userData['office'],
      $userData['email'],
      'EMPTY_PASSWORD',
    ]);
    return [
      'id' => $result ? $id : null,
    ];
  }

  static function delete($userId) {
    var_dump($userId);
    return (new DB())->execute(Query::get('DELETE_USER'), [$userId]);
  }

  static function read($params) {
    return (new DB())->fetch(Query::get('READ_USER'), $params);
  }

  static function getNumberUser() {
    return (new DB())->fetch(Query::get('NUMBER_USER'));
  }
}