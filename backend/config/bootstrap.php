<?php
// use DI\ContainerBuilder;
// use Slim\App;
use Slim\Factory\AppFactory;

error_reporting(E_ALL);
// ini_set('memory_limit', '512M');
// set_time_limit(1800);


header("Access-Control-Allow-Origin: *");
header("Access-Control-Allow-Headers: *");
header("Access-Control-Allow-Methods: *");

require_once __DIR__ . '/../vendor/autoload.php';

$dotenv = Dotenv\Dotenv::createImmutable(__DIR__ . '/../');
$dotenv->load();
$app = AppFactory::create();

$app->addBodyParsingMiddleware();

$appPath = DIRECTORY_SEPARATOR . basename(dirname(__DIR__, 1)). DIRECTORY_SEPARATOR . 'public';
$appPath = str_replace("\\", "/", $appPath);

$app->setBasePath((function () {
  $uri = $_SERVER['REQUEST_URI'];

  if (stripos($uri, $_SERVER['SCRIPT_NAME']) === 0) {
      return $_SERVER['SCRIPT_NAME'];
  }

  $scriptDir = str_replace('\\', '/', dirname($_SERVER['SCRIPT_NAME']));

  if ($scriptDir !== '/' && stripos($uri, $scriptDir) === 0) {
      return $scriptDir;
  }
  return '';
})());

// Register routes
$auth = new \App\Middleware\Auth();
$auth->register($app);
(require __DIR__ . '/routes.php')($app);


// Register middleware
// (require __DIR__ . '/middleware.php')($app);

return $app;