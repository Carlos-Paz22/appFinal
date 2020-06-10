/* import 'dart:io'; */

import 'package:flutter/material.dart';
import 'package:apptienda/pages/editproduct.dart';
import 'package:http/http.dart' as http;

class Detailproduct extends StatefulWidget {
  List listPrd;
  int indexProd;
  Detailproduct({this.indexProd, this.listPrd});
  @override
  _DetailproductState createState() => new _DetailproductState();
}

class _DetailproductState extends State<Detailproduct> {

  //File _image;





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
                '/pages/listProduct', (Route<dynamic> route) => false);
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
      appBar: new AppBar(
        title: new Text("${widget.listPrd[widget.indexProd]['nombre']}",textAlign: TextAlign.center,),
        actions: <Widget>[
          IconButton(
              icon: Icon(
                Icons.home,
                size: 40.0,
                color: Colors.red,
              ),
              onPressed: () {
                Navigator.of(context).pushNamedAndRemoveUntil(
                    '/pages/listProduct', (Route<dynamic> route) => false);
              })
        ],
      ),
      body: SingleChildScrollView(
        child: new Container(
          padding: const EdgeInsets.all(20.0),
          child: new Card(
            child: new Center(
              child: new Column(
                children: <Widget>[
                  new Padding(
                    padding: const EdgeInsets.only(top: 10.0),
                  ),
                  new Text('Detalles Producto'),
                  Divider(
                    color: Colors.red,
                  ),
                  new Text(
                    widget.listPrd[widget.indexProd]['nombre'],
                    style: new TextStyle(fontSize: 20.0),
                  ),
                  Divider(),
                  new Text(
                    "Precio : ${widget.listPrd[widget.indexProd]['precio']}",
                    style: new TextStyle(fontSize: 18.0, color: Colors.grey),
                  ),
                  Divider(),
                  new Text(
                    "Categoria : ${widget.listPrd[widget.indexProd]['nom_catg']}",
                    style: new TextStyle(fontSize: 18.0, color: Colors.grey),
                  ),
                  Divider(),
                  new Text(
                    "Descipcion : ${widget.listPrd[widget.indexProd]['descripcion']}",
                    style: new TextStyle(fontSize: 18.0, color: Colors.grey),
                  ),
                  Divider(),
                    new Text(
                    "Foto : ${widget.listPrd[widget.indexProd]['imagen']}",
                    style: new TextStyle(fontSize: 18.0, color: Colors.grey),
                  ),
                  Divider(),
                  new Padding(
                    padding: const EdgeInsets.only(top: 30.0),
                  ),


                  
                  new Row(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      new RaisedButton(
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
                    /*  Container(
                         child: _image == null ? new Text('NO hay image')
                         : new Image.file(_image),
                      
                      
                      
                      ),*/
                      VerticalDivider(),
                      new RaisedButton(
                        child: new Text("ELIMINAR"),
                        color: Colors.redAccent,
                        shape: new RoundedRectangleBorder(
                            borderRadius: new BorderRadius.circular(30.0)),
                        onPressed: () => confirm(),
                      ),
                      /*   VerticalDivider(),
                       new RaisedButton(
                      child: new Text("Salir"),
                      color: Colors.yellow,
                      shape: new RoundedRectangleBorder(
                          borderRadius: new BorderRadius.circular(30.0)
                      ),
                      onPressed: () {
                       Navigator.pushReplacementNamed(context, '/pages/list_product');
                    
                      },
                    ),*/
                    ],
                  )
                ],
/* ---------------Botones editar-elimanr salir------------- */
              ),
            ),
          ),
        ),
      ),
    );
    
  }



  
    /*Widget _mostrarFoto() {
    if (imageUrl != null) {
      return FadeInImage(
        image: NetworkImage(imageUrl),
        placeholder: AssetImage('assets/loading.gif'),
        fit: BoxFit.cover,
      );
    } else {
      //usamos un operador ternario para cambiar de widget en caso de no seleccionar imagen
      return Image(
        image: (_image?.path == null)
            ? AssetImage('assets/no-image.png')
            : FileImage(
                _image), //AssetImage(_image?.path ?? 'assets/no-image.png'),
        height: 300.0,
        fit: BoxFit.cover,
      );
    }
  }*/

}

