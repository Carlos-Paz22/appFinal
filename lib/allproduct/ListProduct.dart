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
        appBar: new AppBar(
                  leading: Builder(
    builder: (BuildContext context) {
      return IconButton(
        icon: const Icon(Icons.keyboard_backspace,color: Colors.red,),

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
              icon: Icon(
                Icons.home,
                size: 40.0,
                color: Colors.red,
              ),
              onPressed: () {
                Navigator.of(context).pushNamedAndRemoveUntil(
                    '/pages/viewProduct', (Route<dynamic> route) => false);
              })
        ],
      ),
       floatingActionButton: new FloatingActionButton(
        child: new Icon(
          Icons.add,
          color: Colors.redAccent,
        ),
        backgroundColor: Colors.greenAccent,
        onPressed: () => Navigator.of(context).push(new MaterialPageRoute(
          builder: (BuildContext context) => new AddProduct(),
        )),
      ),
       floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: BottomAppBar(
        clipBehavior: Clip.antiAlias,
        child: Material(
            child: SizedBox(
              width: double.infinity,
              height: 50.0,
            ),
            color: Colors.black),
      ),
        body: new RefreshIndicator(
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
        
      
    );
  }
  }
