<?php

namespace App\Util;

use \Firebase\JWT\JWT as FirebaseJWT;

class JWT {

  const DEFAULT_EXP_TIME = (60 * 60 * 24); // one day

  static function generate($data = [], $expirationTime = JWT::DEFAULT_EXP_TIME) {

    $tokenPayload = [
        'exp' => \time() + $expirationTime,
        'data' => $data,
        'kid' => '1'
    ];
    $token = FirebaseJWT::encode($tokenPayload, $_ENV["JWT_SECRET_KEY"], 'HS256');

    return $token;
  }
}