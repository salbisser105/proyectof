
import 'dart:io';
import 'dart:typed_data';
import 'dart:ui';
import 'dart:async';



import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:qr/qr.dart';
import 'package:qr_flutter/qr_flutter.dart';
//import 'package:path_provider/path_provider.dart';


class CodigoQRPage extends StatefulWidget {
@override
_CodigoQRPageState createState() => _CodigoQRPageState();
}

class _CodigoQRPageState extends State <CodigoQRPage> {

  static const double _topSectionTopPading = 50.0;
  static const double _topSectionBottomPadding = 20.0;
  static const double _topSectionHeight = 50.0;


  GlobalKey globalKey = new GlobalKey();
  String _dataString = "Crea tu codigo!";
  String _inputErrorText;
  final TextEditingController _textController =  TextEditingController();
  
     @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Codigo QR"),
      ),

            
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.home),
        onPressed: (){
          Navigator.pop(context);
        },
      ),
      /*actions: <Widget> [
      IconButton(
      icon: Icon(Icons.share),
      onPressed: _captureAndSharePng,
      )
      ],*/
    body: _contentWidget(),
    );
  }
 Future<void> _captureAndSharePng() async {
    try {
      RenderRepaintBoundary boundary = globalKey.currentContext.findRenderObject();
      var image = await boundary.toImage();
      ByteData byteData = await image.toByteData(format: ImageByteFormat.png);
      Uint8List pngBytes = byteData.buffer.asUint8List();

      final tempDir = await getTemporaryDirectory();
            final file = await new File('${tempDir.path}/image.png').create();
            await file.writeAsBytes(pngBytes);
      
            final channel = const MethodChannel('channel:me.alfian.share/share');
            channel.invokeMethod('shareFile', 'image.png');
      
          } catch(e) {
            print(e.toString());
          }
       }
       
        _contentWidget() {
          final bodyHeight = MediaQuery.of(context).size.height - MediaQuery.of(context).viewInsets.bottom;
          return  Container(
            color: const Color(0xFFFFFFFF),
            child:  Column(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(
                    top: _topSectionTopPading,
                    left: 20.0,
                    right: 10.0,
                    bottom: _topSectionBottomPadding,
                  ),
                  child:  Container(
                    height: _topSectionHeight,
                    child:  Row(
                      mainAxisSize: MainAxisSize.max,
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: <Widget>[
                        Expanded(
                          child:  TextField(
                            controller: _textController,
                            decoration:  InputDecoration(
                              hintText: "Enter a custom message",
                              errorText: _inputErrorText,
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 10.0),
                          child:  FlatButton(
                            child:  Text("SUBMIT"),
                            onPressed: () {
                              setState((){
                                _dataString = _textController.text;
                                _inputErrorText = null;
                              });
                            },
                          ),
                        )
                      ],
                    ),
                  ),
                ),
                Expanded(
                  child:  Center(
                    child: RepaintBoundary(
                      key: globalKey,
                      child: QrImage(
                        data: _dataString,
                        size: 0.5 * bodyHeight,
                        onError: (ex) {
                          print("[QR] ERROR - $ex");
                          setState((){
                            _inputErrorText = "Error! Maybe your input value is too long?";
                          });
                        },
                      ),
                    ),
                  ),
                ),
              ],
            ),
          );
        }
      
        getTemporaryDirectory() {}
       Widget _crearBotones() {
         return Row(children: <Widget>[
           FloatingActionButton(
        child: Icon(Icons.home),
        onPressed: (){
          Navigator.pop(context);
        },
      ),
      FloatingActionButton(
        child: Icon(Icons.share),
        onPressed: (){
          _captureAndSharePng();
        },
      )
         ],
         );          
        }
}

