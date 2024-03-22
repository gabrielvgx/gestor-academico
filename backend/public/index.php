<?php

(require __DIR__ . '/../config/bootstrap.php')->run();
/*

use Psr\Http\Message\ResponseInterface as Response;
use Psr\Http\Message\ServerRequestInterface as Request;
use Slim\Factory\AppFactory;

require __DIR__ . DIRECTORY_SEPARATOR . '..' . DIRECTORY_SEPARATOR . 'vendor' . DIRECTORY_SEPARATOR . 'autoload.php';
try {
    $app = AppFactory::create();
    $app->get('/', function (Request $request, Response $response) {
        $response->getBody()->write('<a href="/hello/world">Try /hello/world</a>');
        return $response;
    });
    $app->get('/hello/{name}', function (Request $request, Response $response, array $args) {
        $name = $args['name'];
        $response->getBody()->write("Hello, $name");
        return $response;
    });

    $app->run();
} catch(\Exception $e) {
    var_dump($e);die;
}

*/