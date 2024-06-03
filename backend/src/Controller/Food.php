<?php
namespace App\Controller;

use App\Provider\Food as FoodProvider;
use App\Util\ResponseHandler;
use Psr\Http\Message\ResponseInterface as Response;
use Psr\Http\Message\ServerRequestInterface as Request;

class Food {

    public function read(Request $request, Response $response) {
      try {
        $params = $request->getQueryParams();
        $tokenData = $request->getAttribute('token')['data'];
        $profile = $tokenData->PROFILE;
        $userId = $profile === 'SUPERVISOR' ? null : $tokenData->ID;
        $result = FoodProvider::read([$params['school'], $params['month'], $params['year'], $userId]);

        // if (!$result) {
        //   throw new \Exception('FAIL_GET_SCHOOL');
        // }

        return ResponseHandler::success($response, [
          'data' => $result,
        ]);
      } catch(\Exception $err) {
        return ResponseHandler::error($response, $err);
      }
    }
}