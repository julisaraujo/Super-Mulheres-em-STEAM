import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:intl/intl.dart';
import 'package:super_mulheres_steam/forum/message_body.dart';
import 'package:super_mulheres_steam/login/user_model.dart';
import 'package:scoped_model/scoped_model.dart';

class CommentNewsletter extends StatefulWidget {
  CommentNewsletter({Key key, this.indice}) : super(key: key);

  final int indice;

  @override
  _CommentNewsletterState createState() => _CommentNewsletterState();
}

class _CommentNewsletterState extends State<CommentNewsletter> {

  FocusNode internfocus = FocusNode();

  @override
  Widget build(BuildContext context) {
    return ScopedModelDescendant<UserModel>(builder: (context, child, model) {
      return Container(
          color: Colors.transparent,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              IconButton(
                icon: Icon(FlutterIcons.comment_o_faw),
                onPressed: () {
                  showModalBottomSheet(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.vertical(
                              top: Radius.circular(25.0))),
                      context: context,
                      isScrollControlled: true,
                      builder: (context) => Padding(
                            padding: MediaQuery.of(context).viewInsets,
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Container(
                                  height:
                                      MediaQuery.of(context).size.height * 0.4,
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Expanded(
                                        child: StreamBuilder<QuerySnapshot>(
                                          stream: FirebaseFirestore.instance
                                              .collection("newsletter")
                                              .doc("${widget.indice}")
                                              .collection("comments")
                                              .orderBy("time")
                                              .snapshots(),
                                          builder: (context, snapshot) {
                                            switch (snapshot.connectionState) {
                                              case ConnectionState.waiting:
                                              case ConnectionState.none:
                                                return Center(
                                                  child:
                                                      CircularProgressIndicator(),
                                                );
                                              default:
                                                List<DocumentSnapshot>
                                                    documents = snapshot
                                                        .data.docs.reversed
                                                        .toList();
                                                return Column(
                                                  children: [
                                                    Padding(
                                                      padding: EdgeInsets.only(
                                                          top: 10,
                                                          right: 10,
                                                          left: 10),
                                                      child: Column(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .start,
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        children: [
                                                          SizedBox(
                                                            height: 5,
                                                          ),
                                                          Row(
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .spaceBetween,
                                                            children: [
                                                              Text(
                                                                "Comentários",
                                                                textAlign:
                                                                    TextAlign
                                                                        .start,
                                                                style: TextStyle(
                                                                    color: Color
                                                                        .fromARGB(
                                                                            250,
                                                                            61,
                                                                            56,
                                                                            150),
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .bold,
                                                                    fontSize:
                                                                        25),
                                                              ),
                                                              Row(
                                                                children: [
                                                                  Text(
                                                                    snapshot.data.docs.length ==
                                                                            0
                                                                        ? ""
                                                                        : "${snapshot.data.docs.length}",
                                                                    textAlign:
                                                                        TextAlign
                                                                            .start,
                                                                    style: TextStyle(
                                                                        color: Color.fromARGB(
                                                                            250,
                                                                            61,
                                                                            56,
                                                                            150),
                                                                        fontWeight:
                                                                            FontWeight
                                                                                .bold,
                                                                        fontSize:
                                                                            19),
                                                                  ),
                                                                  SizedBox(
                                                                    width: 5,
                                                                  ),
                                                                  Icon(
                                                                    FlutterIcons
                                                                        .comment_faw,
                                                                    size: 22,
                                                                  )
                                                                ],
                                                              )
                                                            ],
                                                          ),
                                                          SizedBox(
                                                            height: 12,
                                                          ),
                                                          Divider(
                                                            color:
                                                                Color.fromARGB(
                                                                    150,
                                                                    61,
                                                                    56,
                                                                    150),
                                                            height: 0,
                                                            thickness: 1.0,
                                                            indent: 0,
                                                            endIndent: 0,
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                    Expanded(
                                                        child: documents
                                                                    .length ==
                                                                0
                                                            ? Column(
                                                                mainAxisAlignment:
                                                                    MainAxisAlignment
                                                                        .center,
                                                                crossAxisAlignment:
                                                                    CrossAxisAlignment
                                                                        .center,
                                                                children: [
                                                                  Container(
                                                                    width: MediaQuery.of(context)
                                                                            .size
                                                                            .width *
                                                                        0.75,
                                                                    child: Text(
                                                                      "Seja a primeira pessoa a adicionar um comentário nesse post",
                                                                      style: TextStyle(
                                                                          color: Color.fromARGB(
                                                                              250,
                                                                              61,
                                                                              56,
                                                                              150),
                                                                          fontWeight: FontWeight
                                                                              .bold,
                                                                          fontSize:
                                                                              15),
                                                                      textAlign:
                                                                          TextAlign
                                                                              .center,
                                                                    ),
                                                                  ),
                                                                  SizedBox(
                                                                    height: 5,
                                                                  ),
                                                                  Icon(
                                                                    FlutterIcons
                                                                        .emoticon_wink_outline_mco,
                                                                    size: 30,
                                                                  )
                                                                ],
                                                              )
                                                            : StreamBuilder<
                                                                    QuerySnapshot>(
                                                                stream: FirebaseFirestore
                                                                    .instance
                                                                    .collection(
                                                                        "users")
                                                                    .snapshots(),
                                                                builder: (context,
                                                                    snapshotvalid) {
                                                                  switch (snapshotvalid
                                                                      .connectionState) {
                                                                    case ConnectionState
                                                                        .waiting:
                                                                    case ConnectionState
                                                                        .none:
                                                                      return Center(
                                                                        child:
                                                                            CircularProgressIndicator(),
                                                                      );
                                                                    default:
                                                                      List<DocumentSnapshot> documentsvalid = snapshotvalid
                                                                          .data
                                                                          .docs
                                                                          .reversed
                                                                          .toList();
                                                                      return Container(
                                                                        color: Colors
                                                                            .white,
                                                                        child: ListView.builder(
                                                                            itemCount: documents.length,
                                                                            reverse: true,
                                                                            itemBuilder: (context, index) {
                                                                              if(documentsvalid.where((documentsvalid) => documentsvalid["email"] == documents[index]["email"]).length == 1){
                                                                                return CommentBody(
                                                                                  email: documents[index]["email"],
                                                                                  text: documents[index]["comment"],
                                                                                  id: documents[index]["id"],
                                                                                  time: documents[index]["time"] == null ? DateTime.now() : documents[index]["time"].toDate(),
                                                                                  tempo: documents[index]["tempo"].toDate(),
                                                                                  mine: documents[index]["email"] == model.firebaseUser.email ? true : false,
                                                                                  indice: widget.indice,
                                                                                  focus: internfocus,
                                                                                  nome: documentsvalid.where((documentsvalid) => documentsvalid["email"] == documents[index]["email"]).toList()[0]["nome"],
                                                                                  foto: documentsvalid.where((documentsvalid) => documentsvalid["email"] == documents[index]["email"]).toList()[0]["foto"],
                                                                                );
                                                                              }
                                                                              else{
                                                                                return Container();
                                                                              }
                                                                            }),
                                                                      );
                                                                  }
                                                                }))
                                                  ],
                                                );
                                            }
                                          },
                                        ),
                                      ),
                                      ComposerComment((String text) {
                                        Map<String, dynamic> data = {};

                                        if (text != null)
                                          data["comment"] = text;
                                        data["time"] = FieldValue.serverTimestamp();
                                        data["tempo"] = DateTime.now();
                                        if (model.isLoggedIn())
                                          data["email"] =
                                              model.userData["email"];
                                        if (model.isLoggedIn())
                                          data["id"] = model.firebaseUser.uid;

                                        FirebaseFirestore.instance
                                            .collection("newsletter")
                                            .doc("${widget.indice}")
                                            .collection("comments")
                                            .doc("${DateTime.now().year}"
                                                "${DateTime.now().month}"
                                                "${DateTime.now().day}"
                                                "${DateTime.now().hour}"
                                                "${DateTime.now().minute}"
                                                "${DateTime.now().second}"
                                                "${model.userData["email"]}")
                                            .set(data);

                                        FirebaseFirestore.instance
                                            .collection("users")
                                            .doc(model.firebaseUser.uid)
                                            .collection("newscomment")
                                            .doc("${widget.indice}"
                                                "${DateTime.now().year}"
                                                "${DateTime.now().month}"
                                                "${DateTime.now().day}"
                                                "${DateTime.now().hour}"
                                                "${DateTime.now().minute}"
                                                "${DateTime.now().second}")
                                            .set({
                                          "indice": widget.indice,
                                          "time": FieldValue.serverTimestamp()
                                        });
                                      }, internfocus)
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ));
                },
              ),
            ],
          ));
    });
  }

  Future<QuerySnapshot> getDatacomment() async {
    await Firebase.initializeApp();
    return await FirebaseFirestore.instance
        .collection("newsletter")
        .doc("${widget.indice}")
        .collection("comments")
        .orderBy("time")
        .get();
  }
}

class ComposerComment extends StatefulWidget {
  ComposerComment(this.send, this.focus);

  Function(String) send;
  FocusNode focus;

  @override
  _ComposerCommentState createState() => _ComposerCommentState();
}

class _ComposerCommentState extends State<ComposerComment> {
  final TextEditingController _controller = TextEditingController();

  bool _validador = false;

  void _reset() {
    _controller.clear();
    setState(() {
      _validador = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 5, vertical: 5),
      padding: EdgeInsets.only(left: 10),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(35),
          color: Colors.grey.withOpacity(0.2)),
      child: Row(
        children: [
          Expanded(
              child: TextField(
            controller: _controller,
            focusNode: widget.focus,
            decoration:
                InputDecoration.collapsed(hintText: "Envie uma mensagem"),
            onChanged: (text) {
              setState(() {
                _validador = text.isNotEmpty;
              });
            },
            onSubmitted: (text) {
              widget.send(text);
              _reset();
            },
          )),
          IconButton(
              icon: Icon(Icons.send),
              onPressed: _validador
                  ? () {
                      widget.send(_controller.text);
                      _reset();
                    }
                  : null)
        ],
      ),
    );
  }
}

class CommentBody extends StatefulWidget {
  final String text;
  final String email;
  final String id;
  final DateTime time;
  final DateTime tempo;
  final bool mine;
  final int indice;
  final FocusNode focus;
  final String nome;
  final String foto;

