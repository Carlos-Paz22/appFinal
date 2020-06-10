import 'dart:io';
import 'package:async/async.dart';
import 'package:path/path.dart';
import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;
import 'package:apptienda/pages/listCategory.dart';

class AddProduct extends StatefulWidget {
  @override
  _AddProductState createState() => _AddProductState();
}

class _AddProductState extends State<AddProduct> {
  File _image;
  var _formKey = GlobalKey<FormState>();
  TextEditingController nombreimg = new TextEditingController();
  //---------------
  TextEditingController controllerNombre = new TextEditingController();
  TextEditingController controllerPrecio = new TextEditingController();
  TextEditingController controllerdescripcion = new TextEditingController();
  TextEditingController controllerCategoria = new TextEditingController();

  Future getImageGallery() async {
    var imgeFile = await ImagePicker.pickImage(
        source: ImageSource.gallery, maxHeight: 200.0, maxWidth: 200.0);

    setState(() {
      _image = imgeFile;
    });
  }

  Future getImageCamera() async {
    var imgeFile = await ImagePicker.pickImage(
        source: ImageSource.camera, maxHeight: 200.0, maxWidth: 200.0);
    setState(() {
      _image = imgeFile;
    });
  }

  Future upload(File imgeFile) async {
    var stream =
        new http.ByteStream(DelegatingStream.typed(imgeFile.openRead()));
    var length = await imgeFile.length();
    var uri = Uri.parse("http://192.168.1.5/tienda/image.php");

    var request = new http.MultipartRequest("POST", uri);

    var multipartFile = new http.MultipartFile("image", stream, length,
        filename: basename(imgeFile.path));

    request.fields['nombre'] = controllerNombre.text;
    request.fields['precio'] = controllerPrecio.text;
    request.fields['descripcion'] = controllerdescripcion.text;
    request.fields['id_catg_producto'] = controllerCategoria.text;
    request.files.add(multipartFile);

    var response = await request.send();
    if (response.statusCode == 200) {
      print("Image Uploaded");
    } else {
      print("Upload Failed");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: new AppBar(
                           leading: Builder(
    builder: (BuildContext context) {
      return IconButton(
        icon: const Icon(Icons.keyboard_backspace,color: Colors.red,),

          onPressed: () {
                Navigator.pushReplacementNamed(context, '/pages/view_product');
                // Navigator.of(context).pushNamedAndRemoveUntil('/pages/view_product', (Route<dynamic> route) => false);
              },
        tooltip: MaterialLocalizations.of(context).openAppDrawerTooltip,
      );
    },
  ),
          title: new Text("Agregar Producto"),
          actions: <Widget>[
            IconButton(
                icon: Icon(
                  Icons.category,
                  size: 40.0,
                  color: Colors.red,
                ),
                onPressed: () {
                  Navigator.of(context).push(new MaterialPageRoute(
                      builder: (BuildContext context) => new LisCatg()));
                  //Navigator.pushReplacementNamed(context, '/pages/listCateg');
                  //  Navigator.of(context).pushNamedAndRemoveUntil('/pages/listCateg', (Route<dynamic> route) => false);
                }),
            IconButton(
                icon: Icon(
                  Icons.add_shopping_cart,
                  size: 40.0,
                  color: Colors.red,
                ),
                onPressed: () {
                  Navigator.of(context).pushNamedAndRemoveUntil(
                      '/pages/list_product', (Route<dynamic> route) => false);
                }),
          ],
        ),
        body: Container(
            child: Form(
                key: _formKey,
                child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: ListView(children: <Widget>[
                      new Column(
                        children: <Widget>[
                          new ListTile(
                            leading: const Icon(Icons.rate_review,
                                color: Colors.black),
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
                                color: Colors.black),
                            title: new TextFormField(
                              controller: controllerPrecio,
                              validator: (value) {
                                if (value.isEmpty) return "Ingresa un precio";
                              },
                              decoration: new InputDecoration(
                                hintText: "Precio",
                                labelText: "Precio",
                              ),
                              keyboardType: TextInputType.numberWithOptions(
                                  decimal: true),
                            ),
                          ),
                          new ListTile(
                            leading: const Icon(Icons.description,
                                color: Colors.black),
                            title: new TextFormField(
                              controller: controllerdescripcion,
                              validator: (value) {
                                if (value.isEmpty)
                                  return "Ingrese una descricion de su producto";
                              },
                              decoration: new InputDecoration(
                                hintText: "Descripcion",
                                labelText: "Descripcion",
                              ),
                            ),
                          ),
                          new ListTile(
                            leading:
                                const Icon(Icons.category, color: Colors.black),
                            title: new TextFormField(
                              controller: controllerCategoria,
                              validator: (value) {
                                if (value.isEmpty)
                                  return "Ingrese una categoria";
                              },
                              decoration: new InputDecoration(
                                hintText: "Categoria",
                                labelText: "Categoria",
                              ),
                            ),
                          ),
                        /*  new Container(
                            padding: EdgeInsets.fromLTRB(18, 0, 10, 10),
                              child: DropdownButtonFormField(
                        
                        decoration: InputDecoration(
                          labelText: 'Categoria',
                          icon: Icon(
                            Icons.category,
                            color: Colors.black,
                          ),
                        ),
                      ),
                          ),*/
                          Divider(),
                          Center(
                            child: _image == null
                                ? new Text('Selecione una imagen')
                                : new Image.file(_image),
                          ),
                          Container(
                            padding: EdgeInsets.fromLTRB(75, 0, 10, 10),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: <Widget>[
                                RaisedButton(
                                  child: Icon(Icons.image,
                                  color: Colors.pink,
                                  ),
                                  onPressed: getImageGallery,
                                ),
                                VerticalDivider(),
                                RaisedButton(
                                  child: Icon(Icons.camera,color: Colors.pink,),
                                  onPressed: getImageCamera,
                                ),
                              ],
                            ),
                          ),
                          MaterialButton(
                            height: 40.0,
                            minWidth: 600.0,
                            color: Colors.greenAccent,
                            child: Text('Guardar'),
                            shape: new RoundedRectangleBorder(
                                borderRadius: new BorderRadius.circular(10.0)),
                            onPressed: () {
                              // addProduct();

                              if (_formKey.currentState.validate()) {
                                showDialog(
                                    context: context,
                                    barrierDismissible: false,
                                    builder: (context) {
                                      return AlertDialog(
                                        backgroundColor: Colors.cyanAccent[100],
                                        shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(20.0)),
                                        title: Text(
                                          "¡¡ Successfull !!",
                                          style: TextStyle(color: Colors.green),
                                          textAlign: TextAlign.center,
                                        ),
                                        content: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.stretch,
                                          mainAxisSize: MainAxisSize.min,
                                          children: <Widget>[
                                            Text(
                                              "Producto Creado Con exito!! ",
                                              textAlign: TextAlign.center,
                                            ),
                                            Divider(),
                                            Icon(
                                              Icons.add_shopping_cart,
                                              color: Colors.green,
                                              size: 73.0,
                                            )
                                          ],
                                        ),
                                        actions: <Widget>[
                                          FlatButton(
                                            child: Text(
                                              "Aceptar",
                                            ),
                                            onPressed: () {
                                              upload(_image);
                                              Navigator.of(context)
                                                  .pushNamedAndRemoveUntil(
                                                      '/allproduct/ListProduct',
                                                      (Route<dynamic> route) =>
                                                          false);
                                            },
                                          ),
                                        ],
                                      );
                                    });
                              }
                            },
                          )
                        ],
                      ),
                    ])))));
  }
}


/* import 'package:flutter/material.dart';
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
    var url = "http://192.168.1.5/tienda/addProduct.php";

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
 */