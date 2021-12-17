import 'dart:io';
import 'dart:typed_data';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:esys_flutter_share/esys_flutter_share.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:photo_view/photo_view.dart';

class ModelIndicacoes extends StatefulWidget {

  ModelIndicacoes({Key key, this.titulo, this.subtitulo, this.imagem, this.tipo, this.like, this.nota, this.link})
      : super(key: key);

  final String titulo;
  final String subtitulo;
  final String imagem;
  final String tipo;
  final Widget like;
  final Widget nota;
  final String link;

  @override
  _ModelIndicacoesState createState() => _ModelIndicacoesState();
}

class _ModelIndicacoesState extends State<ModelIndicacoes> {

  IconData icone;

  @override
  void initState() {
    super.initState();
    this._icones();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: 10,
          vertical: 5
        ),
        child: Material(
          elevation: 14,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          child: Container(
            height: 160,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: Colors.white,
            ),
            child: Row(
              children: [
                Container(
                  width: MediaQuery.of(context).size.width * 0.675,
                  padding: EdgeInsets.all(10),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Icon(
                            icone,
                            size: 15,
                            color: Colors.black.withOpacity(0.5),
                          ),
                          SizedBox(
                            width: 3,
                          ),
                          Text(
                            widget.tipo,
                            style: TextStyle(
                                color: Colors.black.withOpacity(0.5),
                                fontWeight: FontWeight.bold,
                                fontSize: 12),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      AutoSizeText(
                        widget.titulo,
                        textAlign: TextAlign.start,
                        overflow: TextOverflow.ellipsis,
                        maxLines: 3,
                        style: TextStyle(
                            color: Color.fromARGB(250, 61, 56, 150),
                            fontWeight: FontWeight.bold,
                            fontSize: 16),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Expanded(
                        child: Container(
                          alignment: Alignment.centerLeft,
                          child: AutoSizeText(
                            widget.subtitulo,
                            textAlign: TextAlign.start,
                            overflow: TextOverflow.ellipsis,
                            maxLines: 4,
                            style: TextStyle(
                              color: Colors.black.withOpacity(0.7),
                              fontSize: 14,),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: Container(
                    height: 160,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      image: DecorationImage(
                          fit: BoxFit.cover,
                          image: NetworkImage(
                            widget.imagem,
                          )),
                    ),
                    alignment: Alignment.bottomRight,
                    child: Container(
                        height: 25,
                        width: MediaQuery.of(context).size.width * 0.12,
                        margin: EdgeInsets.all(5),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Colors.white,
                        ),
                        alignment: Alignment.center,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.star,
                              size: 15,
                            ),
                            widget.nota
                          ],
                        )),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      onTap: () {
        showDialog(
          context: context,
          barrierDismissible: true,
          builder: (BuildContext context) {
            return AlertDialog(
              scrollable: true,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(20.0))),
              insetPadding: EdgeInsets.all(10),
              content: Container(
                height: MediaQuery.of(context).size.height * 0.4,
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          GestureDetector(
                            child: Container(
                              height:
                                  MediaQuery.of(context).size.height * 0.15,
                              width: MediaQuery.of(context).size.height * 0.1,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(15),
                                image: DecorationImage(
                                    fit: BoxFit.cover,
                                    image: NetworkImage(
                                      widget.imagem,
                                    )),
                              ),
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
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Expanded(
                              child: Column(
                            children: [
                              Row(
                                children: [
                                  Icon(
                                    icone,
                                    size: 15,
                                    color: Colors.black.withOpacity(0.5),
                                  ),
                                  SizedBox(
                                    width: 3,
                                  ),
                                  Text(
                                    widget.tipo,
                                    style: TextStyle(
                                        color: Colors.black.withOpacity(0.5),
                                        fontWeight: FontWeight.bold,
                                        fontSize: 12),
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: 5,
                              ),
                              Container(
                                width: MediaQuery.of(context).size.width,
                                color: Colors.transparent,
                                child: Text(
                                  widget.titulo,
                                  textAlign: TextAlign.start,
                                  style: TextStyle(
                                      color: Color.fromARGB(250, 61, 56, 150),
                                      fontWeight: FontWeight.bold,
                                      fontSize: 20),
                                ),
                              ),
                            ],
                          )),
                        ],
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Container(
                        alignment: Alignment.topLeft,
                        child: SelectableText(
                          widget.subtitulo,
                          textAlign: TextAlign.start,
                          style: TextStyle(
                              color: Colors.black.withOpacity(0.7),
                              fontSize: 14),
                        ),
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      Container(
                        alignment: Alignment.topLeft,
                        child: SelectableText(
                          "Quer saber mais ou ter acesso ao conteúdo indicado? Acesse o link abaixo e confira.",
                          textAlign: TextAlign.start,
                          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 13),
                        ),
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Color.fromARGB(25, 61, 56, 150),
                        ),
                        padding: EdgeInsets.all(10),
                        child: Row(
                          children: [
                            Expanded(
                              child: Container(
                                alignment: Alignment.topLeft,
                                child: SelectableText(
                                  widget.link,
                                  textAlign: TextAlign.start,
                                  style: TextStyle(color: Colors.black,  fontSize: 13),
                                ),
                              ),
                            ),
                            IconButton(
                              icon: Icon(Icons.copy,
                                color:Color.fromARGB(250, 61, 56, 150),),
                              onPressed: (){
                                Clipboard.setData(ClipboardData(text: "${widget.link}"));
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
                      ),
                    ],
                  ),
                ),
              ),
              actions: <Widget>[
                SizedBox(
                  width: MediaQuery.of(context).size.width,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        width: 40,
                        height: 40,
                        margin: EdgeInsets.all(5),
                        decoration: BoxDecoration(
                            color: Color.fromARGB(250, 61, 56, 150),
                            shape: BoxShape.circle),
                        child: IconButton(
                          icon: Icon(
                            Icons.arrow_back_outlined,
                            color: Colors.white,
                          ),
                          onPressed: () {
                            Navigator.pop(context);
                          },
                        ),
                      ),
                      widget.like,
                    ],
                  ),
                ),
              ],
            );
          },
        );
      },
    );
  }

  _icones (){
    if(widget.tipo == "Livros"){
      setState(() {
        icone = Icons.menu_book_outlined;
      });
    }
    else if(widget.tipo == "Filmes e séries"){
      setState(() {
        icone = FlutterIcons.play_video_fou;
      });
    }
    else if(widget.tipo == "Músicas"){
      setState(() {
        icone = Icons.music_note_outlined;
      });
    }
    else if(widget.tipo == "Podcasts"){
      setState(() {
        icone = FlutterIcons.mic_ent;
      });
    }
    else if(widget.tipo == "Artigos"){
      setState(() {
        icone = FlutterIcons.card_text_outline_mco;
      });
    }
    else if(widget.tipo == "Videos"){
      setState(() {
        icone = FlutterIcons.video_vintage_mco;
      });
    }
    else if(widget.tipo == "Perfis"){
      setState(() {
        icone = FlutterIcons.people_mdi;
      });
    }
    else {
      setState(() {
        icone = Icons.tag;
      });
    }
  }

}
