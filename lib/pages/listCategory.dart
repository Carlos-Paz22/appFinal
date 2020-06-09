import 'dart:convert';
import 'package:http/http.dart' as http;

import 'package:flutter/material.dart';
import 'package:apptienda/pages/dropdownCategory.dart';
import 'package:apptienda/pages/createCategory.dart';
import 'package:apptienda/pages/detailCategory.dart';
import 'package:apptienda/pages/editCategory.dart';
import 'package:gradient_app_bar/gradient_app_bar.dart';

class LisCatg extends StatefulWidget {
  @override
  _LisCatgState createState() => _LisCatgState();
}

class _LisCatgState extends State<LisCatg> {
  Future<List> getCateg() async {
    final response = await http.get(
      "http://192.168.1.6/tienda/getCategory.php",
    );
    return json.decode(response.body);
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new GradientAppBar(
              gradient: LinearGradient(colors: [Colors.cyan, Colors.indigo]),
        title: new Text("Listado de Categorias"),
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
        onPressed:(){
           /* Navigator.of(context).pushNamed('/pages/createProduct'); */
            Navigator.push(
              context, 
              MaterialPageRoute(builder: (context) => AddCategory()),
            ); 
           /* Navigator.of(context).pushNamedAndRemoveUntil('/pages/createProduct', (Route<dynamic> route) => false);  */
        }
        
         /* () => Navigator.of(context).push(new MaterialPageRoute(
          builder: (BuildContext context) => new AddProduct(),

        )),  */
      ),
      body: new RefreshIndicator(
              child: Container(
          decoration: BoxDecoration(
              gradient: LinearGradient(
                  begin: Alignment.topRight,
                  end: Alignment.bottomLeft,
                  colors: [Colors.white, Colors.grey])),
          child: new FutureBuilder<List>(
            future: getCateg(),
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
         onRefresh: _handleRefresh,
               ),
             );
           }
      /* floatingActionButton: new FloatingActionButton.extended(
        onPressed: () => Navigator.of(context).push(new MaterialPageRoute(
          //Crear categorias con el boron
          // builder: (BuildContext context) => new AddCatg(),
          builder: (BuildContext context) => new LandingScreen(),
        )),
        icon: new Icon(Icons.add),
        label: const Text("Agregar categorias"),
        backgroundColor: Colors.green,
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
      bottomNavigationBar: BottomAppBar(
        clipBehavior: Clip.antiAlias,
        child: Material(
            child: SizedBox(
              width: double.infinity,
              height: 40.0,
            ),
            color: Colors.black),
      ),
      body: RefreshIndicator(
        child: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.topRight,
                end: Alignment.bottomLeft,
                colors: [Colors.white, Colors.grey])),
          child: new FutureBuilder<List>(
            future: getCateg(),
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
        onRefresh: _handleRefresh,
      ),
    );
  } */
       Future<Null> _handleRefresh() async {
    await new Future.delayed(new Duration(seconds: 1));

    setState(() {
       LisCatg();
      AddCategory();
      DetailCategory();
      EditCateg();

    });

    return null;
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
                  builder: (BuildContext context) => new DetailCategory(
                        //Detalles de las categorias
                        listCatg: list,
                        indexCatg: i,
                      )),
            ),
            child: new Card(
               shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(19.0),
                side: new BorderSide(color: Colors.blueAccent, width: 2.0),
              ),
              child: new ListTile(
                title: new Text(
                  list[i]['nombre'],
                  style: TextStyle(fontSize: 25.0, color: Colors.black),
                ),
                leading: new Icon(
                  Icons.category,
                  size: 50.0,
                  color: Colors.blueAccent,
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
