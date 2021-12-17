import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:data_connection_checker/data_connection_checker.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:super_mulheres_steam/drawer/mydrawer.dart';
import 'package:super_mulheres_steam/forum/composer.dart';
import 'package:super_mulheres_steam/forum/message_body.dart';
import 'package:super_mulheres_steam/login/user_model.dart';
import 'package:scoped_model/scoped_model.dart';

class Forum extends StatefulWidget {
  Forum({Key key, this.pageController, this.scaffoldkey}) : super(key: key);

  final PageController pageController;
  final GlobalKey<ScaffoldState> scaffoldkey;

  @override
  _ForumState createState() => _ForumState();
}

class _ForumState extends State<Forum> {

  FocusNode internfocus= FocusNode();

  bool check;
  StreamSubscription<DataConnectionStatus> listener;
  String teste;

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
    return Container(
      color: Color.fromARGB(250, 61, 56, 150),
      child: SafeArea(
        child: Scaffold(
            key: widget.scaffoldkey,
            drawer: DrawerBody(widget.pageController),
            body: ScopedModelDescendant<UserModel>(
              builder: (context, child, model) {
                if (!model.isLoggedIn()) {
                  return Scaffold(
                    appBar: AppBar(
                      backgroundColor: Color.fromARGB(250, 61, 56, 150),
                      leading: IconButton(
                        icon: Icon(
                          Icons.menu,
                          size: 25,
                          color: Colors.white,
                        ),
                        onPressed: () =>
                            widget.scaffoldkey.currentState.openDrawer(),
                      ),
                      title: Text(
                        "Assunto do momento",
                        style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 18),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    body: Center(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            width: MediaQuery.of(context).size.width * 0.75,
                            child: Text(
                              "Para acessar esse conteúdo é necessário que você faça login em sua conta",
                              style: TextStyle(
                                  color: Colors.black.withOpacity(0.5),
                                  fontWeight: FontWeight.bold,
                                  fontSize: 15),
                              textAlign: TextAlign.center,
                            ),
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          Icon(
                            Icons.login,
                            color: Colors.black.withOpacity(0.5),
                            size: 35,
                          )
                        ],
                      ),
                    ),
                  );
                }
                else if (check == false){
                  return Scaffold(
                    appBar: AppBar(
                      elevation: 0,
                      backgroundColor: Color.fromARGB(250, 61, 56, 150),
                      leading: IconButton(
                        icon: Icon(
                          Icons.menu,
                          size: 25,
                          color: Colors.white,
                        ),
                        onPressed: () =>
                            widget.scaffoldkey.currentState.openDrawer(),
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
                  );
                }
                else {
                  return Column(
                    children: [
                      FutureBuilder(
                          future: getData(),
                          builder: (context, snapshot2){
                            if(!snapshot2.hasData){
                              return Container(
                                  color: Color.fromARGB(250, 61, 56, 150),
                                  child: ExpansionTile(
                                    tilePadding: EdgeInsets.only(left: 5, right: 10),
                                    leading: IconButton(
                                      icon: Icon(
                                        Icons.menu,
                                        size: 25,
                                        color: Colors.white,
                                      ),
                                      onPressed: () =>
                                          widget.scaffoldkey.currentState.openDrawer(),
                                    ),
                                    trailing: Icon(
                                      Icons.info_outline,
                                      color: Colors.white,
                                    ),
                                    title: Text(
                                      "Assunto do Momento",
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 18),
                                      textAlign: TextAlign.center,
                                    ),
                                    children: [
                                      Padding(
                                        padding: EdgeInsets.all(15),
                                        child: Text(
                                          "Seja bem-vindo a nossa roda de conversa",
                                          textAlign: TextAlign.justify,
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontWeight: FontWeight.bold),
                                        ),
                                      )
                                    ],
                                  ));
                            }
                            else{
                              return Container(
                                  color: Color.fromARGB(250, 61, 56, 150),
                                  child: ExpansionTile(
                                    tilePadding: EdgeInsets.only(left: 5, right: 10),
                                    leading: IconButton(
                                      icon: Icon(
                                        Icons.menu,
                                        size: 25,
                                        color: Colors.white,
                                      ),
                                      onPressed: () =>
                                          widget.scaffoldkey.currentState.openDrawer(),
                                    ),
                                    trailing: Icon(
                                      Icons.info_outline,
                                      color: Colors.white,
                                    ),
                                    title: Text(
                                      "${snapshot2.data.docs[0]["titulo"]}",
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 18),
                                      textAlign: TextAlign.center,
                                    ),
                                    children: [
                                      Padding(
                                        padding: EdgeInsets.all(15),
                                        child: Text(
                                          snapshot2.data.docs[0]["subtitulo"],
                                          textAlign: TextAlign.justify,
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontWeight: FontWeight.bold),
                                        ),
                                      )
                                    ],
                                  ));
                            }
                          }),
                      Expanded(
                          child: StreamBuilder<QuerySnapshot>(
                        stream: FirebaseFirestore.instance
                            .collection("users")
                            .snapshots(),
                        builder: (context, snapshotvalid) {
                          switch (snapshotvalid.connectionState) {
                            case ConnectionState.waiting:
                            case ConnectionState.none:
                              return Center(
                                child: CircularProgressIndicator(),
                              );
                            default:
                              List<DocumentSnapshot> documentsvalid =
                                  snapshotvalid.data.docs.reversed.toList();
                              return StreamBuilder<QuerySnapshot>(
                                stream: FirebaseFirestore.instance
                                    .collection("forum")
                                    .orderBy("time")
                                    .snapshots(),
                                builder: (context, snapshot) {
                                  switch (snapshot.connectionState) {
                                    case ConnectionState.waiting:
                                    case ConnectionState.none:
                                      return Center(
                                        child: CircularProgressIndicator(),
                                      );
                                    default:
                                      List<DocumentSnapshot> documents =
                                      snapshot.data.docs.reversed.toList();
                                      return ListView.builder(
                                          itemCount: documents.length,
                                          reverse: true,
                                          itemBuilder: (context, index) {
                                            if(documentsvalid.where((documentsvalid) => documentsvalid["email"] == documents[index]["email"]).length == 1){
                                              return
                                                MessageBody(
                                                  email: documents[index]["email"],
                                                  text: documents[index]["text"],
                                                  mine: documents[index]["email"] ==
                                                      model.userData["email"]
                                                      ? true
                                                      : false,
                                                  id: documents[index]["id"],
                                                  time: documents[index]["time"] == null ? DateTime.now() : documents[index]["time"].toDate(),
                                                  focus: internfocus,
                                                  nome: documentsvalid.where((documentsvalid) => documentsvalid["email"] == documents[index]["email"]).toList()[0]["nome"],
                                                  foto: documentsvalid.where((documentsvalid) => documentsvalid["email"] == documents[index]["email"]).toList()[0]["foto"],
                                                );
                                            }
                                            else {
                                              return Container();
                                            }
                                          });
                                  }
                                },
                              );
                          }
                        },
                      )),
                      Composer((String text) {
                        Map<String, dynamic> data = {};

                        if (text != null) data["text"] = text;
                        data["time"] = FieldValue.serverTimestamp();
                        if (model.isLoggedIn())
                          data["email"] = model.userData["email"];
                        if (model.isLoggedIn())
                          data["id"] = "${model.firebaseUser.uid}";

                        FirebaseFirestore.instance
                            .collection("forum")
                            .add(data);

                        FirebaseFirestore.instance.collection("users").doc(model.firebaseUser.uid).collection("forum").doc("${DateTime.now()}").set({
                          "time": FieldValue.serverTimestamp()
                        });
                      }, internfocus),
                    ],
                  );
                }
              },
            )),
      ),
    );
  }

  Future<QuerySnapshot> getData() async {
    await Firebase.initializeApp();
    return await FirebaseFirestore.instance
        .collection("forumaviso")
        .get();
  }

}