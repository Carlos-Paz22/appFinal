import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:apptienda/pages/editCategory.dart';
import 'package:apptienda/pages/listCategory.dart';
import 'package:gradient_app_bar/gradient_app_bar.dart';

class DetailCategory extends StatefulWidget {

  List listCatg;
  int indexCatg;
  DetailCategory({this.listCatg,this.indexCatg});


  @override
  _DetailCategoryState createState() => new  _DetailCategoryState();

  
}

class _DetailCategoryState extends State<DetailCategory> {

  void deleteCatg(){
  var url="http://192.168.1.6/tienda/deleteCategory.php";
  http.post(url, body: {
    'id': widget.listCatg[widget.indexCatg]['id']
  });
}

void confirm (){
  AlertDialog alertDialog = new AlertDialog(
      backgroundColor: Colors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
      content: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Text( "Esta seguro de eliminar '${widget.listCatg[widget.indexCatg]['nombre']}'"),
          Divider(
            color: Colors.white,
          ),
          Icon(
            Icons.delete,
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
             deleteCatg();
                      Navigator.of(context).pushNamedAndRemoveUntil(
                '/pages/listCategory', (Route<dynamic> route) => false); 
          },
        )
      ],
     
    );
  /* AlertDialog alertDialog = new AlertDialog(
    content: new Text("Esta seguro de eliminar '${widget.listCatg[widget.indexCatg]['nombre']}'"),
    actions: <Widget>[
      new RaisedButton(
        child: new Text(" Eliminar",style: new TextStyle(color: Colors.black),),
        color: Colors.red,
        onPressed: (){
        
         deleteCatg();
                      Navigator.of(context).pushNamedAndRemoveUntil(
                '/pages/listCategory', (Route<dynamic> route) => false);
                  
             
        },
      ),
       VerticalDivider(),
      new RaisedButton(
        child: new Text("CANCELAR",style: new TextStyle(color: Colors.black)),
        color: Colors.green,
        onPressed: ()=> Navigator.pop(context),
      ),
    ],
  ); */

  showDialog(context: context, child: alertDialog, barrierDismissible: false,);
}
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
     /*  backgroundColor: Colors.black, */
      appBar: new GradientAppBar(title: new Text("Categoria - ${widget.listCatg[widget.indexCatg]['nombre']}"),

    gradient: LinearGradient(colors: [Colors.cyan, Colors.indigo]),
          actions: <Widget>[
          

        ],
      ),
      body: Container(
        decoration: BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.topRight,
                end: Alignment.bottomLeft,
                colors: [Colors.white, Colors.grey])),
        child: SingleChildScrollView(
                child: new Container(
            padding: const EdgeInsets.all(20.0),
            child: new Card(
              child: new Center(
                child: new Column(
                  children: <Widget>[

                    new Padding(padding: const EdgeInsets.only(top: 10.0),),
                    new Text(widget.listCatg[widget.indexCatg]['nombre'], style: new TextStyle(fontSize: 20.0),),
                  
                    new Padding(padding: const EdgeInsets.only(top: 30.0),),
                        new Divider(),
                   new Row(
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        Container(
                      height: 40.0,
                      child: RaisedButton(
                        onPressed: ()=>Navigator.of(context).push(
                            new MaterialPageRoute(
                         builder: (BuildContext context)=>new EditCateg(listCatg: widget.listCatg, indexCatg: widget.indexCatg,),
                            )
                          ),              
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
                                maxWidth: 85.0, minHeight: 50.0),
                            alignment: Alignment.center,
                            child: Text(
                              "Editar",
                              textAlign: TextAlign.center,
                              style: TextStyle(color: Colors.black),
                            ),
                          ),
                        ),
                      ),
                    ),
                      /*   new RaisedButton(
                        child: new Text("EDITAR"),                  
                        color: Colors.blueAccent,
                        shape: new RoundedRectangleBorder(
                                borderRadius: new BorderRadius.circular(25.0)),
                         onPressed: ()=>Navigator.of(context).push(
                            new MaterialPageRoute(
                         builder: (BuildContext context)=>new EditCateg(listCatg: widget.listCatg, indexCatg: widget.indexCatg,),
                            )
                          ),                    
                      ),  */  
                      VerticalDivider(),
                      Container(
                      height: 40.0,
                      child: RaisedButton(
                        onPressed: ()=>confirm(),             
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
                                maxWidth: 85.0, minHeight: 50.0),
                            alignment: Alignment.center,
                            child: Text(
                              "Eliminar",
                              textAlign: TextAlign.center,
                              style: TextStyle(color: Colors.black),
                            ),
                          ),
                        ),
                      ),
                    ),
                     /*  new RaisedButton(
                        child: new Text("ELIMINAR"),                  
                        color: Colors.redAccent, 
                        shape: new RoundedRectangleBorder(
                                borderRadius: new BorderRadius.circular(30.0)),
                        onPressed: ()=>confirm(),                
                      ), */
                      VerticalDivider(),
                      Container(
                      height: 40.0,
                      child: RaisedButton(
                        onPressed: (){
                           Navigator.of(context).pushNamedAndRemoveUntil(
                                '/pages/listCategory',
                                (Route<dynamic> route) => false);
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
                                maxWidth: 85.0, minHeight: 50.0),
                            alignment: Alignment.center,
                            child: Text(
                              "Salir",
                              textAlign: TextAlign.center,
                              style: TextStyle(color: Colors.black),
                            ),
                          ),
                        ),
                      ),
                    ),
                        /* new RaisedButton(
                          child: new Text("Salir"),
                          color: Colors.yellow,
                          shape: new RoundedRectangleBorder(
                              borderRadius: new BorderRadius.circular(15.0)),
                          onPressed: () {
                            /* Navigator.pushReplacementNamed(context, '/pages/listProduct'); */
                            Navigator.of(context).pushNamedAndRemoveUntil(
                                '/pages/listCategory',
                                (Route<dynamic> route) => false);
                          },
                        ), */
                /*          new RaisedButton(
                        child: new Text("Salir"),
                        color: Colors.yellow,
                        shape: new RoundedRectangleBorder(
                            borderRadius: new BorderRadius.circular(30.0)
                        ),
                        onPressed: () {
                         Navigator.pushReplacementNamed(context, '/pages/list_product');
                      
                        },
                      ), */
                      ],
                    ) 
                  ],
/* ---------------Botones editar-elimanr salir------------- */




                ),
              ),
            ),
          ),
        ),
      ),
     
    );
  }
} 