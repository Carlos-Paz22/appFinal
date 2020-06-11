import 'dart:convert';

import 'package:apptienda/pages/editproduct.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:apptienda/allproduct/Clase.dart';
import 'package:apptienda/pages/prueba.dart';
import 'package:http/http.dart' as http;
import 'package:gradient_app_bar/gradient_app_bar.dart';



class SecondScreen extends StatefulWidget {

  List listPrd;
  int indexProd;
  final Datos value;
  
  //SecondScreen({this.indexProd, this.listPrd, this.value});
  SecondScreen({Key key, this.value}) : super(key: key);

  @override
  _SecondScreenState createState() => _SecondScreenState();


}

class _SecondScreenState extends State<SecondScreen> {


void deleteProduct() {
    var url = "http://192.168.1.5/tienda/deleteProduct.php";
    http.post(url, body: {'id': widget.listPrd[widget.indexProd]['id']});
  }

  void confirm() {
    AlertDialog alertDialog = new AlertDialog(
      content: new Text(
          "Esta seguro de eliminar '${widget.listPrd[widget.indexProd]['nombre']}'"),
      actions: <Widget>[
        new RaisedButton(
          child: new Text(
            " Eliminar",
            style: new TextStyle(color: Colors.black),
          ),
          color: Colors.red,
          onPressed: () {
             deleteProduct();
            Navigator.of(context).pushNamedAndRemoveUntil(
                '/allproduct/ListProduct', (Route<dynamic> route) => false);
            /*  Navigator.of(context).popAndPushNamed( '/pages/list_product');
                 return  deletProduct(); */
          },
        ),
        VerticalDivider(),
        new RaisedButton(
          child:
              new Text("CANCELAR", style: new TextStyle(color: Colors.black)),
          color: Colors.green,
          onPressed: () => Navigator.pop(context),
        ),
      ],
    );

    showDialog(
      context: context,
      child: alertDialog,
      barrierDismissible: false,
    );
  }







  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new GradientAppBar(title: new Text('DETALLES '),
      gradient: LinearGradient(colors: [Colors.cyan, Colors.indigo]),
      
      ),
      body: SingleChildScrollView(
              child: new Container(
                height: 1000,

                 decoration: BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.topRight,
                end: Alignment.bottomLeft,
                colors: [Colors.white, Colors.grey])),
          child: new Center(
            child: Column(
              children: <Widget>[
                Padding(
                  child: new Text(
                    'PRODUCTO',
                    style: new TextStyle(
                        fontWeight: FontWeight.bold, fontSize: 20.0),
                    textAlign: TextAlign.center,
                  ),
                  padding: EdgeInsets.only(bottom: 20.0),
                ),
                Padding(
                  //`widget` is the current configuration. A State object's configuration
                  //is the corresponding StatefulWidget instance.
                  child: Image.network('${widget.value.imgen}'),
                  padding: EdgeInsets.all(12.0),
                ),
                Padding(
                  child: new Text(
                    'Nombre : ${widget.value.nombre}',
                    style: new TextStyle(fontWeight: FontWeight.bold),
                    textAlign: TextAlign.left,
                  ),
                  padding: EdgeInsets.all(20.0),
                ),
                Padding(
                  child: new Text(
                    '\$ Precio : ${widget.value.precio}',
                    style: new TextStyle(fontWeight: FontWeight.bold),
                    textAlign: TextAlign.left,
                  ),
                  padding: EdgeInsets.all(20.0),
                ),
                 Padding(
                  child: new Text(
                    'Descripcion : ${widget.value.descripcion}',
                    style: new TextStyle(fontWeight: FontWeight.bold),
                    textAlign: TextAlign.left,
                  ),
                  padding: EdgeInsets.all(20.0),
                ),

              new Row(
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                      
                     Container(
                      height: 40.0,
                      child: RaisedButton(
                        onPressed: () {
                          
                         
                            Navigator.of(context).pushNamedAndRemoveUntil(
                                '/allproduct/ListProduct',
                                (Route<dynamic> route) => false);
                            /* Navigator.pushReplacementNamed(context, '/pages/login'); */

                        },
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(80.0)),
                        padding: EdgeInsets.all(0.0),
                        child: Ink(
                          decoration: BoxDecoration(
                              gradient: LinearGradient(
                                colors: [Colors.indigo, Colors.pinkAccent],
                                begin: Alignment.topLeft,
                                end: Alignment.bottomLeft,
                              ),
                              borderRadius: BorderRadius.circular(10.0)),
                          child: Container(
                            constraints: BoxConstraints(
                                maxWidth: 300.0, minHeight: 50.0),
                            alignment: Alignment.center,
                            child: Text(
                              "Salir",
                              textAlign: TextAlign.center,
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                        ),
                      ),
                    ),
                        /* new RaisedButton(
                          child: new Text("EDITAR"),
                          color: Colors.blueAccent,
                          shape: new RoundedRectangleBorder(
                              borderRadius: new BorderRadius.circular(25.0)),
                          onPressed: () =>
                              Navigator.of(context).push(new MaterialPageRoute(
                            builder: (BuildContext context) => new EditProduct(
                              list: widget.listPrd,
                              index: widget.indexProd,
                            ),
                          )),
                        ),
                       Container(
                           child: _image == null ? new Text('NO hay image')
                           : new Image.file(_image),
                        
                        
                        
                        ), */
                       /*  VerticalDivider(),
                        new RaisedButton(
                          child: new Text("ELIMINAR"),
                          color: Colors.redAccent,
                          shape: new RoundedRectangleBorder(
                              borderRadius: new BorderRadius.circular(30.0)),
                          onPressed: (){
                            print('click-borrar');
                            deletProduct();
                            
                          },
                        ), 
                           VerticalDivider(),
                         new RaisedButton(
                        child: new Text("Salir"),
                        color: Colors.yellow,
                        shape: new RoundedRectangleBorder(
                            borderRadius: new BorderRadius.circular(30.0)
                        ),
                        onPressed: () {
                         Navigator.pushReplacementNamed(context, '/pages/list_product');
                      
                        },
                      ), */
                      ],
                    )


              ],
            ),
          ),
        ),
      ),
    );
  }
}