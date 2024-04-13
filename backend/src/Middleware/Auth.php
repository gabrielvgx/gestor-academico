<?php

namespace App\Middleware;

use Slim\App;
use Tuupola\Middleware\JwtAuthentication;

class Auth {
  function register(App $app) {
    // Parse json, form data and xml
    $app->addBodyParsingMiddleware();

    // Add the Slim built-in routing middleware
    $app->addRoutingMiddleware();

    // Handle exceptions
    $app->addErrorMiddleware(true, true, true);

    $app->add(new JwtAuthentication([
        "path" => "/",
        "ignore" => ["(.+)\/login", "(.+)\/forgot-password"],
        "secret" => $_ENV["JWT_SECRET_KEY"],
        "secure" => $_ENV["DEV_MODE"] === "YES" ? false : true,
        "error" => function ($response, $arguments) {
            $data["error"] = true;
            $data["message"] = $arguments["message"];
            $data["data"] = [];

            $response->getBody()->write(
                json_encode($data, JSON_UNESCAPED_SLASHES | JSON_PRETTY_PRINT)
            );
    
            return $response->withHeader("Content-Type", "application/json");
        }
    ]));
  }
}