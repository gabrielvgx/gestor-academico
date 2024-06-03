<?php
namespace App\Controller;

use App\Provider\MaterialRequest as MaterialRequestProvider;
use App\Util\ResponseHandler;
use Psr\Http\Message\ResponseInterface as Response;
use Psr\Http\Message\ServerRequestInterface as Request;
use App\Util\UniqueId;

class MaterialRequest {

    public function create(Request $request, Response $response) {
      try {
        $tokenData = $request->getAttribute('token')['data'];
        $userId = $tokenData->ID;
        $params = $request->getParsedBody();
        $requestId = UniqueId::generate();
        foreach($params['material'] as $material) {
          MaterialRequestProvider::create([
            $requestId,
            $material['ID'],
            $params['schoolId'],
            $userId,
            'PENDENTE',
            $material['QUANTITY'],
            $params['reason'],
            $params['utilizationDate'],
          ]);
        }
        // $result = MaterialProvider::create([
        //   $params['NMMATERIAL'],
        //   $params['DSMATERIAL'],
        //   $userId,
        // ]);

        // if (!$result) {
        //   throw new \Exception('FAIL_CREATE_MATERIAL');
        // }

        return ResponseHandler::success($response, [
          'message' => 'SUCCESS_CREATE_MATERIAL',
        ]);

      } catch (\Exception $err) {
        return ResponseHandler::error($response, $err);
      }
    }

    public function read(Request $request, Response $response) {
      try {
        $params = $request->getQueryParams();
        $tokenData = $request->getAttribute('token')['data'];
        $profile = $tokenData->PROFILE;
        $userId = $profile === 'SUPERVISOR' ? null : $tokenData->ID;
        $result = [];
        if (isset($params['id'])) {
          $tempResult = MaterialRequestProvider::readById([ $params['id'] ]);
          list($firstRow) = $tempResult;
          $result = [
            'DSJUSTIFICATIVA' => $firstRow['DSJUSTIFICATIVA'],
            'DTINCLUSAO' => $firstRow['DTINCLUSAO'],
            'DTUTILIZACAO' => $firstRow['DTUTILIZACAO'],
            'IDREQUISICAO' => $firstRow['IDREQUISICAO'],
            'NMUSUARIO' => $firstRow['NMUSUARIO'],
            'STATUS' => $firstRow['STATUS'],
            'IDESCOLA' => $firstRow['IDESCOLA'],
            'DSRETORNO' => $firstRow['DSRETORNO'],
            'NMESCOLA' => $firstRow['NMESCOLA'],
            'MATERIAL' => [],
          ];
          foreach($tempResult as $material) {
            $result['MATERIAL'][] = [
              'IDMATERIAL' => $material['IDMATERIAL'],
              'NMMATERIAL' => $material['NMMATERIAL'],
              'QTMATERIAL' => $material['QTMATERIAL'],
            ];
          }
        } else {
          $result = MaterialRequestProvider::read([
            $params['school'],
            $userId,
          ]);
        }
        return ResponseHandler::success($response, [
          'data' => $result,
        ]);
      } catch(\Exception $error){
        return ResponseHandler::error($response, $error);
      }
    }

    public function update(Request $request, Response $response) {
      try {
        $params = $request->getParsedBody();
        MaterialRequestProvider::updateStatus([ $params['status'], $params['feedback'], $params['requestId'] ]);
        return ResponseHandler::success($response, [
          'message' => 'SUCCESS_UPDATE_MATERIAL_REQUEST',
        ]);
      } catch (\Exception $err) {
        return ResponseHandler::error($response, $err);
      }
    }

}