<?php

namespace App\Controller;
use Psr\Http\Message\ResponseInterface as Response;
use Psr\Http\Message\ServerRequestInterface as Request;
use App\Provider\Period as PeriodProvider;
use App\Util\ResponseHandler;

class Period {
  function read(Request $request, Response $response) {
    try {
      $result = PeriodProvider::read();
      return ResponseHandler::success($response, [
        'data' => $result,
      ]);
    } catch (\Exception $err) {
      return ResponseHandler::error($response, $err);
    }
  }

}