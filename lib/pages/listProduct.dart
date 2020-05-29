import 'package:apptienda/pages/detailproduct.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:apptienda/pages/createProduct.dart';
import 'package:gradient_app_bar/gradient_app_bar.dart';

import 'dart:async';
import 'dart:convert';

class ListProduct extends StatefulWidget {
  @override
  _ListProductState createState() => _ListProductState();
}

class _ListProductState extends State<ListProduct> {
  Future<List> getProduct() async {
    final response = await http.get(
      "http://192.168.1.5/tienda/getProduct.php",
    );
    return json.decode(response.body);
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new GradientAppBar(
        gradient: LinearGradient(colors: [Colors.cyan, Colors.indigo]),
        title: new Text("Listado de productos"),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.exit_to_app),
            onPressed: () => showDialog(
                barrierDismissible: false,
                context: context,
                builder: (context) {
                  return  AboutWidget(); 
                }),
       
          ),
        ],
      ),
      floatingActionButton: new FloatingActionButton(
        child: new Icon(
          Icons.add,
          color: Colors.black,
        ),
        onPressed: () => Navigator.of(context).push(new MaterialPageRoute(
          builder: (BuildContext context) => new AddProduct(),
        )),
      ),
      body: Container(
    decoration: BoxDecoration(
  gradient: LinearGradient(
    begin: Alignment.topRight,
    end: Alignment.bottomLeft,
    colors: [Colors.white12, Colors.blueAccent])),
        child: new FutureBuilder<List>(
          
          future: getProduct(),
          builder: (context, snapshot) {
            if (snapshot.hasError) print(snapshot.error);
            return snapshot.hasData
                ? new ItemList(
                    list: snapshot.data,
                  )
                : new Center(
                    child: new CircularProgressIndicator(),
                  );
          },
        ),
      ),
    );
  }
}

class ItemList extends StatelessWidget {
  final List list;
  ItemList({this.list});

  @override
  Widget build(BuildContext context) {
    return new ListView.builder(
      itemCount: list == null ? 0 : list.length,
      itemBuilder: (context, i) {
        return new Container(
          padding: const EdgeInsets.all(10.0),
          child: new GestureDetector(
            onTap: () => Navigator.of(context).push(
              new MaterialPageRoute(
                  builder: (BuildContext context) => new Detailproduct(
                        list: list,
                        index: i,
                      )),
            ),
            child: new Card(
              child: new ListTile(
                title: new Text(
                  list[i]['nombre'],
                  style: TextStyle(fontSize: 25.0, color: Colors.black),
                ),
                leading: new Icon(
                  Icons.add_shopping_cart,
                  size: 50.0,
                  color: Colors.green,
                ),
                subtitle: new Text(
                  list[i]['descripcion'],
                  style: TextStyle(fontSize: 20.0, color: Colors.grey),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}

class AboutWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      
      child: AlertDialog(
        
        backgroundColor: Colors.blueGrey,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
        title: Text("Error"),
        content: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Text("Password / User "),
            Text(" Incorrect"),
            Icon(
              Icons.error_outline,
              color: Colors.red,
              size: 73.0,
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
              Navigator.pushReplacementNamed(context, '/pages/login');
            },
          )
        ],
      ),
    );
  }
} 
