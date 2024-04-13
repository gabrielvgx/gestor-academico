<?php

use Slim\App;

return function (App $app) {
    $app->get('/', [\App\Controller\Main::class, 'main']);
    $app->get('/teste', [\App\Controller\Main::class, 'main']);
    $app->post('/auth', [\App\Controller\Login::class, 'auth']);
};