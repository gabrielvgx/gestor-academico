<?php

namespace App\Util;

use Psr\Http\Message\ResponseInterface as Response;

class ResponseHandler {
  static function error(Response $response, $error = new \Exception('UNEXPECTED_ERROR')) {
    $response->getBody()->write(json_encode([
      'message' => $error->getMessage(),
    ]));
    return $response->withStatus(500)->withHeader('Content-Type', 'application/json');
    // var_dump(500);
  }
  static function success(Response $response, $data = []) {
    $response->getBody()->write(json_encode($data));
    return $response->withStatus(200)->withHeader('Content-Type', 'application/json');
  }
}