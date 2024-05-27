<?php
namespace App\Controller;

use App\Provider\Notification as NotificationProvider;
use App\Provider\Planning;
use App\Provider\Material;
use App\Util\ResponseHandler;
use Psr\Http\Message\ResponseInterface as Response;
use Psr\Http\Message\ServerRequestInterface as Request;

class Notification {
/*
SUPERVISOR -> Planejamentos não analisados
SUPERVISOR -> Requisição de material não analisada
*/
    private function getSupervisorNotifications($userId) {
      list ($pendingPlanning) = Planning::readQtPending([$userId]);
      list ($pendingMaterialRequest) = Material::readMaterialRequestCount([$userId]);

      $numPlanning = $pendingPlanning && isset($pendingPlanning['NUM_PLANEJAMENTO']) ? $pendingPlanning['NUM_PLANEJAMENTO'] : 0;
      $numMaterialRequest = $pendingMaterialRequest && isset($pendingMaterialRequest['NUM_MATERIAL_REQUEST']) ? $pendingMaterialRequest['NUM_MATERIAL_REQUEST'] : 0;
      return [
        'PENDING_PLANNING' => $numPlanning,
        'PENDING_MATERIAL_REQUEST' => $numMaterialRequest,
      ];
    }

    private function getTeacherNotifications($userId) {
      return NotificationProvider::readTeacherNotification($userId);
    }

    public function read(Request $request, Response $response) {
      try {
        $tokenData = $request->getAttribute('token')['data'];
        $profile = $tokenData->PROFILE;
        $userId = $tokenData->ID;
        $data = [];
        switch($profile) {
          case 'SUPERVISOR':
            $data = $this->getSupervisorNotifications($userId);
            break;
            case 'TEACHER':
            $data = $this->getTeacherNotifications($userId);
            break;
        }

        return ResponseHandler::success($response, [
          // 'data' => $result,
          'data' => $data,
        ]);
      } catch(\Exception $err) {
        return ResponseHandler::error($response, $err);
      }
    }
}