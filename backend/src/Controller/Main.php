<?php
namespace App\Controller;

use Psr\Http\Message\ResponseInterface as Response;
use Psr\Http\Message\ServerRequestInterface as Request;

// Use App\Service\Main as MainService;

class Main {

    // private $mainService;

    // public function __construct(MainService $mainService) {
        // $this->mainService = $mainService;
    // }

    public function main(Request $request, Response $response) {

        $data = ['teste' => 1]; //$this->mainService->main();

        $response->getBody()->write(json_encode($data));
        return $response->withHeader('Content-Type', 'application/json');
    }
}