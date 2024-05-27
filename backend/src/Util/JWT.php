<?php

namespace App\Util;

use \Firebase\JWT\JWT as FirebaseJWT;
use \Firebase\JWT\Key;

class JWT {

  const DEFAULT_EXP_TIME = (60 * 60 * 24); // one day in seconds

  static function generate($data = [], $expirationTime = JWT::DEFAULT_EXP_TIME) {

    $tokenPayload = [
        'exp' => \time() + $expirationTime,
        'data' => $data,
        'kid' => '1'
    ];
    $token = FirebaseJWT::encode($tokenPayload, $_ENV["JWT_SECRET_KEY"], 'HS256');

    return $token;
  }

  static function validate($token) {
    try {
      $decoded = FirebaseJWT::decode($token, new Key($_ENV["JWT_SECRET_KEY"], 'HS256'));

      if ($decoded->exp < time()) {
        return ['status' => false, 'message' => 'EXPIRED_TOKEN'];
      }

      return ['status' => true, 'data' => $decoded->data];

    } catch (\Exception $e) {
      return ['status' => false, 'message' => 'INVALID_TOKEN'];
    }
  }

}