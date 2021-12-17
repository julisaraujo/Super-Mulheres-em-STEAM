import 'dart:io';
import 'dart:typed_data';
import 'package:esys_flutter_share/esys_flutter_share.dart';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';

class ModelArtigos extends StatefulWidget {
  ModelArtigos({Key key, this.titulo, this.resumo, this.autores, this.link})
      : super(key: key);

  final String titulo;
  final String resumo;
  final String autores;
  final String link;

  @override
  _ModelArtigosState createState() => _ModelArtigosState();
}

class _ModelArtigosState extends State<ModelArtigos> {

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(10),
      child: Material(
        elevation: 5,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        child: Container(
            padding: EdgeInsets.all(10),
            height: 300,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              border:
              Border.all(color: Color.fromARGB(250, 61, 56, 150), width: 2),
            ),
            child: Column(
              children: [
                Container(
                  child: Text(
                    widget.titulo,
                    textAlign: TextAlign.start,
                    style: TextStyle(
                        color: Color.fromARGB(250, 61, 56, 150),
                        fontWeight: FontWeight.bold,
                        fontSize: 17),
                    maxLines: 3,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Container(
                    child: Expanded(
                      child: Text(
                        widget.resumo,
                        textAlign: TextAlign.justify,
                        style: TextStyle(
                          color: Colors.black.withOpacity(0.7),
                          fontSize: 13,
                        ),
                        maxLines: 6,
                        overflow: TextOverflow.ellipsis,
                      ),
                    )),
                SizedBox(
                  height: 5,
                ),
                Container(
                    alignment: Alignment.centerLeft,
                    child: RichText(
                      maxLines: 3,
                      overflow: TextOverflow.ellipsis,
                      text: TextSpan(
                          text: "Autor: ",
                          style: TextStyle(
                            color: Colors.black.withOpacity(0.7),
                            fontSize: 12,
                          ),
                          children: <TextSpan>[
                            TextSpan(
                                text: widget.autores,
                                style: TextStyle(
                                  color: Colors.black.withOpacity(0.7),
                                  fontWeight: FontWeight.bold,
                                  fontSize: 12,
                                ))
                          ]),
                    )),
                SizedBox(
                  height: 10,
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width,
                  child: ElevatedButton(
                    child: Padding(
                      padding: EdgeInsets.all(5),
                      child: Text("Quer ter acesso a esse artigo na íntegra?\nClique aqui para baixar",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold
                        ),),
                    ),
                    style: ButtonStyle(
                        backgroundColor:
                        MaterialStateProperty
                            .all<Color>(
                            Color.fromARGB(
                                250,
                                61,
                                56,
                                150)),
                        shape: MaterialStateProperty
                            .all<RoundedRectangleBorder>(
                            RoundedRectangleBorder(
                              borderRadius:
                              BorderRadius.circular(
                                  18.0),
                            ))),
                    onPressed: () async {
                      try {
                        var request =
                        await HttpClient().getUrl(Uri.parse(widget.link));
                        var response = await request.close();
                        Uint8List bytes =
                        await consolidateHttpClientResponseBytes(
                            response);
                        await Share.file(
                            '${widget.titulo}',
                            '${widget.titulo}.pdf',
                            bytes,
                            '${DateTime.now()}/pdf');
                      } catch (e) {
                        print('error: $e');
                      }
                    },
                  ),
                ),
              ],
            )),
      ),
    );
  }
}
