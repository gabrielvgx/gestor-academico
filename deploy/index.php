<?php

if (strpos($_SERVER['REQUEST_URI'], '/index.php')) {
  require_once '../backend/public/index.php';
  file_put_contents('../tmp/teste.txt', 'REQ_URI');
} else {
  include 'app.html';
}