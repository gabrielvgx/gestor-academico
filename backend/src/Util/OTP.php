<?php

namespace App\Util;
use OTPHP\TOTP;
use Tuupola\Base32;

class OTP {

  static function createTopt($uuid) {
    $base32 = new Base32();
    $secret = $base32->encode($uuid);
    $totp = TOTP::create($secret);
    $totp->setDigits(6);
    $totp->setPeriod(300); // 5 minutes
    return $totp;
  }

  static function generate($uuid) {
    $totp = OTP::createTopt($uuid);
    return $totp->now();
  }

  static function validate($uuid, $otp) {
    $totp = OTP::createTopt($uuid);
    return $totp->verify($otp);
  }
}