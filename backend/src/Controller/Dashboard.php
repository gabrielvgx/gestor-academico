<?php
namespace App\Controller;

use App\Provider\Dashboard as DashboardProvider;
use App\Util\ResponseHandler;
use Psr\Http\Message\ResponseInterface as Response;
use Psr\Http\Message\ServerRequestInterface as Request;
use App\Util\Mail;

class Dashboard {

    public function sendMail() {
      try {
        Mail::send();
      } catch(\Exception $err) {
        var_dump($err->getMessage());
      }
    }

    public function getPlanning(Request $request, Response $response) {
      try {
        // $params = $request->getParsedBody();
        $result = DashboardProvider::getPlanning(null, null);

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
}