import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'dart:convert';
import 'dart:async';

import '../main.dart';
class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController controllerUser = new TextEditingController();
  TextEditingController controllerPass = new TextEditingController();
  bool _obscureText = true;
  String mensaje = '';
  Future<List> login() async {
    final response =
        await http.post("http://192.168.1.5/tienda/login.php", body: {
      "username": controllerUser.text,
      "password": controllerPass.text,
    });

    //

    var datauser = json.decode(response.body);
    if (datauser.length == 0) {
      setState(() {
        showDialog(
            context: context,
            barrierDismissible: false,
            builder: (context) {
              return AlertDialog(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20.0)),
                title: Text("Datos erroneos"),
                content: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Text("Ingrese Password/User Correctos"),
                  
                    Icon(
                      Icons.error,
                      color: Colors.lightBlue[900],
                      size: 73.0,
                    )
                  ],
                ),
                actions: <Widget>[
                  FlatButton(
                    child: Text("Aceptar",style: TextStyle(color:Colors.lightBlue[900]),),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                  ),
                ],
              );
            });
      });
    } else {
      if (datauser[0]['estado'] == 'admin') {
        Navigator.pushReplacementNamed(context, '/pageAdmin');
      } else if (datauser[0]['estado'] == 'ventas') {
        Navigator.pushReplacementNamed(context, '/pages/listProduct');
      }

      setState(() {
        username = datauser[0]['username'];
      });
    }
    return datauser;
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: new Scaffold(
        resizeToAvoidBottomPadding: false,
        // appBar: AppBar(title: Text("Login"),),
        body: Container(
          child: Container(
            decoration: new BoxDecoration(
              image: new DecorationImage(
                  image: new AssetImage("assets/images/digital12.jpg"),
                  fit: BoxFit.cover),
            ),
            child: Column(
              children: <Widget>[
                new Container(
                  padding: EdgeInsets.only(top: 77.0),
                  child: new CircleAvatar(
                    backgroundColor: Colors.green[200],
                    child: new Image(
                      width: 135,
                      height: 135,
                      image: new AssetImage('assets/images/avatar7.png'),
                    ),
                  ),
                  width: 170.0,
                  height: 170.0,
                  decoration: BoxDecoration(shape: BoxShape.circle),
                ),
                Container(
                 
                  height: MediaQuery.of(context).size.height / 2,
                  width: MediaQuery.of(context).size.width,
                  padding: EdgeInsets.only(top: 93),
                  child: Column(
                    children: <Widget>[
                      Container(
                        width: MediaQuery.of(context).size.width / 1.2,
                        padding: EdgeInsets.only(
                            top: 4, left: 16, right: 16, bottom: 4),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(50)),
                            color: Colors.white,
                            boxShadow: [
                              BoxShadow(color: Colors.red, blurRadius: 5),
                            ]),
                        child: TextFormField(
                          controller: controllerUser,
                          decoration: InputDecoration(
                              icon: Icon(
                                Icons.email,
                                color: Colors.lightBlue[800]
                              ),
                              hintText: 'User'),
                        ),
                      ),
                      //Password
                      Container(
                        width: MediaQuery.of(context).size.width / 1.2,
                        height: 50,
                        margin: EdgeInsets.only(top: 32),
                        padding: EdgeInsets.only(
                            top: 4, left: 16, right: 16, bottom: 4),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(50)),
                            color: Colors.white,
                            boxShadow: [
                              BoxShadow(color: Colors.red, blurRadius: 5),
                            ]),
                        child: TextFormField(
                          controller: controllerPass,
                          obscureText: _obscureText,
                          decoration: InputDecoration(
                              hintText: 'Contraseña',
                              icon: Icon(Icons.security,color: Colors.lightBlue[800],),
                              suffixIcon: GestureDetector(
                                onTap: () {
                                  setState(() {
                                    _obscureText = !_obscureText;
                                  });
                                },
                                child: Icon(
                                  
                                  _obscureText
                                      ? Icons.visibility
                                      : Icons.visibility_off,
                                      color: Colors.lightBlue[800],
                                ),
                                
                              )),
                        ),
                      ),
                      Spacer(),
                      new RaisedButton(
                        child: new Text('Ingresar',style: TextStyle(color:Colors.black),),
                        color: Colors.lightBlue,
                        shape: new RoundedRectangleBorder(
                            borderRadius: new BorderRadius.circular(10.0)),
                        onPressed: () {
                          login();
                          //   Navigator.pop(context);
                        },
                      ),
                      Spacer(),
                      new RaisedButton(
                        child: new Text('Crear cuenta'),
                        color: Colors.purple[400],
                        shape: new RoundedRectangleBorder(
                            borderRadius: new BorderRadius.circular(10.0)),
                        onPressed: () {
                          Navigator.pushReplacementNamed(
                              context, '/pages/createAccount');
                        },
                      ),
                      Text(
                        mensaje,
                        style: TextStyle(fontSize: 1, color: Colors.red),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
