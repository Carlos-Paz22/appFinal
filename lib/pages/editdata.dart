import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:apptienda/pages/listUser.dart';
import 'package:gradient_app_bar/gradient_app_bar.dart';

class EditData extends StatefulWidget {
  final List list;
  final int index;

  EditData({this.index, this.list});

  @override
  _EditDataState createState() => _EditDataState();
}

class _EditDataState extends State<EditData> {
  //para la base
  TextEditingController controllerUsername;
  TextEditingController controllerPassword;
  TextEditingController controllerTelefono;
  TextEditingController controllerCiudad;
  TextEditingController controllerDireccion;
   bool _obscureText = true;
  


  void editData() {
    var url="http://192.168.1.5/tienda/editData.php";
    http.post(url,body: {
      "id": widget.list[widget.index]['id'],
      "username": controllerUsername.text,
      "password": controllerPassword.text,
      "telefono": controllerTelefono.text,
      "ciudad": controllerCiudad.text,
      "direccion": controllerDireccion.text,
      
    });
  }
 @override
void initState() {
      controllerUsername= new TextEditingController(text: widget.list[widget.index]['username'] );
      controllerPassword= new TextEditingController(text: widget.list[widget.index]['password'] );
      controllerTelefono= new TextEditingController(text: widget.list[widget.index]['telefono'] );
      controllerCiudad= new TextEditingController(text: widget.list[widget.index]['ciudad'] );
      controllerDireccion= new TextEditingController(text: widget.list[widget.index]['direccion'] );
      super.initState();
    }


  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new GradientAppBar(
        gradient: LinearGradient(colors: [Colors.cyan, Colors.indigo]),
        title: new Text("EDITAR"),
      ),
      body: Container(
         decoration: BoxDecoration(
  gradient: LinearGradient(
    begin: Alignment.topRight,
    end: Alignment.bottomLeft,
    colors: [Colors.white12, Colors.blueAccent])),
        child: Form(       
            child: ListView(
              padding: const EdgeInsets.all(10.0),
              children: <Widget>[
                new Column(
                  children: <Widget>[
                   new ListTile(
                      leading: const Icon(Icons.person, color: Colors.black),
                      title: new TextFormField(
                        controller: controllerUsername,
                            validator: (value) {
                              if (value.isEmpty) return "Ingresa un nombre de usurio";
                            },
                        decoration: new InputDecoration(
                          hintText: "Usuario", labelText: "Usuario",
                        ),
                      ),
                    ),
                    new ListTile(
                      leading: const Icon(Icons.security, color: Colors.black),
                     
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
                      leading: const Icon(Icons.call, color: Colors.black),
                      title: new TextFormField(
                        controller: controllerTelefono,
                        keyboardType: TextInputType.number,
                            validator: (value) {
                              if (value.isEmpty) return "Ingresa un Telefono";
                            },
                        decoration: new InputDecoration(
                          hintText: "Telefono", labelText: "Telefono",
                        ),
                      ),
                    ),
                    new ListTile(
                      leading: const Icon(Icons.location_on, color: Colors.black),
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
                      leading: const Icon(Icons.my_location, color: Colors.black),
                      title: new TextFormField(
                        controller: controllerDireccion,
                         
                            validator: (value) {
                              if (value.isEmpty) return "Ingresa una Direccion";
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
                      onPressed: () {
                        editData();
                        Navigator.of(context).push(
                          new MaterialPageRoute(
                            builder: (BuildContext context)=>new ListUser()
                          )
                        );
                      },
                    )
                  ],
                ),
              ],
            ),
        ),
      ),
    );
  }
  }

