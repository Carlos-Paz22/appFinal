import 'dart:convert';

import 'package:apptienda/pages/editproduct.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:apptienda/allproduct/Clase.dart';
import 'package:apptienda/pages/prueba.dart';
import 'package:http/http.dart' as http;



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


void deletProduct() {
    var url = "http://192.168.1.5/tienda/deletProduct.php";
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
             deletProduct();
            Navigator.of(context).pushNamedAndRemoveUntil(
                '/pages/list_product', (Route<dynamic> route) => false);
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
      appBar: new AppBar(title: new Text('DETALLES '),
      backgroundColor: Colors.black,
      ),
      body: new Container(
        child: new Center(
          child: Column(
            children: <Widget>[
              Padding(
                child: new Text(
                  'DETALES- PRODUCTO',
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
                  '\$ : ${widget.value.precio}',
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
    );
  }
}