<?php
namespace App\Controller;

use App\Provider\User;
use App\Util\ResponseHandler;
use Psr\Http\Message\ResponseInterface as Response;
use Psr\Http\Message\ServerRequestInterface as Request;

class Login {

    private function getUserData($user) {
      return [
        'ID' => $user['ID'],
        'CARGO' => $user['CARGO'],
      ];
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

        return ResponseHandler::success($response, [
          'user' => $this->getUserData($result[0])
        ]);

      } catch (\Exception $err) {
        return ResponseHandler::error($response, $err);
      }
    }
}