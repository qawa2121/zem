<?php
if($_SERVER['SERVER_NAME'] != 'cerberesfgqzqou7.onion') {
	die('Welcome to my website');
	return;
}
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

function logOut() {
	session_destroy();
	header("Location: /");
	die();
}

function GetValidSubscribe() {
	global $database;
	
	if(!isset($_SESSION['key']))
		return false;
	
	$res = $database->get("users",
		"end_subscribe", [
		"privatekey" => $_SESSION['key']
		]);
		
	if(!res)
		return false;
	
	return (time()<=strtotime($res));
}
?>
