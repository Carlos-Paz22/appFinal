import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:gradient_app_bar/gradient_app_bar.dart';

class AddProduct extends StatefulWidget {
  @override
  _AddProductState createState() => new _AddProductState();
}

class _AddProductState extends State<AddProduct> {
  TextEditingController controllerNombre = new TextEditingController();
  TextEditingController controllerPrecio = new TextEditingController();
  TextEditingController controllerDescripcion = new TextEditingController();
  TextEditingController controllerCategoria = new TextEditingController();
  // TextEditingController controllerImagen = new TextEditingController();  //Por agg imagen

  var _formKey = GlobalKey<FormState>();

  void addProduct() {
    var url = "http://192.168.1.6/tienda/addProduct.php";

    http.post(url, body: {
      "nombre": controllerNombre.text,
      "precio": controllerPrecio.text,
      "descripcion": controllerDescripcion.text,
      "id_catg_producto": controllerCategoria.text,
    });
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new GradientAppBar(
        gradient: LinearGradient(colors: [Colors.cyan, Colors.indigo]),
        title: new Text("Agregar Producto"),
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
                      leading: const Icon(Icons.add_shopping_cart,
                          color: Colors.blueAccent),
                      title: new TextFormField(
                        controller: controllerNombre,
                        validator: (value) {
                          if (value.isEmpty)
                            return " Ingrese el nombre del producto ";
                        },
                        decoration: new InputDecoration(
                          hintText: "Producto",
                          labelText: "Producto",
                        ),
                      ),
                    ),
                    new ListTile(
                      leading: const Icon(Icons.monetization_on,
                          color: Colors.blueAccent),
                      title: new TextFormField(
                        controller: controllerPrecio,
                        validator: (value) {
                          if (value.isEmpty) return "Ingresa un precio";
                        },
                        keyboardType: TextInputType.number,
                        decoration: new InputDecoration(
                          hintText: "Precio",
                          labelText: "Precio",
                        ),
                      ),
                    ),
                    new ListTile(
                      leading:
                          const Icon(Icons.description, color: Colors.blueAccent),
                      title: new TextFormField(
                        controller: controllerDescripcion,
                        validator: (value) {
                          if (value.isEmpty)
                            return "Ingrese una descripcion de su producto";
                        },
                        decoration: new InputDecoration(
                          hintText: "Descripcion",
                          labelText: "Descripcion",
                        ),
                      ),
                    ),
                    new ListTile(
                      leading: const Icon(Icons.category, color: Colors.blueAccent),
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
                                  Text("Producto Guardado correctamente ",textAlign: TextAlign.center,),
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
                                    addProduct();
                        
                       
                         Navigator.of(context).pushNamedAndRemoveUntil('/pages/listProduct', (Route<dynamic> route) => false);
                        
                                  
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
                  /*   new RaisedButton(
                      child: new Text("Guardar"),
                      color: Colors.green,
                      shape: new RoundedRectangleBorder(
                          borderRadius: new BorderRadius.circular(30.0)),
                      onPressed: () {
                        if (_formKey.currentState.validate()) {
                          
                        addProduct();
                        
                       
                         Navigator.of(context).pushNamedAndRemoveUntil('/pages/listProduct', (Route<dynamic> route) => false);
                        
                      
                        
                         
                        }
                      },
                    ), */
                    Divider(),
                    Container(
                      height: 40.0,
                      child: RaisedButton(
                        onPressed: () {
                         Navigator.of(context).pushNamedAndRemoveUntil('/pages/listProduct', (Route<dynamic> route) => false);
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
                              "Salir",
                              textAlign: TextAlign.center,
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                        ),
                      ),
                    ),
                   /*  new RaisedButton(
                      child: new Text("Salir"),
                      color: Colors.red,
                      shape: new RoundedRectangleBorder(
                          borderRadius: new BorderRadius.circular(30.0)),
                      onPressed: () {
                          Navigator.of(context).pushNamedAndRemoveUntil('/pages/listProduct', (Route<dynamic> route) => false);
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
