<?php
namespace App\Controller;

use App\Provider\Planning as PlanningProvider;
use App\Util\ResponseHandler;
use Psr\Http\Message\ResponseInterface as Response;
use Psr\Http\Message\ServerRequestInterface as Request;

class Planning {

    public function read(Request $request, Response $response) {
      try {
        $queryParams = $request->getQueryParams();
        $params = [
          $queryParams['school'],
          $queryParams['status'],
          $queryParams['month'],
          $queryParams['year'],
        ];
        $result = PlanningProvider::read($params);

        return ResponseHandler::success($response, [
          'data' => $result,
        ]);
      } catch(\Exception $err) {
        return ResponseHandler::error($response, $err);
      }
    }
}