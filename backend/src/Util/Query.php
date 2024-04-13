<?php

namespace App\Util;

class Query {
  private static $data = [
    'mysql' => [
      'USER_EMAIL_PASSWORD' => "SELECT * FROM USUARIO WHERE EMAIL = ? AND PASSWORD = ?",
    ],
  ];

  private static function getQueriesByDriver() {
    $driver = $_ENV['DB_DRIVER'];
    if (!$driver || !isset(Query::$data[$driver])) {
      throw new \Exception("Invalid DBDRIVER: $driver");
    }
    return Query::$data[$driver];
  }

  static function get($name) {
    return Query::getQueriesByDriver()[$name];
  }
}