import 'package:flutter/material.dart';
import 'package:proyectof/src/pages/codigo_qr.dart';
import 'package:proyectof/src/pages/foros/encontrados.dart';
import 'package:proyectof/src/pages/foros/perdidos.dart';
import 'package:proyectof/src/pages/tips.dart';

class HomePage extends StatelessWidget {

final opciones = ['Foro Encontrados','Foro Perdidos', 'Tips Mascotas','Crear Codigo QR'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Help My Pet'),
      ),
      body: ListView(
        children: <Widget>[
          ListTile(
            title: Text('Crear codigoQR'),
            leading: Icon(Icons.fiber_new),
            trailing: Icon(Icons.keyboard_arrow_right),
            onTap: (){
              final route = MaterialPageRoute(
                builder: (context){
                  return CodigoQRPage();
                }
              );
              Navigator.push(context, route);
            },
          ),
          Divider(),
          ListTile(
            title: Text('Foro Perdidos'),
            leading: Icon(Icons.mood_bad),
            trailing: Icon(Icons.keyboard_arrow_right),
            onTap: (){
              final route = MaterialPageRoute(
                builder: (context){
                  return PerdidosPage();
                }
              );
              Navigator.push(context, route);
            },
          ),
          Divider(),
          ListTile(
            title: Text('Foro Encontrados'),
            leading: Icon(Icons.find_in_page),
            trailing: Icon(Icons.keyboard_arrow_right),
             onTap: (){
              final route = MaterialPageRoute(
                builder: (context){
                  return EncontradosPage();
                }
              );
              Navigator.push(context, route);
            },
          ),
          Divider(),
          ListTile(
            title: Text('Tips Mascotas'),
            leading: Icon(Icons.chat),
            trailing: Icon(Icons.keyboard_arrow_right),
             onTap: (){
              final route = MaterialPageRoute(
                builder: (context){
                  return TipsPage();
                }
              );
              Navigator.push(context, route);
            },
          ),
        ],
      ),
    );
  }



}
