<?php

     include 'connection.php';
	
	$id = $_POST['id'];
	$nombre = $_POST['nombre'];
	$precio = $_POST['precio'];
	$descripcion = $_POST['descripcion'];
  	$categoria = $_POST['categoria']; 
	

	
	$connect->query("UPDATE productos SET nombre='".$nombre."', precio='".$precio."', descripcion='".$descripcion."',categoria='".$categoria."' WHERE id=". $id);

?>