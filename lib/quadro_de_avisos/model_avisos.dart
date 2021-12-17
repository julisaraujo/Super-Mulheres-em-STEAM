import 'dart:io';
import 'dart:typed_data';
import 'package:esys_flutter_share/esys_flutter_share.dart';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:photo_view/photo_view.dart';

class ModelAvisos extends StatefulWidget {
  ModelAvisos({Key key, this.titulo, this.data, this.subtitulo, this.imagem, this.link})
      : super(key: key);

  final String titulo;
  final DateTime data;
  final String subtitulo;
  final String imagem;
  final String link;

  @override
  _ModelAvisosState createState() => _ModelAvisosState();
}

class _ModelAvisosState extends State<ModelAvisos> {

  bool color = false;

  Future<Null> updated(StateSetter updateState) async {
    updateState(() {
      color =!color;
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Material(
        elevation: 10,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        child: Container(
          height: 150,
            width: 150,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                image: DecorationImage(fit: BoxFit.cover,image: NetworkImage(widget.imagem,)),
                ),
            child: Stack(
              children: [
                Positioned(
                  child: Container(
                    padding: EdgeInsets.all(5),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Color.fromARGB(250, 61, 56, 150),
                    ),
                    alignment: Alignment.center,
                    child: Text(
                      "${widget.data.day}/${widget.data.month}",
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 12,
                          color: Colors.white),
                    ),
                  ),
                  bottom: 4,
                  right: 4,
                ),
                (widget.data.isBefore(DateTime.now())) ? Positioned.fill(
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.black.withOpacity(0.6),
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Icon(
                            FlutterIcons.emoticon_sad_outline_mco,
                            size: 40,
                          color: Colors.grey,),
                          Text("Evento expirado",
                          style: TextStyle(
                            fontSize: 17,
                            fontWeight: FontWeight.w500,
                            color: Colors.grey,
                          ),)
                        ],
                      ),
                    )) : Container()
              ],
            )),
      ),
      onTap: () {
        Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => SafeArea(
              child: Scaffold(
                body: Container(
                    width:
                    MediaQuery.of(context).size.width,
                    height:
                    MediaQuery.of(context).size.height,
                    child: Stack(
                      children: [
                        Container(
                          child: PhotoView(
                              imageProvider: NetworkImage(
                                  widget.imagem)),
                        ),
                        Positioned(
                          child: Row(
                            children: [
                              Container(
                                width: 50,
                                height: 50,
                                margin: EdgeInsets.all(5),
                                decoration: BoxDecoration(
                                    color: Color.fromARGB(
                                        250, 61, 56, 150),
                                    shape: BoxShape.circle),
                                child: IconButton(
                                  icon: Icon(
                                    Icons
                                        .arrow_back_outlined,
                                    color: Colors.white,
                                  ),
                                  onPressed: () {
                                    Navigator.pop(context);
                                  },
                                ),
                              ),
                              Container(
                                width: 50,
                                height: 50,
                                margin: EdgeInsets.all(5),
                                decoration: BoxDecoration(
                                    color: Color.fromARGB(
                                        250, 61, 56, 150),
                                    shape: BoxShape.circle),
                                child: IconButton(
                                  icon: Icon(
                                    Icons.info_outline,
                                    color: Colors.white,
                                  ),
                                  onPressed: () {
                                    showModalBottomSheet(
                                        isScrollControlled:
                                        true,
                                        shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.vertical(
                                                top: Radius
                                                    .circular(
                                                    25.0))),
                                        context: context,
                                        builder: (BuildContext context) {
                                          return StatefulBuilder(
                                              builder: (context, state){
                                                return Wrap(
                                                  children: [
                                                    Padding(
                                                      padding:
                                                      EdgeInsets.all(10),
                                                      child:
                                                      Column(
                                                        mainAxisAlignment:
                                                        MainAxisAlignment.start,
                                                        children: [
                                                          Container(
                                                            child: Text(
                                                              widget.titulo,
                                                              textAlign: TextAlign.start,
                                                              style: TextStyle(color: Color.fromARGB(250, 61, 56, 150), fontWeight: FontWeight.bold, fontSize: 25),
                                                            ),
                                                            alignment: Alignment.topLeft,
                                                            margin: EdgeInsets.all(5),
                                                          ),
                                                          widget.subtitulo == "" ? Container() : Divider(
                                                            color: Color.fromARGB(250, 61, 56, 150),
                                                          ),
                                                          widget.subtitulo == "" ? Container() : Container(
                                                            height: MediaQuery.of(context).size.height * 0.25,
                                                            child: ListView(
                                                              padding: EdgeInsets.all(8.0),
                                                              children: [
                                                                Container(
                                                                  alignment: Alignment.topLeft,
                                                                  child: SelectableText(
                                                                    widget.subtitulo,
                                                                    textAlign: TextAlign.start,
                                                                    style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 15),
                                                                  ),
                                                                ),
                                                                SizedBox(
                                                                  height: 10,
                                                                ),
                                                              ],
                                                            ),
                                                          ),
                                                          widget.link == "" ? Container() : Divider(
                                                            color: Color.fromARGB(250, 61, 56, 150),
                                                          ),
                                                          widget.link == "" ? Container() : Padding(
                                                            padding: EdgeInsets.all(8.0),
                                                            child: Container(
                                                              decoration: BoxDecoration(
                                                                borderRadius: BorderRadius.circular(10),
                                                                color: Color.fromARGB(25, 61, 56, 150),
                                                              ),
                                                              child: Row(
                                                                children: [
                                                                  Expanded(
                                                                    child: Container(
                                                                      alignment: Alignment.topLeft,
                                                                      child: SelectableText(
                                                                        widget.link,
                                                                        textAlign: TextAlign.start,
                                                                        style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 13),
                                                                      ),
                                                                    ),
                                                                  ),
                                                                  IconButton(
                                                                    icon: Icon(Icons.copy,
                                                                      color: color == false ? Colors.grey : Color.fromARGB(250, 61, 56, 150),),
                                                                    onPressed: (){
                                                                      Clipboard.setData(ClipboardData(text: "${widget.link}"));
                                                                      updated(state);
                                                                      showDialog(
                                                                          context: context,
                                                                          builder: (context) {
                                                                            Future.delayed(Duration(milliseconds: 500), () {
                                                                              Navigator.of(context).pop(true);
                                                                            });
                                                                            return Center(
                                                                                child: Container(
                                                                                  alignment: Alignment.center,
                                                                                  width: 100.0,
                                                                                  height: 40,
                                                                                  decoration: BoxDecoration(
                                                                                    borderRadius: BorderRadius.circular(10),
                                                                                    color: Colors.black,
                                                                                  ),
                                                                                  child: Text("Link copiado",
                                                                                  style: TextStyle(
                                                                                    color: Colors.white,
                                                                                    fontWeight: FontWeight.bold,
                                                                                    fontSize: 12
                                                                                  ),),
                                                                                )
                                                                            );
                                                                          }
                                                                      );
                                                                    },
                                                                  )
                                                                ],
                                                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                              ),
                                                              padding: EdgeInsets.symmetric(
                                                                horizontal: 10
                                                              ),
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    )
                                                  ],
                                                );
                                              });
                                        }
                                            );
                                  },
                                ),
                              ),
                              Container(
                                width: 50,
                                height: 50,
                                margin: EdgeInsets.all(5),
                                decoration: BoxDecoration(
                                    color: Color.fromARGB(
                                        250, 61, 56, 150),
                                    shape: BoxShape.circle),
                                child: IconButton(
                                  icon: Icon(
                                    Icons.share,
                                    color: Colors.white,
                                  ),
                                  onPressed: () async {
                                    try {
                                      var request =
                                      await HttpClient()
                                          .getUrl(Uri.parse(
                                          widget.imagem));
                                      var response =
                                      await request
                                          .close();
                                      Uint8List bytes =
                                      await consolidateHttpClientResponseBytes(
                                          response);
                                      await Share.file(
                                          '${DateTime.now()}',
                                          '${DateTime.now()}.jpg',
                                          bytes,
                                          '${DateTime.now()}/jpg');
                                    } catch (e) {
                                      print('error: $e');
                                    }
                                  },
                                ),
                              ),
                            ],
                          ),
                          top: 5,
                          left: 5,
                        ),
                      ],
                    )),
              ),
            )));
      },
    );
  }
}
