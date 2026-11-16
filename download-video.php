<?php

$videoPath = __DIR__ . DIRECTORY_SEPARATOR . 'Aitzaz_Khan_Fiverr_Introduction_Narrated.mp4';

if (!is_file($videoPath) || !is_readable($videoPath)) {
    http_response_code(404);
    exit('The narrated introduction video could not be found.');
}

$fileSize = filesize($videoPath);

if ($fileSize === false) {
    http_response_code(500);
    exit('The video file size could not be determined.');
}

header('Content-Type: application/octet-stream');
header('Content-Disposition: attachment; filename="Aitzaz_Khan_Fiverr_Introduction.mp4"');
header('Content-Length: ' . $fileSize);
header('X-Content-Type-Options: nosniff');

readfile($videoPath);
