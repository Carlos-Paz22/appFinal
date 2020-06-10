<?php

    require_once "conexion.php";
	$conexion=conexion();
	
    $nombre = $_POST['nombre'];
    $precio = $_POST['precio'];
    $descripcion = $_POST['descripcion'];
    $categoria = $_POST['id_catg_producto'];
   // $imagen=addslashes(file_get_contents($_FILES['imagen']['tmp_name']));
//Por agregar imagen

	
	
	$conexion->query("INSERT INTO productos (nombre,precio,descripcion,id_catg_producto) 
                        VALUES ('".$nombre."','".$precio."','".$descripcion."','".$categoria."')")

?>