import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:apptienda/allproduct/Clase.dart';
import 'package:apptienda/allproduct/Edicion.dart';
import 'package:apptienda/pages/createProduct.dart';
import 'package:apptienda/pages/detailproduct.dart';
import 'package:apptienda/pages/editProduct.dart';
import 'package:apptienda/pages/listProduct.dart';
import 'package:apptienda/pages/prueba.dart';
import 'package:gradient_app_bar/gradient_app_bar.dart';










class Listado extends StatefulWidget {
  @override
  _ListadoState createState() => _ListadoState();
}

class _ListadoState extends State<Listado> {



  //
  Future<List<Datos>> downloadJSON() async {
  final jsonEndpoint = "http://192.168.1.5/tienda/prueba.php";
 

  final response = await get(jsonEndpoint);

  if (response.statusCode == 200) {
    List dataproductos = json.decode(response.body);
    return dataproductos
        .map((spacecraft) => new Datos.fromJson(spacecraft))
        .toList();
  } else
    throw Exception('We were not able to successfully download the json data.');
}
  //

  //Refresh
  Future<Null> refreshList() async {
    await Future.delayed(Duration(seconds: 2));

    setState(() {
      ListProduct();
      AddProduct();
      Detailproduct();
      EditProduct();
    });
    return null;
  }
//
  @override
  Widget build(BuildContext context) {
      return Scaffold(
        appBar: new GradientAppBar(
          gradient: LinearGradient(colors: [Colors.cyan, Colors.indigo]),
                  leading: Builder(
    builder: (BuildContext context) {
      return IconButton(
        icon: const Icon(Icons.keyboard_backspace,color: Colors.white,),

          onPressed: () {
                Navigator.pushReplacementNamed(context, '/pages/viewProduct');
                // Navigator.of(context).pushNamedAndRemoveUntil('/pages/view_product', (Route<dynamic> route) => false);
              },
        tooltip: MaterialLocalizations.of(context).openAppDrawerTooltip,
      );
    },
  ),
        title: new Text("Listado de Productos"),
        actions: <Widget>[
               IconButton(
            icon: Icon(Icons.exit_to_app),
            onPressed: () => showDialog(
                barrierDismissible: false,
                context: context,
                builder: (context) {
                  return AboutWidget();
                }),
          ),
        ],
      ),
       floatingActionButton: new FloatingActionButton(
        child: new Icon(
          Icons.add,
          color: Colors.black,
        ),
        backgroundColor: Colors.blueAccent,
        onPressed:(){
           Navigator.of(context).pushNamedAndRemoveUntil('/pages/createProduct', (Route<dynamic> route) => false);
        } /* () => Navigator.of(context).push(new MaterialPageRoute(
          builder: (BuildContext context) => new AddProduct(),
          
        )), */
      ),
     
        body: Container(
           decoration: BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.topRight,
                end: Alignment.bottomLeft,
                colors: [Colors.white, Colors.grey])),
          child: new RefreshIndicator(
            //FutureBuilder is a widget that builds itself based on the latest snapshot
            // of interaction with a Future.
            child: new FutureBuilder<List<Datos>>(
              future: downloadJSON(),
              //we pass a BuildContext and an AsyncSnapshot object which is an
              //Immutable representation of the most recent interaction with
              //an asynchronous computation.
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  List<Datos> spacecrafts = snapshot.data;
                  return new CustomListView(spacecrafts);
                } else if (snapshot.hasError) {
                  return Text('${snapshot.error}');
                }
                //return  a circular progress indicator.
                return new CircularProgressIndicator();
              },
            ),
             onRefresh: refreshList, //Refresh
          ),
        ),
        
      
    );
  }
  }

class AboutWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: AlertDialog(
        backgroundColor: Colors.white,
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
        content: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Text("¿Desea salir de la sesion? "),
             Divider(
              color: Colors.white,
            ),
            Icon(
              Icons.highlight_off,
              color: Colors.red,
              size: 50.0,
            )
          ],
        ),
        actions: <Widget>[
          FlatButton(
            child: Text("Cancelar"),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
          FlatButton(
            child: Text("Aceptar"),
            onPressed: () {
              /* Navigator.pushReplacementNamed(context, '/pages/login'); */
              Navigator.of(context).pushNamedAndRemoveUntil('/pages/login', (Route<dynamic> route) => false);
            },
          )
        ],
      ),
    );
  }
}
