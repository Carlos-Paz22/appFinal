<?php

include 'connection.php';
	
    $nombre = $_POST['nombre'];
    $precio = $_POST['precio'];
    $descripcion = $_POST['descripcion'];
    $categoria = $_POST['categoria']; 
   // $imagen=addslashes(file_get_contents($_FILES['imagen']['tmp_name']));
//Por agregar imagen

	
	
	$connect->query("INSERT INTO productos (nombre,precio,descripcion,categoria) 
                        VALUES ('".$nombre."','".$precio."','".$descripcion."','".$categoria."')")

?>