import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:data_connection_checker/data_connection_checker.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';
import 'package:url_launcher/url_launcher.dart';

class ModelNews extends StatefulWidget {
  ModelNews(
      {Key key,
      this.cabecalho,
      this.titulo,
      this.data,
      this.text1,
      this.image1,
      this.text2,
      this.image2,
      this.text3,
      this.like,
      this.comment,
      this.indice})
      : super(key: key);

  final String cabecalho;
  final String titulo;
  final DateTime data;
  final String text1;
  final String image1;
  final String text2;
  final String image2;
  final String text3;

  final Widget like;
  final Widget comment;
  final int indice;

  @override
  _ModelNewsState createState() => _ModelNewsState();
}

class _ModelNewsState extends State<ModelNews> {

  bool check;
  StreamSubscription<DataConnectionStatus> listener;

  checkConnection() async {
    listener = DataConnectionChecker().onStatusChange.listen((status) {
      switch (status){
        case DataConnectionStatus.connected:
          setState(() {
            check = true;
          });
          break;
        case DataConnectionStatus.disconnected:
          setState(() {
            check = false;
          });
          break;
      }
    });
    return await DataConnectionChecker().connectionStatus;
  }

  @override
  void initState() {
    super.initState();
    this.checkConnection();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Material(
          elevation: 14,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: Colors.white,
            ),
            child: Column(
              children: [
                Container(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.width * 0.3,
                  decoration: BoxDecoration(
                      color: Color.fromARGB(250, 61, 56, 150),
                      borderRadius:
                          BorderRadius.vertical(top: Radius.circular(20)),
                      image: DecorationImage(
                          fit: BoxFit.cover,
                          image: NetworkImage(
                            widget.cabecalho,
                          ))),
                ),
                Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: 15,
                  ),
                  child: Padding(
                    padding: EdgeInsets.only(top: 5),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          color: Colors.transparent,
                          child: Text(
                            widget.titulo,
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                                color: Color.fromARGB(250, 61, 56, 150),
                                fontWeight: FontWeight.bold,
                                fontSize: 15),
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        widget.text1 == ""
                            ? Container()
                            : Container(
                                color: Colors.transparent,
                                child: Text(
                                  widget.text1,
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                  textAlign: TextAlign.justify,
                                  style: TextStyle(
                                      color: Colors.black.withOpacity(0.7),
                                      fontSize: 14),
                                ),
                              ),
                        SizedBox(
                          height: 10,
                        ),
                        Container(
                          color: Colors.transparent,
                          child: Text(
                            "${widget.data.day}/${widget.data.month}/${widget.data.year}",
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            textAlign: TextAlign.justify,
                            style: TextStyle(
                              fontSize: 12,
                              color: Colors.black.withOpacity(0.7),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 5,
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      onTap: () {
        Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => StatefulBuilder(
                  builder: (BuildContext context, StateSetter setState) {
                    return check == false ? Scaffold(
                      appBar: AppBar(
                        elevation: 0,
                        backgroundColor: Color.fromARGB(250, 61, 56, 150),
                        leading: IconButton(
                          icon: Icon(
                            Icons.arrow_back_outlined,
                            size: 25,
                            color: Colors.white,
                          ),
                          onPressed: () =>
                              Navigator.pop(context),
                        ),
                        title: Text(
                          "Ops...",
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 18),
                          textAlign: TextAlign.center,
                        ),
                      ),
                      body: Container(
                        color: Colors.red,
                        height: 40,
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.wifi_off_rounded, color: Colors.white,),
                            SizedBox(width: 5,),
                            Container(
                              child: Text("Sem conexão com a internet",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    color: Colors.white
                                ),),
                            )
                          ],
                        ),
                      ),
                    ): Container(
                      color: Color.fromARGB(250, 61, 56, 150),
                      child: SafeArea(
                        child: Scaffold(
                          backgroundColor: Colors.white,
                          body: Column(
                            children: [
                              Stack(
                                children: [
                                  Material(
                                    elevation: 14,
                                    shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.vertical(
                                            bottom: Radius.circular(20))),
                                    child: Container(
                                      width: MediaQuery.of(context).size.width,
                                      height:
                                          MediaQuery.of(context).size.width *
                                              0.4,
                                      decoration: BoxDecoration(
                                          color:
                                              Color.fromARGB(250, 61, 56, 150),
                                          borderRadius: BorderRadius.vertical(
                                              bottom: Radius.circular(20)),
                                          image: DecorationImage(
                                              fit: BoxFit.cover,
                                              image: NetworkImage(
                                                widget.cabecalho,
                                              ))),
                                    ),
                                  ),
                                  Positioned(
                                    child: IconButton(
                                      icon: Icon(
                                        Icons.arrow_back_outlined,
                                        color: Colors.white,
                                      ),
                                      onPressed: () {
                                        Navigator.pop(context);
                                      },
                                    ),
                                    top: 0,
                                    left: 0,
                                  )
                                ],
                              ),
                              Expanded(
                                child: ListView(
                                  padding: EdgeInsets.all(15),
                                  children: [
                                    widget.titulo == ""
                                        ? Container()
                                        : Container(
                                            child: SelectableText(
                                              widget.titulo,
                                              textAlign: TextAlign.start,
                                              style: TextStyle(
                                                  color: Color.fromARGB(
                                                      250, 61, 56, 150),
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 25),
                                            ),
                                          ),
                                    SizedBox(
                                      height: 15,
                                    ),
                                    widget.text1 == ""
                                        ? Container()
                                        : Container(
                                            child: SelectableText(
                                              widget.text1,
                                              textAlign: TextAlign.justify,
                                              style: TextStyle(
                                                  color: Colors.black,
                                                  fontSize: 15),
                                            ),
                                          ),
                                    SizedBox(
                                      height: 15,
                                    ),
                                    widget.image1 == "" || widget.image1 == null
                                        ? Container()
                                        : GestureDetector(
                                            child: Container(
                                                child: Image.network(
                                                    widget.image1)),
                                            onTap: () {
                                              Navigator.of(context)
                                                  .push(MaterialPageRoute(
                                                      builder:
                                                          (context) => SafeArea(
                                                                child: Scaffold(
                                                                  body:
                                                                      Container(
                                                                          width: MediaQuery.of(context)
                                                                              .size
                                                                              .width,
                                                                          height: MediaQuery.of(context)
                                                                              .size
                                                                              .height,
                                                                          child:
                                                                              Stack(
                                                                            children: [
                                                                              Container(
                                                                                child: PhotoView(imageProvider: NetworkImage(widget.image1)),
                                                                              ),
                                                                              Positioned(
                                                                                child: Container(
                                                                                  width: 50,
                                                                                  height: 50,
                                                                                  decoration: BoxDecoration(color: Color.fromARGB(250, 61, 56, 150), shape: BoxShape.circle),
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
                                                                                top: 5,
                                                                                left: 5,
                                                                              )
                                                                            ],
                                                                          )),
                                                                ),
                                                              )));
                                            },
                                          ),
                                    SizedBox(
                                      height: 15,
                                    ),
                                    widget.text2 == "" || widget.image2 == null
                                        ? Container()
                                        : Container(
                                            child: SelectableText(
                                              widget.text2,
                                              textAlign: TextAlign.justify,
                                              style: TextStyle(
                                                  color: Colors.black,
                                                  fontSize: 15),
                                            ),
                                          ),
                                    widget.image2 == ""
                                        ? Container()
                                        : GestureDetector(
                                            child: Container(
                                                child: Image.network(
                                                    widget.image2)),
                                            onTap: () {
                                              Navigator.of(context)
                                                  .push(MaterialPageRoute(
                                                      builder:
                                                          (context) => SafeArea(
                                                                child: Scaffold(
                                                                  body:
                                                                      Container(
                                                                          width: MediaQuery.of(context)
                                                                              .size
                                                                              .width,
                                                                          height: MediaQuery.of(context)
                                                                              .size
                                                                              .height,
                                                                          child:
                                                                              Stack(
                                                                            children: [
                                                                              Container(
                                                                                child: PhotoView(imageProvider: NetworkImage(widget.image2)),
                                                                              ),
                                                                              Positioned(
                                                                                child: Container(
                                                                                  width: 50,
                                                                                  height: 50,
                                                                                  decoration: BoxDecoration(color: Color.fromARGB(250, 61, 56, 150), shape: BoxShape.circle),
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
                                                                                top: 5,
                                                                                left: 5,
                                                                              )
                                                                            ],
                                                                          )),
                                                                ),
                                                              )));
                                            },
                                          ),
                                    SizedBox(
                                      height: widget.text3 == "" ? 0 : 15,
                                    ),
                                    widget.text3 == ""
                                        ? Container()
                                        : Container(
                                            child: SelectableText(
                                              widget.text3,
                                              textAlign: TextAlign.justify,
                                              style: TextStyle(
                                                  color: Colors.black,
                                                  fontSize: 15),
                                            ),
                                          ),
                                    SizedBox(
                                      height: 25,
                                    ),
                                    Container(
                                      child: Text(
                                        "${widget.data.day}/${widget.data.month}/${widget.data.year}",
                                        textAlign: TextAlign.start,
                                        style: TextStyle(
                                            color:
                                                Colors.black.withOpacity(0.6),
                                            fontWeight: FontWeight.bold,
                                            fontSize: 15),
                                      ),
                                    ),
                                    SizedBox(
                                      height: 25,
                                    ),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: [widget.like, widget.comment],
                                    ),
                                    StreamBuilder<
                                        QuerySnapshot>(
                                      stream: FirebaseFirestore
                                          .instance
                                          .collection(
                                          "newsletter")
                                          .doc(
                                          "${widget.indice}")
                                          .collection(
                                          "autores")
                                          .snapshots(),
                                      builder: (context,
                                          snapshot) {
                                        if(snapshot.connectionState == ConnectionState.waiting ||
                                            snapshot.connectionState == ConnectionState.none){
                                          return Container();
                                        }
                                        else if(snapshot.data.docs[0]["descricao"] == "" && snapshot.data.docs[0]["foto"] == "" && snapshot.data.docs[0]["nome"] == ""){
                                          return Container();
                                        }
                                        else {
                                          return Column(
                                            crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                            children: [
                                              Container(
                                                child: SelectableText(
                                                  "Autores (as)",
                                                  textAlign: TextAlign.start,
                                                  style: TextStyle(
                                                      color: Color.fromARGB(
                                                          250, 61, 56, 150),
                                                      fontWeight: FontWeight.bold,
                                                      fontSize: 15),
                                                ),
                                              ),
                                              SizedBox(
                                                height: 10,
                                              ),
                                              Container(
                                                padding: EdgeInsets.all(10),
                                                decoration: BoxDecoration(
                                                    borderRadius:
                                                    BorderRadius.circular(15),
                                                    color: Colors.grey
                                                        .withOpacity(0.2)),
                                                child: ListView
                                                    .builder(
                                                    itemCount:
                                                    snapshot.data.docs
                                                        .length,
                                                    shrinkWrap:
                                                    true,
                                                    physics:
                                                    NeverScrollableScrollPhysics(),
                                                    itemBuilder:
                                                        (context,
                                                        index) {
                                                      return MyListTile(snapshot.data.docs[index]["nome"], snapshot.data.docs[index]["foto"], snapshot.data.docs[index]["descricao"]);
                                                    }),
                                                ),
                                            ],
                                          );
                                        }
                                      },
                                    ),
                                    SizedBox(
                                      height: 15,
                                    ),
                                    StreamBuilder<
                                        QuerySnapshot>(
                                      stream: FirebaseFirestore
                                          .instance
                                          .collection(
                                          "newsletter")
                                          .doc(
                                          "${widget.indice}")
                                          .collection(
                                          "referencias")
                                          .snapshots(),
                                      builder: (context,
                                          snapshot) {
                                        if(snapshot.connectionState == ConnectionState.waiting ||
                                            snapshot.connectionState == ConnectionState.none){
                                          return Container();
                                        }
                                        else if(snapshot.data.docs[0]["data"] == "" && snapshot.data.docs[0]["link"] == "" && snapshot.data.docs[0]["titulo"] == ""){
                                          return Container();
                                        }
                                        else {
                                          return Column(
                                            crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                            children: [
                                              Container(
                                                child: Text(
                                                  "Referências",
                                                  textAlign: TextAlign.start,
                                                  style: TextStyle(
                                                      color: Color.fromARGB(
                                                          250, 61, 56, 150),
                                                      fontWeight:
                                                      FontWeight.bold,
                                                      fontSize: 15),
                                                ),
                                              ),
                                              SizedBox(
                                                height: 10,
                                              ),
                                              Container(
                                                margin: EdgeInsets.all(5),
                                                padding:
                                                EdgeInsets.all(15),
                                                decoration: BoxDecoration(
                                                    borderRadius:
                                                    BorderRadius
                                                        .circular(15),
                                                    color: Colors.grey
                                                        .withOpacity(
                                                        0.2)),
                                                child: ListView
                                                    .builder(
                                                    itemCount:
                                                    snapshot.data.docs
                                                        .length,
                                                    shrinkWrap:
                                                    true,
                                                    physics:
                                                    NeverScrollableScrollPhysics(),
                                                    itemBuilder:
                                                        (context,
                                                        index) {
                                                      return RichText(
                                                        textAlign:
                                                        TextAlign.start,
                                                        text: TextSpan(
                                                            text: "",
                                                            style: TextStyle(
                                                              color: Colors.black,
                                                              fontSize: 14,
                                                            ),
                                                            children: <TextSpan>[
                                                              TextSpan(text: "[${index + 1}] ", style: TextStyle(color: Colors.black, fontSize: 14, fontWeight: FontWeight.w500)),
                                                              TextSpan(
                                                                  text: "${snapshot.data.docs[index]["titulo"]} ",
                                                                  style: TextStyle(
                                                                    color: Colors.black,
                                                                    fontSize: 14,
                                                                  )),
                                                              snapshot.data.docs[index]["link"] == ""
                                                                  ? TextSpan(
                                                                  text: "",
                                                                  style: TextStyle(
                                                                    color: Colors.black,
                                                                    fontSize: 14,
                                                                  ))
                                                                  : TextSpan(
                                                                  text: "Disponível em: ",
                                                                  style: TextStyle(
                                                                    color: Colors.black,
                                                                    fontSize: 14,
                                                                  )),
                                                              snapshot.data.docs[index]["link"] == ""
                                                                  ? TextSpan(
                                                                  text: "",
                                                                  style: TextStyle(
                                                                    color: Colors.black,
                                                                    fontSize: 14,
                                                                  ))
                                                                  : TextSpan(
                                                                  recognizer: TapGestureRecognizer()..onTap = () async {
                                                                    if (await canLaunch(
                                                                        snapshot.data.docs[index]["link"])) {
                                                                      await launch(
                                                                        snapshot.data.docs[index]["link"],
                                                                        forceSafariVC: false,
                                                                        forceWebView: false,
                                                                        headers: <String, String>{
                                                                          'my_header_key': 'my_header_value'
                                                                        },
                                                                      );
                                                                    } else {
                                                                      throw 'Could not launch ${snapshot.data.docs[index]["link"]}';
                                                                    }
                                                                  },
                                                                  text: "${snapshot.data.docs[index]["link"]}",
                                                                  style: TextStyle(
                                                                      color: Color.fromARGB(250, 61, 56, 150),
                                                                      fontSize: 14,
                                                                      decoration: TextDecoration.underline
                                                                  )),
                                                              TextSpan(
                                                                  text: snapshot.data.docs[index]["data"] == "" ? "\n" : "Acesso em: ${snapshot.data.docs[index]["data"]}.\n",
                                                                  style: TextStyle(
                                                                    color: Colors.black,
                                                                    fontSize: 14,
                                                                  ))
                                                            ]),
                                                      );
                                                    }),
                                              ),
                                            ],
                                          );
                                        }
                                      },
                                    ),
                                  ],
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                )));
      },
    );
  }
}

class MyListTile extends StatelessWidget {
  final String name;
  final String photo;
  final String description;

  MyListTile(this.name, this.photo, this.description);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: EdgeInsets.only(
        bottom: 5
      ),
      leading: Container(
        width: 40,
        height: 40,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: Colors.white,
          image: DecorationImage(fit: BoxFit.cover, image: NetworkImage(photo)),
        ),
      ),
      title: Padding(
        padding: EdgeInsets.only(bottom: 5),
        child: SelectableText(
          name,
          style: TextStyle(
              fontWeight: FontWeight.bold, fontSize: 14, color: Colors.black),
        ),
      ),
      subtitle: SelectableText(
        description,
        style: TextStyle(fontSize: 14, color: Colors.black),
        textAlign: TextAlign.start,
      ),
    );
  }
}
