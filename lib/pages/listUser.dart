import 'package:apptienda/pages/createAccount.dart';
import 'package:apptienda/pages/editdata.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:apptienda/pages/detailUser.dart';
import 'dart:async';
import 'dart:convert';
import 'package:gradient_app_bar/gradient_app_bar.dart';


class ListUser extends StatefulWidget {
  @override
  _ListUserState createState() => _ListUserState();
}

class _ListUserState extends State<ListUser> {


  Future<List> getData() async{
    final response = await http.get("http://192.168.1.6/tienda/getData.php",);
    return json.decode(response.body);

   
  }



  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new GradientAppBar(
        gradient: LinearGradient(colors: [Colors.cyan, Colors.indigo]),
        title: new Text("Listado Usuarios"),
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
       /*  actions: <Widget>[
          IconButton(icon:Icon(Icons.search), onPressed:(){})

        ], */
      ),
     /*  floatingActionButton: new FloatingActionButton(
        child: new Icon(
          Icons.add ,
          color: Colors.black,
           ),
        onPressed: () => Navigator.of(context).push(new MaterialPageRoute(
             builder: (BuildContext context) => new AddData(),
            )),
      ),  */
      

      body: new RefreshIndicator(
              child: Container(
               decoration: BoxDecoration(
  gradient: LinearGradient(
    begin: Alignment.topRight,
    end: Alignment.bottomLeft,
    colors: [Colors.white, Colors.grey])),
          child: new FutureBuilder<List>(
            future: getData(),
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
   Future<Null> _handleRefresh() async {
    await new Future.delayed(new Duration(seconds: 1));

    setState(() {
       ListUser();
       EditData();
       Detail();
       AddData();

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
                      builder: (BuildContext context) => new Detail(
                            list: list,
                            index: i,
                          )
                          ),
                ),
            child: new Card(
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(19.0),
              side: new BorderSide(color: Colors.blueAccent, width: 2.0),
              
              ),
                 
              child: new ListTile(
                title: new Text(
                  list[i]['username'],
                  style: TextStyle(fontSize: 25.0, color: Colors.black),
                ),
                leading: new Icon(
                  Icons.person_outline,
                  size: 60.0,
                  color: Colors.blueAccent,
                ),
                subtitle: new Text(
                  "Telefono : ${list[i]['telefono']}",
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
        backgroundColor: Colors.white,
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
        content: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Text("¿Desea salir de la sesion? "),
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
