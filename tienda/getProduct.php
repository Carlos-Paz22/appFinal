<?php
  require_once "conexion.php";
  $conexion=conexion();
  

$queryResult=$conexion->query("SELECT  p.id,p.nombre,p.precio,p.descripcion,p.imagen,categoria.nombre  AS categ FROM productos AS p
INNER JOIN categoria ON categoria.id = p.id_catg_producto");

$result=array();

while($fetchData=$queryResult->fetch_assoc()){
	$result[]=$fetchData;
}

echo json_encode($result);

?>