<?php

namespace App\Provider;

use App\Util\DB;
use App\Util\Query;

class User {
  static function getUserByEmailAndPassword($email, $password) {
    // var_dump($email, $password);die;
    $encryptedPassword = hash('sha256', $password);
    return (new DB())->fetch(Query::get('USER_EMAIL_PASSWORD'), [
      $email,
      $encryptedPassword,
    ]);
  }
}