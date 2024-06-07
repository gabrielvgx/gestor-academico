<?php
namespace App\Controller;

use App\Provider\Planning as PlanningProvider;
use App\Util\ResponseHandler;
use Psr\Http\Message\ResponseInterface as Response;
use Psr\Http\Message\ServerRequestInterface as Request;
use App\Util\RequestHandler;

class Planning {

    public function create(Request $request, Response $response) {
      try {
        $params = $request->getParsedBody();
        $schoolId = $params['school'];
        $classId = $params['classId'];
        $result = PlanningProvider::verifyExists([$schoolId, $classId, $params['data'][0]['DTPLANO']]);

        if (count($result) > 0) {
          throw new \Exception('ALREADY_EXISTS_PLANNING');
        }

        foreach($params['data'] as $row) {
          foreach($row['TURNO'] as $period) {
            // STATUS, DTPLANO, IDESCOLA, IDTURMA, IDTURNO, DSATIVIDADE, IDBNCC, IDUSERINCLUSAO
            $rowToInsert = [
              'PENDENTE',
              $row['DTPLANO'],
              $schoolId,
              $classId,
              $period['ID'],
              $period['DSATIVIDADE'],
              $row['IDBNCC'],
              RequestHandler::getUserId($request),
            ];
            PlanningProvider::create($rowToInsert);
          }
        }
        return ResponseHandler::success($response, [
          'message' => 'SUCCESS_SAVE',
        ]);
      } catch(\Exception $err) {
        return ResponseHandler::error($response, $err);
      }
    }

    public function read(Request $request, Response $response) {
      try {
        $queryParams = $request->getQueryParams();
        $params = [
          $queryParams['school'],
          $queryParams['month'],
          $queryParams['year'],
        ];
        $result = PlanningProvider::read(
          $params,
          RequestHandler::getUserId($request),
          RequestHandler::getUserProfile($request)
        );

        return ResponseHandler::success($response, [
          'data' => $result,
        ]);
      } catch(\Exception $err) {
        return ResponseHandler::error($response, $err);
      }
    }

    public function readDetail(Request $request, Response $response) {
      try {
        $queryParams = $request->getQueryParams();
        $params = [
          $queryParams['school'],
          $queryParams['classId'],
          $queryParams['start'],
          $queryParams['end'],
        ];
        $result = PlanningProvider::readDetail($params);
        $data = [];
        $mappedDates = [];
        foreach($result as $row) {
          $planningDate = $row['DTPLANO'];
          $row['BNCC'] = [];
          $IDBNCC = explode(';', $row['IDBNCC']);
          $CODBNCC = explode(';', $row['CODBNCC']);
          array_shift($IDBNCC);
          array_pop($IDBNCC);
          foreach($IDBNCC as $index => $ID) {
            $row['BNCC'][] = [
              'IDBNCC' => $ID,
              'CODBNCC' => $CODBNCC[$index],
            ];
          }
          unset($row['CODBNCC']);
          unset($row['IDBNCC']);
          $index = array_search($planningDate, $mappedDates);
          if ($index === false) {
            $mappedDates[] = $planningDate;
            $row['TURNO'] = [
              [
                'IDTURNO' => $row['IDTURNO'],
                'NMTURNO' => $row['NMTURNO'],
                'DSATIVIDADE' => $row['DSATIVIDADE'],
                ]
              ];
              unset($row['IDTURNO']);
              unset($row['NMTURNO']);
              unset($row['DSATIVIDADE']);
              $data[] = $row;
            } else {
              $data[$index]['TURNO'][] = [
              'IDTURNO' => $row['IDTURNO'],
              'NMTURNO' => $row['NMTURNO'],
              'DSATIVIDADE' => $row['DSATIVIDADE'],
            ];
          }
          unset($row['IDTURNO']);
          unset($row['NMTURNO']);
          unset($row['DSATIVIDADE']);
        }
        return ResponseHandler::success($response, [
          'data' => $data,
        ]);
      } catch (\Exception $err) {
        return ResponseHandler::error($response, $err);
      }
    }
}