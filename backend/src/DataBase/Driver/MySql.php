<?php

namespace App\DataBase\Driver;
// use App\
// use App\D
use App\DataBase\IDataBase;

class MySql implements IDataBase {
  function connect() {
    try {
      $conn = \mysqli_connect(
        $_ENV['DB_HOST'],
        $_ENV['DB_USER'],
        $_ENV['DB_PASSWORD'],
        $_ENV['DB_NAME'] ?? null,
        $_ENV['DB_PORT'] ?? null
      );
      if (!$conn) {
        throw new \Exception('FAIL_CONNECT_DB');
      }
      return $conn;

    } catch (\Exception $err) {
      throw $err;
    }
  }

  function getParamTypes($params = []) {
    $types = '';
    foreach ($params as $param) {
      if (is_int($param)) {
          $types .= 'i'; // inteiro
      } elseif (is_float($param)) {
          $types .= 'd'; // double
      } elseif (is_string($param)) {
          $types .= 's'; // string
      } else {
          $types .= 'b'; // blob
      }
    }
    return $types;
  }

  function fetch($sql, $params = []) {
    $conn = $this->connect();
    $stmt = $conn->prepare($sql);
    if (!empty($params)) {
      $types = $this->getParamTypes($params);
      $stmt->bind_param($types, ...$params);
    }
    $stmt->execute();
    $result = $stmt->get_result();
    $stmt->close();
    $conn->close();
    if ($result === false) {
      throw new \Exception("ERROR_EXECUTE_QUERY: $sql | PARAMS: $params");
    }
    return $result->fetch_all(MYSQLI_ASSOC);
  }
}