<?php

    
	require_once "conexion.php";
	$conexion=conexion();
   

	
    $categoria = $_POST['nombre'];
    
    if(buscaRepetido($categoria,$conexion)==1){
       echo "Categoria existente!!!";
       echo json_encode("errrorrr");
    }else{
        $sql="INSERT INTO categoria (nombre)VALUES ('".$categoria."')";
        echo $result=mysqli_query($conexion,$sql);
    }
   
    

   //Funcion para validacion de datos repetidos
   function buscaRepetido($categoria,$conexion){
    $sql="SELECT * from categoria  where nombre='$categoria'";
    $result=mysqli_query($conexion,$sql);

    if(mysqli_num_rows($result) > 0){
        return 1;
    }else{
        return 0;
    }
}
  
    


   

?>