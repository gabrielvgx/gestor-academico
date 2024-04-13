<?php

namespace App\DataBase;

interface IDataBase {
  function connect();
  function fetch($sql, $params);
  // function execute($sql, $params);
}