import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class AddData extends StatefulWidget {
  @override
  _AddDataState createState() => new _AddDataState();
}

class _AddDataState extends State<AddData> {
  TextEditingController controllerUsername = new TextEditingController();
  TextEditingController controllerPassword = new TextEditingController();
  TextEditingController controllerTelefono = new TextEditingController();
  TextEditingController controllerDireccion = new TextEditingController();
  TextEditingController controllerCiudad = new TextEditingController();
  bool _obscureText = true;
  
  var _formKey = GlobalKey<FormState>();

  void addData() {
    var url = "http://192.168.1.9/tienda/addData.php";

    http.post(url, body: {
      "username": controllerUsername.text,
      "password": controllerPassword.text,
      "telefono": controllerTelefono.text,
      "ciudad": controllerCiudad.text,
      "direccion": controllerDireccion.text,
   
    });
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        backgroundColor: Colors.lightBlue[900],
        title: new Text("Crear Cuenta"),
      ),
      body: Form(
        key: _formKey,
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: ListView(
            children: <Widget>[
              new Column(
                children: <Widget>[
                  new ListTile(
                    leading: const Icon(Icons.person, color: Colors.blueAccent),
                    title: new TextFormField(
                      controller: controllerUsername,
                          validator: (value) {
                            if (value.isEmpty) return "Ingresa un nombre de usuario";
                          },
                      decoration: new InputDecoration(
                        hintText: "Usuario", labelText: "Usuario",
                      ),
                    ),
                  ),
                  new ListTile(
                    leading: const Icon(Icons.security, color: Colors.lightBlue),
                    
                    title: new TextFormField(
                      
                      controller: controllerPassword,
                        obscureText: _obscureText,
                        
                          validator: (value) {
                        
                            if (value.isEmpty) return "Ingresa una Contraseña";
                          },
                      decoration: new InputDecoration(
                        hintText: "Contraseña", labelText: "Contraseña",
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
                                
                              ),
                        
                      ),
                      
                    ),
                  ),
                  
                   new ListTile(
                    leading: const Icon(Icons.call, color: Colors.blueAccent),
                    title: new TextFormField(
                      controller: controllerTelefono,
                          validator: (value) {
                            if (value.isEmpty) return "Ingresa un Telefono";
                          },
                          keyboardType: TextInputType.number,
                      decoration: new InputDecoration(
                        hintText: "Telefono", labelText: "Telefono",
                      ),
                    ),
                  ),
                     new ListTile(
                    leading: const Icon(Icons.location_city, color: Colors.blueAccent),
                    title: new TextFormField(
                      controller: controllerCiudad,
                          validator: (value) {
                            if (value.isEmpty) return "Ingresa una Ciudad";
                          },
                      decoration: new InputDecoration(
                        hintText: "Ciudad", labelText: "Ciudad",
                      ),
                    ),
                  ),
                     new ListTile(
                    leading: const Icon(Icons.directions, color: Colors.blueAccent),
                    title: new TextFormField(
                      controller: controllerDireccion,
                          validator: (value) {
                            if (value.isEmpty) return "Ingresa una direccion";
                          },
                      decoration: new InputDecoration(
                        hintText: "Direccion", labelText: "Direccion",
                      ),
                    ),
                  ),

                    const Divider(
                    height: 1.0,
                  ),                 
                  new Padding(
                    padding: const EdgeInsets.all(10.0),
                  ),
                  new RaisedButton(
                    child: new Text("Guardar"),
                    color: Colors.blueAccent,
                    shape: new RoundedRectangleBorder(
                        borderRadius: new BorderRadius.circular(30.0)
                    ),
                    onPressed: () {
                      if(_formKey.currentState.validate()){
                        addData();
                       Navigator.pushReplacementNamed(context, '/pages/login');
                    
                  
                      }
                  
                    },
                  ),
                   new RaisedButton(
                    child: new Text("Salir"),
                    color: Colors.red,
                    shape: new RoundedRectangleBorder(
                        borderRadius: new BorderRadius.circular(30.0)
                    ),
                    onPressed: () {
                    Navigator.pushReplacementNamed(context, '/pages/login');
                  
                    },
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}