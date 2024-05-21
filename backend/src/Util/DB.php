<?php

namespace App\Util;
use App\DataBase\Driver;
use App\DataBase\IDataBase;

class DB implements IDataBase {

  private $instance;

  public function __construct() {
    $driver = $_ENV['DB_DRIVER'];
    switch ($driver) {
      case 'mysql':
        $this->instance = new Driver\MySql();
        break;
      default:
        throw new \Exception("Invalid DB_DRIVER: $driver");
    }
  }

  function connect() {
    return $this->instance->connect();
  }

  function fetch($sql, $params = []) {
    return $this->instance->fetch($sql, $params);
  }

  function execute($sql, $params = []) {
    return $this->instance->execute($sql, $params);
  }
}