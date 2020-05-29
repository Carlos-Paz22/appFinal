<?php
	include 'connection.php';
	$id=$_POST['id'];
	$connect->query("DELETE FROM productos WHERE id=".$id);

?>