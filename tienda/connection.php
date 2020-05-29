<?php

$connect = new mysqli("localhost","root","","tienda");

if($connect){
	 
}else{
	echo "Fallo, revise ip o firewall";
	exit();
}