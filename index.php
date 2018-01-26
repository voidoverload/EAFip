<?php
	$time = date("D M j G:i:s T Y");
	$ip = $_SERVER['REMOTE_ADDR'];
	$server = var_export($_SERVER, 1);
	$get = var_export($_GET, 1);
	$uri = base64_encode($_SERVER['REQUEST_URI']);
	file_put_contents('../ip_list.txt', $ip."\t".$uri."\t".$time."\n", FILE_APPEND | LOCK_EX);
?>
