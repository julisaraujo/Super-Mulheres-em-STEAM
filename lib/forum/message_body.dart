import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:photo_view/photo_view.dart';

class MessageBody extends StatefulWidget {
  MessageBody({Key key, this.text, this.mine, this.email, this.id, this.time, this. focus, this.nome, this.foto})
      : super(key: key);

  final String text;
  final bool mine;
  final String email;
  final String id;
  final DateTime time;
  final FocusNode focus;
  final String nome;
  final String foto;

  @override
  _MessageBodyState createState() => _MessageBodyState();
}

class _MessageBodyState extends State<MessageBody> {

  bool showtime = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.transparent,
      child: Padding(
        padding: EdgeInsets.only(
            left: widget.mine == false
                ? 10
                : MediaQuery.of(context).size.width * 0.2,
            right: widget.mine == false
                ? MediaQuery.of(context).size.width * 0.2
                : 10,
            top: 10,
            bottom: 10),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            widget.mine == false
                ? Padding(
                padding: EdgeInsets.only(right: 5),
                child: GestureDetector(
                  child: CircleAvatar(
                    backgroundImage:
                    NetworkImage(widget.foto) ??
                        AssetImage("assets/avatar/avatar.png"),
                  ),
                  onTap: () {
                    widget.focus.unfocus();
                    showDialog(
                        context: context,
                        barrierDismissible: true,
                        builder: (context) {
                          return AlertDialog(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.all(
                                    Radius.circular(20))),
                            contentPadding: EdgeInsets.all(0),
                            insetPadding: EdgeInsets.all(5),
                            content: CardMessage(
                              nome: widget.nome,
                              foto: widget.foto,
                              id: widget.id,
                            ),
                          );
                        });
                  },
                ))
                : Container(),
            Expanded(
              child: Column(
                crossAxisAlignment: widget.mine == true
                    ? CrossAxisAlignment.end
                    : CrossAxisAlignment.start,
                children: [
                  widget.mine == false
                      ? Padding(
                    padding: EdgeInsets.only(left: 5, right: 5),
                    child: Text(
                      widget.nome,
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 13,
                          color: Color.fromARGB(250, 61, 56, 150)),
                    ),
                  )
                      : Container(),
                  GestureDetector(
                    child: Container(
                      padding: EdgeInsets.all(10),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Colors.grey.withOpacity(0.2)),
                      child: Text(
                        widget.text,
                      ),
                    ),
                    onTap: (){
                      setState(() {
                        showtime = !showtime;
                      });
                    },
                  ),
                  showtime == true ? Container(
                    color: Colors.transparent,
                    margin: EdgeInsets.only(
                        top: 2
                    ),
                    child: Text(
                      "Enviado às ${DateFormat.Hm().format(widget.time)} em ${DateFormat('d/MM/yyyy').format(widget.time)}",
                      style: TextStyle(
                          color: Colors.grey.withOpacity(0.9),
                          fontSize: 12
                      ),
                    ),
                  ) : Container(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class CardMessage extends StatefulWidget {
  CardMessage({Key key, this.nome, this.foto, this.id}) : super(key: key);

  final String nome;
  final String foto;
  final String id;

  @override
  _CardMessageState createState() => _CardMessageState();
}

class _CardMessageState extends State<CardMessage> {
  int newscomment;
  int newslike;
  int forum;
  int indica;

  int pontos;
  int nivel;

  @override
  Widget build(BuildContext context) {
    return Stack(
      overflow: Overflow.visible,
      alignment: Alignment.center,
      children: [
        Container(
          height: 250,
          width: MediaQuery.of(context).size.width * 0.9,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: Color.fromARGB(250, 61, 56, 150)),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                  margin: EdgeInsets.symmetric(vertical: 10),
                  child: GestureDetector(
                    child: Container(
                      width: 100,
                      height: 100,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        boxShadow: <BoxShadow>[
                          BoxShadow(
                              color: Colors.deepOrangeAccent.withOpacity(0.5),
                              blurRadius: 50,
                              offset: Offset(0.0, 5.0))
                        ],
                        shape: BoxShape.circle,
                        image: DecorationImage(
                            fit: BoxFit.cover,
                            image: NetworkImage(widget.foto)),
                      ),
                    ),
                    onTap: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => SafeArea(
                                child: Scaffold(
                                  body: Container(
                                      width: MediaQuery.of(context).size.width,
                                      height:
                                          MediaQuery.of(context).size.height,
                                      child: Stack(
                                        children: [
                                          Container(
                                            child: PhotoView(
                                                imageProvider:
                                                    NetworkImage(widget.foto)),
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
                                                      Icons.arrow_back_outlined,
                                                      color: Colors.white,
                                                    ),
                                                    onPressed: () {
                                                      Navigator.pop(context);
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
                  )),
              Container(
                color: Colors.transparent,
                width: 200,
                height: 50,
                alignment: Alignment.center,
                child: Text(
                  widget.nome,
                  maxLines: 2,
                  textAlign: TextAlign.center,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 18),
                ),
              ),
              Padding(
                  padding: EdgeInsets.symmetric(horizontal: 10),
                  child: StreamBuilder<QuerySnapshot>(
                    stream: FirebaseFirestore.instance
                        .collection("users")
                        .doc("${widget.id}")
                        .collection("newscomment")
                        .snapshots(),
                    builder: (context, snapnewscomment) {
                      newscomment = !snapnewscomment.hasData
                          ? 0
                          : snapnewscomment.data.docs.length;
                      return StreamBuilder<QuerySnapshot>(
                        stream: FirebaseFirestore.instance
                            .collection("users")
                            .doc("${widget.id}")
                            .collection("newslike")
                            .snapshots(),
                        builder: (context, snapnewslike) {
                          newslike = !snapnewslike.hasData
                              ? 0
                              : snapnewslike.data.docs.length;
                          return StreamBuilder<QuerySnapshot>(
                            stream: FirebaseFirestore.instance
                                .collection("users")
                                .doc("${widget.id}")
                                .collection("forum")
                                .snapshots(),
                            builder: (context, snapforum) {
                              forum = !snapforum.hasData
                                  ? 0
                                  : snapforum.data.docs.length;
                              return StreamBuilder<QuerySnapshot>(
                                stream: FirebaseFirestore.instance
                                    .collection("users")
                                    .doc("${widget.id}")
                                    .collection("indica")
                                    .snapshots(),
                                builder: (context, snapindica) {
                                  indica = !snapindica.hasData
                                      ? 0
                                      : snapindica.data.docs.length;

                                  pontos = (newscomment - 1) +
                                      4 * (newslike - 1) +
                                      (forum - 1) +
                                      4 * (indica - 1);

                                  if (100 >= pontos) {
                                    nivel = 1;
                                  } else if (100 < pontos && 300 >= pontos) {
                                    nivel = 2;
                                  } else if (300 < pontos && 600 >= pontos) {
                                    nivel = 3;
                                  } else if (600 < pontos && 1000 >= pontos) {
                                    nivel = 4;
                                  } else if (1000 < pontos && 1500 >= pontos) {
                                    nivel = 5;
                                  } else if (1500 < pontos && 2100 >= pontos) {
                                    nivel = 6;
                                  } else if (2100 < pontos && 2800 >= pontos) {
                                    nivel = 7;
                                  } else if (2800 < pontos && 3600 >= pontos) {
                                    nivel = 8;
                                  } else if (3600 < pontos && 4500 >= pontos) {
                                    nivel = 9;
                                  } else if (4500 < pontos && 5500 >= pontos) {
                                    nivel = 10;
                                  } else if (5500 < pontos && 6600 >= pontos) {
                                    nivel = 11;
                                  } else if (6600 < pontos && 7800 >= pontos) {
                                    nivel = 12;
                                  } else if (7800 < pontos && 9100 >= pontos) {
                                    nivel = 13;
                                  } else if (9100 < pontos && 10500 >= pontos) {
                                    nivel = 14;
                                  } else if (10500 < pontos &&
                                      12000 >= pontos) {
                                    nivel = 15;
                                  } else if (12000 < pontos &&
                                      13600 >= pontos) {
                                    nivel = 16;
                                  } else if (13600 < pontos &&
                                      15300 >= pontos) {
                                    nivel = 17;
                                  } else if (15300 < pontos &&
                                      17100 >= pontos) {
                                    nivel = 18;
                                  } else if (17100 < pontos &&
                                      19000 >= pontos) {
                                    nivel = 19;
                                  } else if (19000 < pontos) {
                                    nivel = 20;
                                  }

                                  return Column(
                                    children: [
                                      Padding(
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 35),
                                        child: Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.center,
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                Text(
                                                  !snapforum.hasData ||
                                                          !snapnewscomment
                                                              .hasData
                                                      ? "0"
                                                      : "${(snapforum.data.docs.length - 1) + (snapnewscomment.data.docs.length - 1)}",
                                                  maxLines: 1,
                                                  textAlign: TextAlign.center,
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                  style: TextStyle(
                                                      color: Colors
                                                          .deepOrangeAccent,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontSize: 17),
                                                ),
                                                SizedBox(
                                                  height: 5,
                                                ),
                                                Text(
                                                  "Interações",
                                                  maxLines: 1,
                                                  textAlign: TextAlign.center,
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                  style: TextStyle(
                                                      color: Colors.white,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontSize: 13),
                                                ),
                                              ],
                                            ),
                                            Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.center,
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                Text(
                                                  pontos < 0 ? "0" : "$pontos",
                                                  maxLines: 1,
                                                  textAlign: TextAlign.center,
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                  style: TextStyle(
                                                      color: Colors
                                                          .deepOrangeAccent,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontSize: 17),
                                                ),
                                                SizedBox(
                                                  height: 5,
                                                ),
                                                Text(
                                                  "Pontos",
                                                  maxLines: 1,
                                                  textAlign: TextAlign.center,
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                  style: TextStyle(
                                                      color: Colors.white,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontSize: 13),
                                                ),
                                              ],
                                            ),
                                            Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.center,
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                Text(
                                                  "$nivel",
                                                  maxLines: 1,
                                                  textAlign: TextAlign.center,
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                  style: TextStyle(
                                                      color: Colors
                                                          .deepOrangeAccent,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontSize: 17),
                                                ),
                                                SizedBox(
                                                  height: 5,
                                                ),
                                                Text(
                                                  "Nível",
                                                  maxLines: 1,
                                                  textAlign: TextAlign.center,
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                  style: TextStyle(
                                                      color: Colors.white,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontSize: 13),
                                                ),
                                              ],
                                            ),
                                            Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.center,
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                Text(
                                                  !snapnewslike.hasData
                                                      ? "0"
                                                      : "${snapnewslike.data.docs.length - 1}",
                                                  maxLines: 1,
                                                  textAlign: TextAlign.center,
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                  style: TextStyle(
                                                      color: Colors
                                                          .deepOrangeAccent,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontSize: 17),
                                                ),
                                                SizedBox(
                                                  height: 5,
                                                ),
                                                Text(
                                                  "Newsletters",
                                                  maxLines: 2,
                                                  textAlign: TextAlign.center,
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                  style: TextStyle(
                                                      color: Colors.white,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontSize: 13),
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  );
                                },
                              );
                            },
                          );
                        },
                      );
                    },
                  )),
            ],
          ),
        ),
        Positioned(
          child: GestureDetector(
            child: Container(
              width: 30,
              height: 30,
              margin: EdgeInsets.all(5),
              decoration:
                  BoxDecoration(color: Colors.white, shape: BoxShape.circle),
              child: Icon(
                Icons.close,
                size: 15,
              ),
            ),
            onTap: () {
              Navigator.pop(context);
            },
          ),
          top: -15,
          right: -15,
        )
      ],
    );
  }
}