/* import 'package:flutter/material.dart';
/* import 'package:apptienda/pages/listProduct.dart'; */
import './editproduct.dart';
import 'package:http/http.dart' as http;
import 'package:gradient_app_bar/gradient_app_bar.dart';

class Detailproduct extends StatefulWidget {
  List list;
  int index;
  Detailproduct({this.index, this.list});
  @override
  _DetailproductState createState() => new _DetailproductState();
}

class _DetailproductState extends State<Detailproduct> {
  void deleteProduct() {
    var url = "http://192.168.1.5/tienda/deleteProduct.php";
    http.post(url, body: {'id': widget.list[widget.index]['id']});
  }

  void confirm() {
    AlertDialog alertDialog = new AlertDialog(
      backgroundColor: Colors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
      content: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Text( "Esta seguro de eliminar '${widget.list[widget.index]['nombre']}'"),
          Divider(
            color: Colors.white,
          ),
          Icon(
            Icons.delete,
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
              deleteProduct();
            /* Navigator.pushReplacementNamed(context, '/pages/login'); */
           /*  Navigator.popAndPushNamed(context, '/pages/listProduct'); */
            Navigator.of(context).pushNamedAndRemoveUntil(
                '/pages/listProduct', (Route<dynamic> route) => false); 
          },
        )
      ],
     
    );

    showDialog(context: context, child: alertDialog, barrierDismissible: false);
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: GradientAppBar(
        title: new Text("${widget.list[widget.index]['nombre']}"),
        gradient: LinearGradient(colors: [Colors.cyan, Colors.indigo]),
      ),
      body: Container(
        decoration: BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.topRight,
                end: Alignment.bottomLeft,
                colors: [Colors.white, Colors.grey])),
        child: SingleChildScrollView(
          child: new Container(
            /*  height: 900.0,   */
            padding: const EdgeInsets.all(10.0),
            child: new Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(19.0),
                side: new BorderSide(color: Colors.blueAccent, width: 2.0),
              ),
              child: new Center(
                child: new Column(
                  children: <Widget>[
                    new Padding(
                      padding: const EdgeInsets.only(top: 30.0),
                    ),
                    Text(
                      "NOMBRE DEL PRODUCTO:",
                      style: TextStyle(color: Colors.blueAccent),
                    ),
                    new Text(
                      widget.list[widget.index]['nombre'],
                      style: new TextStyle(fontSize: 20.0),
                    ),
                    Divider(
                      color: Colors.black,
                      height: 30,
                    ),
                    Text(
                      "PRECIO DEL PRODUCTO:",
                      style: TextStyle(color: Colors.blueAccent),
                    ),
                    new Text(
                      widget.list[widget.index]['precio'],
                      style: new TextStyle(fontSize: 20.0),
                    ),
                    new Padding(
                      padding: const EdgeInsets.only(top: 30.0),
                    ),
                    Divider(
                      color: Colors.black,
                      height: 30,
                    ),
                    Text(
                      "DESCRIPCION DEL PRODUCTO:",
                      style: TextStyle(color: Colors.blueAccent),
                    ),
                    new Text(
                      widget.list[widget.index]['descripcion'],
                      style: new TextStyle(fontSize: 20.0),
                    ),
                    new Padding(
                      padding: const EdgeInsets.only(top: 30.0),
                    ),
                    Divider(
                      color: Colors.black,
                      height: 30,
                    ),
                    Text(
                      "CATEGORIA DEL PRODUCTO:",
                      style: TextStyle(color: Colors.blueAccent),
                    ),
                    new Text(
                      widget.list[widget.index]['categ'],
                      style: new TextStyle(fontSize: 20.0),
                    ),
                    new Padding(
                      padding: const EdgeInsets.only(top: 30.0),
                    ),
                    Divider(
                      color: Colors.black,
                      height: 30,
                    ),
                    new Row(
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                          Container(
                      height: 40.0,
                      child: RaisedButton(
                        onPressed: () =>
                              Navigator.of(context).push(new MaterialPageRoute(
                            builder: (BuildContext context) => new EditProduct(
                              list: widget.list,
                              index: widget.index,
                            ),
                          )),            
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(80.0)),
                        padding: EdgeInsets.all(0.0),
                        child: Ink(
                          decoration: BoxDecoration(
                              gradient: LinearGradient(
                                colors: [Colors.lightBlue, Colors.deepOrange],
                                begin: Alignment.topLeft,
                                end: Alignment.bottomLeft,
                              ),
                              borderRadius: BorderRadius.circular(10.0)),
                          child: Container(
                            constraints: BoxConstraints(
                                maxWidth: 85.0, minHeight: 50.0),
                            alignment: Alignment.center,
                            child: Text(
                              "Editar",
                              textAlign: TextAlign.center,
                              style: TextStyle(color: Colors.black),
                            ),
                          ),
                        ),
                      ),
                    ),
                      /*   new RaisedButton(
                          child: new Text("EDITAR"),
                          color: Colors.blueAccent,
                          shape: new RoundedRectangleBorder(
                              borderRadius: new BorderRadius.circular(15.0)),
                          onPressed: () =>
                              Navigator.of(context).push(new MaterialPageRoute(
                            builder: (BuildContext context) => new EditProduct(
                              list: widget.list,
                              index: widget.index,
                            ),
                          )),
                        ), */
                        VerticalDivider(),
                         Container(
                      height: 40.0,
                      child: RaisedButton(
                        onPressed: () => confirm(),           
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(80.0)),
                        padding: EdgeInsets.all(0.0),
                        child: Ink(
                          decoration: BoxDecoration(
                              gradient: LinearGradient(
                                colors: [Colors.lightBlue, Colors.deepOrange],
                                begin: Alignment.topLeft,
                                end: Alignment.bottomLeft,
                              ),
                              borderRadius: BorderRadius.circular(10.0)),
                          child: Container(
                            constraints: BoxConstraints(
                                maxWidth: 85.0, minHeight: 50.0),
                            alignment: Alignment.center,
                            child: Text(
                              "Eliminar",
                              textAlign: TextAlign.center,
                              style: TextStyle(color: Colors.black),
                            ),
                          ),
                        ),
                      ),
                    ),
                       /*  new RaisedButton(
                          child: new Text("ELIMINAR"),
                          color: Colors.redAccent,
                          shape: new RoundedRectangleBorder(
                              borderRadius: new BorderRadius.circular(15.0)),
                          onPressed: () => confirm(),
                        ), */
                        VerticalDivider(),
                           Container(
                      height: 40.0,
                      child: RaisedButton(
                        onPressed: () {
                          Navigator.of(context).pushNamedAndRemoveUntil(
                                '/pages/listProduct',
                                (Route<dynamic> route) => false);
                        },          
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(80.0)),
                        padding: EdgeInsets.all(0.0),
                        child: Ink(
                          decoration: BoxDecoration(
                              gradient: LinearGradient(
                                colors: [Colors.lightBlue, Colors.deepOrange],
                                begin: Alignment.topLeft,
                                end: Alignment.bottomLeft,
                              ),
                              borderRadius: BorderRadius.circular(10.0)),
                          child: Container(
                            constraints: BoxConstraints(
                                maxWidth: 85.0, minHeight: 50.0),
                            alignment: Alignment.center,
                            child: Text(
                              "Salir",
                              textAlign: TextAlign.center,
                              style: TextStyle(color: Colors.black),
                            ),
                          ),
                        ),
                      ),
                    ),
                      /*   new RaisedButton(
                          child: new Text("Salir"),
                          color: Colors.yellow,
                          shape: new RoundedRectangleBorder(
                              borderRadius: new BorderRadius.circular(15.0)),
                          onPressed: () {
                            /* Navigator.pushReplacementNamed(context, '/pages/listProduct'); */
                            Navigator.of(context).pushNamedAndRemoveUntil(
                                '/pages/listProduct',
                                (Route<dynamic> route) => false);
                          },
                        ), */
                      ],
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
 */