import 'package:flutter/material.dart';
/* import 'package:apptienda/pages/listCategory.dart'; */
import 'package:gradient_app_bar/gradient_app_bar.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class AddCategory extends StatefulWidget {
  @override
  _AddCategoryState createState() => _AddCategoryState();
}

class _AddCategoryState extends State<AddCategory> {
  final titulo = TextStyle(color: Colors.black, fontSize: 15.0);
  TextEditingController controllerCategoria = new TextEditingController();
  var _formKey = GlobalKey<FormState>();

  void addCategory() {
    var url = "http://192.168.1.5/tienda/addCategory.php";

    http.post(url, body: {
      "nombre": controllerCategoria.text,
    });
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new GradientAppBar(
        gradient: LinearGradient(colors: [Colors.cyan, Colors.indigo]),
        title: new Text("Agregar Categoria"),
        actions: <Widget>[],
      ),
      body: Container(
        decoration: BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.topRight,
                end: Alignment.bottomLeft,
                colors: [Colors.white, Colors.grey])),
        child: Form(
          key: _formKey,
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: ListView(
              children: <Widget>[
                new Column(
                  children: <Widget>[
                    new ListTile(
                      leading:
                          const Icon(Icons.category, color: Colors.blueAccent),
                      title: new TextFormField(
                        controller: controllerCategoria,
                        validator: (value) {
                          if (value.isEmpty) return "Ingrese una Categoria";
                        },
                        decoration: new InputDecoration(
                          hintText: "Categoria",
                          labelText: "Categoria",
                        ),
                      ),
                    ),
                    const Divider(
                      height: 1.0,
                    ),
                    new Padding(
                      padding: const EdgeInsets.all(10.0),
                    ),
                    Container(
                      height: 40.0,
                      child: RaisedButton(
                        onPressed: () {
                           if (_formKey.currentState.validate()) {
                        showDialog(
                          barrierDismissible: false,
                          context: context,
                          builder: (context) {
                            return AlertDialog(
                              backgroundColor: Colors.white,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10.0)),
                              content: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisSize: MainAxisSize.min,
                                children: <Widget>[
                                  Text("Categoria Guardado correctamente ",textAlign: TextAlign.center,),
                                  Divider(
                                    color: Colors.white,
                                  ),
                                  Icon(
                                    Icons.done,
                                    color: Colors.green,
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
                                   if (_formKey.currentState.validate()) {
                            addCategory();

                            Navigator.of(context).pushNamedAndRemoveUntil(
                                '/pages/listCategory',
                                (Route<dynamic> route) => false);
                          } 
                                  
                                  },
                                )
                              ],
                            );
                          },
                        );
                      } else {
                        print("Error");
                      }
                          /* if (_formKey.currentState.validate()) {
                          
                        addProduct();
                        
                       
                         Navigator.of(context).pushNamedAndRemoveUntil('/pages/listProduct', (Route<dynamic> route) => false);
                        
                      
                        
                         
                        } */
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
                                maxWidth: 300.0, minHeight: 50.0),
                            alignment: Alignment.center,
                            child: Text(
                              "Guardar",
                              textAlign: TextAlign.center,
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                        ),
                      ),
                    ),
                    /* Container(
                      height: 40.0,
                      child: RaisedButton(
                        onPressed: () {
                          if (_formKey.currentState.validate()) {
                            addCategory();

                            Navigator.of(context).pushNamedAndRemoveUntil(
                                '/pages/listCategory',
                                (Route<dynamic> route) => false);
                          } else {
                            print('Datos erroneso');
                          }
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
                                maxWidth: 300.0, minHeight: 50.0),
                            alignment: Alignment.center,
                            child: Text(
                              "Guardar",
                              textAlign: TextAlign.center,
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                        ),
                      ),
                    ), */
                    /*  new RaisedButton(
                      child: new Text("Guardar"),
                      color: Colors.lightGreenAccent,
                      shape: new RoundedRectangleBorder(
                          borderRadius: new BorderRadius.circular(30.0)),
                      onPressed: () {
                        if (_formKey.currentState.validate()) {
              
                               addCategory();
                             
                           Navigator.of(context)
                                            .pushNamedAndRemoveUntil(
                                                '/pages/listCategory',
                                                (Route<dynamic> route) =>
                                                    false); 
                                       
                        
                        } else {
                          print('Datos erroneso');
                        }
                      },
                    ), */
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
