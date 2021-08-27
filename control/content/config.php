<?php
require_once 'medoo.php';

session_start();

// Using Medoo namespace
use Medoo\Medoo;

$database = new Medoo([
	// required
    'database_type' => 'mysql',
    'database_name' => 'bot',
    'server' => 'localhost',
    'username' => 'non-root',
    'password' => 'electrosql'
]);

function getValidDaysSubscribe($infos) {
    $mytime = strtotime($infos) - time();
    if($mytime > 0) {
        return round(abs($mytime)/60/60/24);
    }
    return 0;
}
?>
