<?php

namespace App\Controller;
use Psr\Http\Message\ResponseInterface as Response;
use Psr\Http\Message\ServerRequestInterface as Request;
use App\Provider\EducationTarget as EducationTargetProvider;
use App\Util\ResponseHandler;

class EducationTarget {
  function read(Request $request, Response $response) {
    try {
      $result = EducationTargetProvider::read();
      return ResponseHandler::success($response, [
        'data' => $result,
      ]);
    } catch (\Exception $err) {
      return ResponseHandler::error($response, $err);
    }
  }

}