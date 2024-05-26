<?php
namespace App\Controller;

use App\Provider\ClassProvider;
use App\Util\ResponseHandler;
use Psr\Http\Message\ResponseInterface as Response;
use Psr\Http\Message\ServerRequestInterface as Request;

class ClassController {

    public function read(Request $request, Response $response) {
      try {
        $schoolId = $request->getQueryParams()['IDESCOLA'];
        $result = ClassProvider::read([$schoolId]);

        if ($result === false) {
          throw new \Exception('FAIL_GET_CLASS');
        }

        return ResponseHandler::success($response, [
          'data' => $result,
        ]);
      } catch(\Exception $err) {
        return ResponseHandler::error($response, $err);
      }
    }
}