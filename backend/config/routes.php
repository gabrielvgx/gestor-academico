<?php

use Slim\App;

return function (App $app) {
    $app->post('/auth', [\App\Controller\Login::class, 'auth']);
    $app->post('/forgot-password', [\App\Controller\Login::class, 'forgotPassword']);
    $app->post('/verify-otp', [\App\Controller\Login::class, 'verifyCode']);
    $app->post('/redefine-password', [\App\Controller\Login::class, 'redefinePassword']);
    // $app->get('/smtp', [\App\Controller\Login::class, 'sendOneTimePasswordMail']);

    $app->get('/dashboard', [\App\Controller\Dashboard::class, 'getPlanning']);

    $app->post('/user', [\App\Controller\User::class, 'create']);
    $app->get('/user', [\App\Controller\User::class, 'read']);
    $app->delete('/user', [\App\Controller\User::class, 'delete']);

    $app->get('/school', [\App\Controller\School::class, 'read']);
    $app->get('/school-and-class', [\App\Controller\School::class, 'readSchoolAndClass']);

    $app->get('/class', [\App\Controller\ClassController::class, 'read']);

    $app->post('/material', [\App\Controller\Material::class, 'create']);
    $app->get('/material', [\App\Controller\Material::class, 'read']);
    $app->delete('/material', [\App\Controller\Material::class, 'delete']);

    $app->get('/notification', [\App\Controller\Notification::class, 'read']);

    $app->get('/planning', [\App\Controller\Planning::class, 'read']);
};