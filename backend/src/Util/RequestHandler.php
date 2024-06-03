<?php

namespace App\Util;
use Psr\Http\Message\ServerRequestInterface as Request;

class RequestHandler {
  static function getTokenData(Request $request) {
    $tokenData = $request->getAttribute('token')['data'];
    return $tokenData;
  }

  static function getUserId(Request $request) {
    return RequestHandler::getTokenData($request)->ID;
  }

  static function getUserProfile(Request $request) {
    return RequestHandler::getTokenData($request)->PROFILE;
  }
}