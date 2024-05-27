<?php
namespace App\Controller;

use App\Provider\User as UserProvider;
use App\Provider\UserOrg as UserOrgProvider;
use App\Util\ResponseHandler;
use Psr\Http\Message\ResponseInterface as Response;
use Psr\Http\Message\ServerRequestInterface as Request;

class User {

    public function create(Request $request, Response $response) {
      try {
        $params = $request->getParsedBody();
        $result = UserProvider::create($params);

        if (!$result || !isset($result['id'])) {
          throw new \Exception('FAIL_CREATE_USER');
        }

        if (isset($params['school']) && isset($params['classId'])) {
          UserOrgProvider::create([
            'id' => $result['id'],
            'school' => $params['school'],
            'classId' => $params['classId'],
          ]);
        }

        return ResponseHandler::success($response, [
          'message' => 'SUCCESS_CREATE_USER',
          'data' => $result,
        ]);

      } catch (\Exception $err) {
        return ResponseHandler::error($response, $err);
      }
    }

    public function read(Request $request, Response $response) {
      try {
        $params = $request->getParsedBody();
        $result = UserProvider::read($params);
        list($resultQtUser) = UserProvider::getNumberUser();

        if (!$result) {
          throw new \Exception('FAIL_CREATE_USER');
        }

        return ResponseHandler::success($response, [
          'data' => $result,
          'total' => $resultQtUser['QTUSER'],
        ]);
      } catch(\Exception $err) {
        return ResponseHandler::error($response, $err);
      }
    }

    public function delete(Request $request, Response $response) {
      try {
        $params = $request->getParsedBody();
        foreach($params['users'] as $userId) {
          UserProvider::delete($userId);
        }

        return ResponseHandler::success($response, [
          'message' => 'SUCCESS_DELETE_USER',
          'data' => [],
        ]);
      } catch(\Exception $err) {
        return ResponseHandler::error($response, $err);
      }
    }
}