  CommentBody(
      {Key key,
      this.text,
      this.email,
      this.id,
      this.time,
      this.tempo,
      this.mine,
      this.indice,
      this.focus,
      this.nome,
      this.foto})
      : super(key: key);

  @override
  _CommentBodyState createState() => _CommentBodyState();
}

class _CommentBodyState extends State<CommentBody> {
  bool showtime = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Padding(
        padding: EdgeInsets.all(10),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Padding(
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
                )),
            Expanded(
              child: Padding(
                padding: EdgeInsets.only(
                  left: 5,
                  right: MediaQuery.of(context).size.width * 0.2,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "${widget.nome}",
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 13,
                          color: Color.fromARGB(250, 61, 56, 150)),
                    ),
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
                      onTap: () {
                        setState(() {
                          showtime = !showtime;
                        });
                      },
                    ),
                    showtime == true
                        ? Container(
                      color: Colors.transparent,
                      margin: EdgeInsets.only(top: 2),
                      child: Text(
                        "Enviado às ${DateFormat.Hm().format(widget.time)} em ${DateFormat('d/MM/yyyy').format(widget.time)}",
                        style: TextStyle(
                            color: Colors.grey.withOpacity(0.9),
                            fontSize: 12),
                      ),
                    )
                        : Container(),
                  ],
                ),
              ),
            ),
            widget.mine == true
                ? IconButton(
              icon: Icon(Icons.delete),
              onPressed: () {
                widget.focus.unfocus();
                showDialog(
                    context: context,
                    barrierDismissible: true,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.all(
                                Radius.circular(20.0))),
                        insetPadding: EdgeInsets.all(10),
                        title: Container(
                          width: 45,
                          height: 45,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: Colors.white,
                            border: Border.all(
                                width: 3,
                                color: Color.fromARGB(
                                    250, 61, 56, 150)),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.5),
                                spreadRadius: 5,
                                blurRadius: 7,
                                offset: Offset(0,
                                    3), // changes position of shadow
                              ),
                            ],
                          ),
                          alignment: Alignment.center,
                          child: Icon(
                            Icons.delete,
                            size: 35,
                          ),
                        ),
                        content: Container(
                          width: MediaQuery.of(context).size.width *
                              0.5,
                          child: Text(
                            "Excluir esse comentário?",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                color: Color.fromARGB(
                                    250, 61, 56, 150),
                                fontWeight: FontWeight.bold,
                                fontSize: 15),
                          ),
                        ),
                        actions: [
                          Row(
                            mainAxisAlignment:
                            MainAxisAlignment.center,
                            children: [
                              SizedBox(
                                width: 100,
                                child: ElevatedButton(
                                  child: Text(
                                    "Cancelar",
                                    style: TextStyle(
                                        color: Color.fromARGB(
                                            250, 61, 56, 150)),
                                  ),
                                  style: ButtonStyle(
                                      backgroundColor:
                                      MaterialStateProperty.all<Color>(
                                          Colors.white),
                                      shape: MaterialStateProperty.all<
                                          RoundedRectangleBorder>(
                                          RoundedRectangleBorder(
                                              borderRadius:
                                              BorderRadius.circular(
                                                  18.0),
                                              side: BorderSide(
                                                  color: Color.fromARGB(
                                                      250, 61, 56, 150))))),
                                  onPressed: () {
                                    Navigator.pop(context);
                                  },
                                ),
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              SizedBox(
                                width: 100,
                                child: ElevatedButton(
                                  child: Text("Sim"),
                                  style: ButtonStyle(
                                      backgroundColor:
                                      MaterialStateProperty.all<
                                          Color>(
                                          Color.fromARGB(250,
                                              61, 56, 150)),
                                      shape: MaterialStateProperty
                                          .all<RoundedRectangleBorder>(
                                          RoundedRectangleBorder(
                                            borderRadius:
                                            BorderRadius.circular(
                                                18.0),
                                          ))),
                                  onPressed: () {

                                    FirebaseFirestore.instance
                                        .collection("newsletter")
                                        .doc("${widget.indice}")
                                        .collection("comments")
                                        .doc("${widget.tempo.year}"
                                        "${widget.tempo.month}"
                                        "${widget.tempo.day}"
                                        "${widget.tempo.hour}"
                                        "${widget.tempo.minute}"
                                        "${widget.tempo.second}"
                                        "${widget.email}")
                                        .delete();

                                    FirebaseFirestore.instance
                                        .collection("users")
                                        .doc(UserModel.of(context).firebaseUser.uid)
                                        .collection("newscomment")
                                        .doc("${widget.indice}"
                                        "${widget.tempo.year}"
                                        "${widget.tempo.month}"
                                        "${widget.tempo.day}"
                                        "${widget.tempo.hour}"
                                        "${widget.tempo.minute}"
                                        "${widget.tempo.second}")
                                        .delete();

                                    Navigator.pop(context);
                                  },
                                ),
                              ),
                            ],
                          ),
                        ],
                      );
                    });
              },
            )
                : Container(),
          ],
        ),
      )
    );
  }

  Future<QuerySnapshot> getData() async {
    await Firebase.initializeApp();
    return await FirebaseFirestore.instance
        .collection("users")
        .where("email", isEqualTo: widget.email)
        .get();
  }
}




