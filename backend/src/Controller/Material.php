<?php
namespace App\Controller;

use App\Provider\Material as MaterialProvider;
use App\Util\ResponseHandler;
use Psr\Http\Message\ResponseInterface as Response;
use Psr\Http\Message\ServerRequestInterface as Request;

class Material {

    // public function create(Request $request, Response $response) {
    //   try {
    //     $params = $request->getParsedBody();
    //     $result = MaterialProvider::create($params);

    //     if (!$result) {
    //       throw new \Exception('FAIL_CREATE_MATERIAL');
    //     }

    //     return ResponseHandler::success($response, [
    //       'message' => 'SUCCESS_CREATE_MATERIAL',
    //     ]);

    //   } catch (\Exception $err) {
    //     return ResponseHandler::error($response, $err);
    //   }
    // }

    public function read(Request $request, Response $response) {
      try {
        $params = $request->getParsedBody();
        $result = MaterialProvider::read($params);

        if (!$result) {
          throw new \Exception('FAIL_GET_MATERIAL');
        }

        return ResponseHandler::success($response, [
          'data' => $result,
        ]);
      } catch(\Exception $err) {
        return ResponseHandler::error($response, $err);
      }
    }
}