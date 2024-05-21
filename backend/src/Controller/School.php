<?php
namespace App\Controller;

use App\Provider\School as SchoolProvider;
use App\Util\ResponseHandler;
use Psr\Http\Message\ResponseInterface as Response;
use Psr\Http\Message\ServerRequestInterface as Request;

class School {

    public function read(Request $request, Response $response) {
      try {
        $params = $request->getParsedBody();
        $result = SchoolProvider::read($params);

        if (!$result) {
          throw new \Exception('FAIL_GET_SCHOOL');
        }

        return ResponseHandler::success($response, [
          'data' => $result,
        ]);
      } catch(\Exception $err) {
        return ResponseHandler::error($response, $err);
      }
    }
}