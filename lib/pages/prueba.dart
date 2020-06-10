/* import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:async';

import 'package:http/http.dart';
import 'package:apptienda/allproduct/ListProduct.dart';
import 'package:apptienda/allproduct/detalles.dart';
import 'package:apptienda/pages/createProduct.dart';

class Datos {
  final String id;
  final String nombre, precio, descripcion, imgen;

  Datos(
      {this.id,
      this.nombre,
      this.precio,
      this.descripcion,
      this.imgen,
      });
  factory Datos.fromJson(Map<String, dynamic> jsonData) {
    return Datos(
      id: jsonData['id'],
      nombre: jsonData['nombre'],
      precio: jsonData['precio'],
      descripcion: jsonData['descripcion'],
      imgen: "http://192.168.1.5/tienda/img_temp/" + jsonData['img'],
    );
  }
}

class CustomListView extends StatelessWidget {
  final List<Datos> spacecrafts;

  CustomListView(this.spacecrafts);

  Widget build(context) {
    return ListView.builder(
      itemCount: spacecrafts.length,
      itemBuilder: (context, int currentIndex) {
        return createViewItem(spacecrafts[currentIndex], context);
      },
    );
  }

  Widget createViewItem(Datos spacecraft, BuildContext context) {
    return new ListTile(
        title: new Card(
          elevation: 5.0,
          child: new Container(
            decoration: BoxDecoration(border: Border.all(color: Colors.redAccent)),
            padding: EdgeInsets.all(20.0),
            margin: EdgeInsets.all(20.0),
            child: Column(
              children: <Widget>[
                Padding(
                  child: Image.network(spacecraft.imgen),
                  padding: EdgeInsets.only(bottom: 8.0),
                ),
                Row(children: <Widget>[
                  Padding(
                      child: Text(
                        spacecraft.nombre,
                        style: new TextStyle(fontWeight: FontWeight.bold),
                        textAlign: TextAlign.right,
                      ),
                      padding: EdgeInsets.all(1.0)),
                  Text(" | "),
                  Padding(
                      child: Text(
                        spacecraft.precio,
                        style: new TextStyle(fontStyle: FontStyle.italic),
                        textAlign: TextAlign.right,
                      ),
                      padding: EdgeInsets.all(1.0)),
                  Padding(
                      child: Text(
                        spacecraft.descripcion,
                        style: new TextStyle(fontStyle: FontStyle.italic),
                        textAlign: TextAlign.right,
                      ),
                      padding: EdgeInsets.all(1.0)),
                 
                ]),
              ],
            ),
          ),
        ),
        onTap: () {
          //We start by creating a Page Route.
          //A MaterialPageRoute is a modal route that replaces the entire
          //screen with a platform-adaptive transition.
          var route = new MaterialPageRoute(
            builder: (BuildContext context) =>
                new SecondScreen(value: spacecraft),
          );
          //A Navigator is a widget that manages a set of child widgets with
          //stack discipline.It allows us navigate pages.
          Navigator.of(context).push(route);
        });
  }
}

//Future is n object representing a delayed computation.
Future<List<Datos>> downloadJSON() async {
  final jsonEndpoint = "http://192.168.1.5/tienda/prueba.php";
 

  final response = await get(jsonEndpoint);

  if (response.statusCode == 200) {
    List spacecrafts = json.decode(response.body);
    return spacecrafts
        .map((spacecraft) => new Datos.fromJson(spacecraft))
        .toList();
  } else
    throw Exception('We were not able to successfully download the json data.');
}

class SecondScreen extends StatefulWidget {
  final Datos value;

  SecondScreen({Key key, this.value}) : super(key: key);

  @override
  _SecondScreenState createState() => _SecondScreenState();
}

class _SecondScreenState extends State<SecondScreen> {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(title: new Text('Detail Page')),
      body: new Container(
        child: new Center(
          child: Column(
            children: <Widget>[
              Padding(
                child: new Text(
                  'SPACECRAFT DETAILS',
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
                  'Precio : ${widget.value.precio}',
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
              )
            ],
          ),
        ),
      ),
    );
  }
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
       debugShowCheckedModeBanner: false,
      theme: new ThemeData(
        primarySwatch: Colors.deepOrange,
      ),
      home: new Scaffold(
        appBar: new AppBar(title: const Text('Listado Productos'),
        actions: <Widget>[
        IconButton(
              icon: Icon(
                Icons.home,
                size: 40.0,
                color: Colors.black,
              ),
              onPressed: () {
                Navigator.of(context).pushNamedAndRemoveUntil(
                    '/pages/viewProduct', (Route<dynamic> route) => false);
              })
        ],
        ),
        body: new Center(
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
        ),
      ),
    );
  }
}

 */