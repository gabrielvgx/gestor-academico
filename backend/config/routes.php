<?php

use Slim\App;

return function (App $app) {
    $app->post('/auth', [\App\Controller\Login::class, 'auth']);
    $app->post('/forgot-password', [\App\Controller\Login::class, 'forgotPassword']);
    $app->post('/verify-otp', [\App\Controller\Login::class, 'verifyCode']);
    $app->post('/redefine-password', [\App\Controller\Login::class, 'redefinePassword']);
    $app->post('/user', [\App\Controller\User::class, 'create']);
    $app->get('/user', [\App\Controller\User::class, 'read']);
    $app->delete('/user', [\App\Controller\User::class, 'delete']);
    $app->get('/school', [\App\Controller\School::class, 'read']);
    $app->get('/school-and-class', [\App\Controller\School::class, 'readSchoolAndClass']);
    $app->get('/class', [\App\Controller\ClassController::class, 'read']);
    $app->get('/material', [\App\Controller\Material::class, 'read']);
    $app->get('/dashboard', [\App\Controller\Dashboard::class, 'getPlanning']);
    $app->get('/smtp', [\App\Controller\Login::class, 'sendOneTimePasswordMail']);
    $app->get('/notification', [\App\Controller\Notification::class, 'read']);
};