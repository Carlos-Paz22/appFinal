<?php


require_once "conexion.php";
$conexion=conexion();


$nombre = $_POST['nombre'];
$precio = $_POST['precio'];
$descripcion = $_POST['descripcion'];
$categoria = $_POST['id_catg_producto'];
$image= $_FILES['image']['name'];
$imagePath = "img_temp/".$image; 

move_uploaded_file($_FILES['image']['tmp_name'],$imagePath);
$conexion->query(("INSERT INTO productos (img,nombre,precio,descripcion,id_catg_producto)VALUES ('".$image."','".$nombre."','".$precio."','".$descripcion."','".$categoria."')"));
?>