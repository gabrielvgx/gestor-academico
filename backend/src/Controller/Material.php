<?php
namespace App\Controller;

use App\Provider\Material as MaterialProvider;
use App\Util\ResponseHandler;
use Psr\Http\Message\ResponseInterface as Response;
use Psr\Http\Message\ServerRequestInterface as Request;

class Material {

    public function create(Request $request, Response $response) {
      try {
        $tokenData = $request->getAttribute('token')['data'];
        $userId = $tokenData->ID;
        $params = $request->getParsedBody();
        $result = MaterialProvider::create([
          $params['NMMATERIAL'],
          $params['DSMATERIAL'],
          $userId,
        ]);

        if (!$result) {
          throw new \Exception('FAIL_CREATE_MATERIAL');
        }

        return ResponseHandler::success($response, [
          'message' => 'SUCCESS_CREATE_MATERIAL',
        ]);

      } catch (\Exception $err) {
        return ResponseHandler::error($response, $err);
      }
    }

    public function read(Request $request, Response $response) {
      try {
        $params = $request->getParsedBody();
        $result = MaterialProvider::read($params);

        if (!$result) {
          throw new \Exception('FAIL_GET_MATERIAL');
        }
        list($materialTotalizer) = MaterialProvider::readCount();
        return ResponseHandler::success($response, [
          'data' => $result,
          'total' => $materialTotalizer['NRMATERIAL'],
        ]);
      } catch(\Exception $err) {
        return ResponseHandler::error($response, $err);
      }
    }

    public function delete(Request $request, Response $response) {
      try {
        $params = $request->getParsedBody();
        foreach($params['rows'] as $row) {
          MaterialProvider::delete([$row['ID']]);
        }
        return ResponseHandler::success($response, [
          'message' => 'SUCCESS_REMOVE_ITEMS',
        ]);
      } catch(\Exception $error) {
        return ResponseHandler::error($response, $error);
      }
    }

    public function readMaterialRequest(Request $request, Response $response) {
      try {
        $params = $request->getQueryParams();
        $tokenData = $request->getAttribute('token')['data'];
        $profile = $tokenData->PROFILE;
        $userId = $profile === 'SUPERVISOR' ? null : $tokenData->ID;
        $result = MaterialProvider::readMaterialRequest([
          $params['school'] ?? 1,
          $params['status'] ?? 'PENDENTE',
          $userId,
        ]);
        return ResponseHandler::success($response, [
          'data' => $result,
        ]);
      } catch(\Exception $error){
        return ResponseHandler::error($response, $error);
      }
    }
}