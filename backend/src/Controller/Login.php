<?php
namespace App\Controller;

use App\Provider\User;
use App\Template\Mail as MailTemplate;
use App\Util\ResponseHandler;
use App\Util\JWT;
use App\Util\Mail;
use App\Util\OTP;
use Psr\Http\Message\ResponseInterface as Response;
use Psr\Http\Message\ServerRequestInterface as Request;

class Login {

    private function getUserData($user) {
      return [
        'ID' => $user['ID'],
        'PROFILE' => $user['CARGO'],
        'NAME' => $user['NMUSUARIO'],
      ];
    }

    private function getUserIdByEmail($params) {
      $email = $params['email'] ?? null;
      if (!$email) {
        throw new \Exception('INVALID_EMAIL');
      }
      $result = User::getUserByEmail($email);
      if (empty($result)) {
        throw new \Exception('USER_NOT_FOUND');
      }
      list($user) = $result;
      return $user['ID'];
    }

    public function redefinePassword(Request $request, Response $response) {
      try {
        $params = $request->getParsedBody();
        $token = $params['token'] ?? null;
        $password = $params['password'] ?? null;
        if (!$token || !$password) {
          throw new \Exception('FAIL_REDEFINE_PASSWORD');
        }
        $result = JWT::validate($token);
        if ($result['status']) {
          $userId = $result['data']->userId;
          User::redefinePassword($userId, $password);
          return ResponseHandler::success($response, [
            'message' => 'SUCCESS_REDEFINE_PASSWORD',
          ]);
        } else {
          throw new \Exception($result['message']);
        }
      } catch(\Exception $err) {
        return ResponseHandler::error($response, $err);
      }
    }

    public function forgotPassword(Request $request, Response $response) {
      try {
        $params = $request->getParsedBody();
        $userId = $this->getUserIdByEmail($params);
        $code = OTP::generate($userId);
        $subject = "Seu código é {$code} para redefinir sua senha do Gestor Acadêmico";
        $body = MailTemplate::getOneTimePassword($code, );
        $images = [MailTemplate::getLogoImg()];
        Mail::send($params['email'], $subject, $body, $images);
        return ResponseHandler::success($response, [
          'message' => 'SUCCESS_SEND_EMAIL',
        ]);
      } catch(\Exception $err) {
        return ResponseHandler::error($response, $err);
      }
    }

    public function auth(Request $request, Response $response) {
      try {
        $params = $request->getParsedBody();
        $result = User::getUserByEmailAndPassword(
          $params['email'],
          $params['password']
        );

        if (empty($result)) {
          throw new \Exception('INVALID_EMAIL_PASSWORD');
        }

        $userData = $this->getUserData($result[0]);
        return ResponseHandler::success($response, [
          'user' => $userData,
          'token' => JWT::generate($userData),
        ]);

      } catch (\Exception $err) {
        return ResponseHandler::error($response, $err);
      }
    }

    public function verifyCode(Request $request, Response $response) {
      try {
        $params = $request->getParsedBody();
        $userId = $this->getUserIdByEmail($params);
        $isValid = OTP::validate($userId, $params['otp']);

        if (!$isValid) {
          throw new \Exception('INVALID_OTP_CODE');
        }
        $expirationTime = 5*60;
        $token = JWT::generate([ 'userId' => $userId ], $expirationTime);
        return ResponseHandler::success($response, [
          'token' => $token,
        ]);
      } catch (\Exception $err) {
        return ResponseHandler::error($response, $err);
      }
    }

    public function sendOneTimePasswordMail(Request $request, Response $response) {
      try {
        $userId = $request->getQueryParams()['userId'];
        if (!$userId) {
          throw new \Exception('Usuário não encontrado');
        }
        $code = OTP::generate($userId);
        $subject = "Seu código é {$code} para acessar o Gestor Acadêmico";
        $body = MailTemplate::getOneTimePassword($code);
        $images = [MailTemplate::getLogoImg()];
        Mail::send('', $subject, $body, $images);
        return ResponseHandler::success($response, [
          'message' => 'SUCCESS_SEND_OTP_MAIL',
        ]);
      } catch(\Exception $err) {
        return ResponseHandler::error($response, $err);
      }
    }
}