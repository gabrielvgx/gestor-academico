<?php

namespace App\Util;
use PHPMailer\PHPMailer\PHPMailer;
use PHPMailer\PHPMailer\OAuth;
use League\OAuth2\Client\Provider\Google;

class Mail {
  static function send() {
    $mail = new PHPMailer();
    $mail->isSMTP();
    $mail->Host = 'smtp.gmail.com';
    $mail->Port = 465;
    $mail->SMTPSecure = PHPMailer::ENCRYPTION_SMTPS;
    $mail->SMTPAuth = true;
    $mail->AuthType = 'XOAUTH2';

    // $mail->setHttpClient($guzzleClient);

    $mail->setFrom($_ENV['SMTP_USER_EMAIL'], $_ENV['SMTP_USER_NAME']);
    $mail->addAddress($_ENV['SMTP_USER_EMAIL'], $_ENV['SMTP_USER_NAME']);

    $mail->Subject = 'PHPMailer GMail XOAUTH2 SMTP test';
    $mail->CharSet = PHPMailer::CHARSET_UTF8;
    $mail->Body = 'Teste';

    $clientId = $_ENV['SMTP_CLIENT_ID'];
    $clientSecret = $_ENV['SMTP_CLIENT_SECRET'];

    $refreshToken = $_ENV['SMTP_REFRESH_TOKEN'];

    $provider = new Google(
      [
        'clientId' => $clientId,
        'clientSecret' => $clientSecret,
      ]
    );

    $guzzleClient = new \GuzzleHttp\Client(array('curl' => array(CURLOPT_SSL_VERIFYPEER => false,),));
    $provider->setHttpClient($guzzleClient);


    $mail->setOAuth(
        new OAuth(
          [
            'provider' => $provider,
            'clientId' => $clientId,
            'clientSecret' => $clientSecret,
            'refreshToken' => $refreshToken,
            'userName' => $_ENV['SMTP_USER_EMAIL'],
          ]
        )
    );

    if (!$mail->send()) {
      echo 'Mailer Error: ' . $mail->ErrorInfo;
    } else {
        echo 'Message sent!';
    }
  }
}