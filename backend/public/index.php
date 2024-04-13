<?php

try {
    (require __DIR__ . '/../config/bootstrap.php')->run();
} catch (\Exception $err) {
    var_dump($err->getMessage());die;
}