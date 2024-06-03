<?php
namespace App\Controller;

use App\Provider\Dashboard as DashboardProvider;
use App\Util\ResponseHandler;
use Psr\Http\Message\ResponseInterface as Response;
use Psr\Http\Message\ServerRequestInterface as Request;

class Dashboard {

    public function getPlanning(Request $request, Response $response) {
      try {
        $params = $request->getQueryParams();
        $schoolId = $params['schoolId'];
        $startDate = $params['startDate'];
        $endDate = $params['endDate'];
        $result = DashboardProvider::getPlanning([$startDate, $endDate, $startDate, $endDate, $schoolId]);

        // if (!$result) {
        //   throw new \Exception('FAIL_CREATE_USER');
        // }
        $data = [
          'analytic' => [],
          'data' => [],
        ];

        foreach ($result as $row) {
          $data['analytic'][$row['STATUS']] = $data['analytic'][$row['STATUS']] ?? 0;
          $data['analytic'][$row['STATUS']]++;
          $data['data'][$row['STATUS']] = $data['data'][$row['STATUS']] ?? [];
          $data['data'][$row['STATUS']][] = $row;
        }
        return ResponseHandler::success($response, [
          'planning' => $data,
        ]);

      } catch (\Exception $err) {
        return ResponseHandler::error($response, $err);
      }
    }

    public function getFoodData(Request $request, Response $response) {
      try {
        $params = $request->getQueryParams();
        $schoolId = $params['schoolId'];
        $data = DashboardProvider::getDsbFood([$schoolId]);
        return ResponseHandler::success($response, [
          'food' => $data,
        ]);
      } catch (\Exception $err) {
        return ResponseHandler::error($response, $err);
      }
    }
}