import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:data_connection_checker/data_connection_checker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:super_mulheres_steam/drawer/mydrawer.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:super_mulheres_steam/login/user_model.dart';
import 'package:super_mulheres_steam/quadro_de_avisos/model_avisos.dart';
import 'package:scoped_model/scoped_model.dart';

class Quadro extends StatefulWidget {
  Quadro({Key key, this.pageController, this.scaffoldkey}) : super(key: key);

  final PageController pageController;
  final GlobalKey<ScaffoldState> scaffoldkey;

  @override
  _QuadroState createState() => _QuadroState();
}

class _QuadroState extends State<Quadro> {

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
    return Scaffold(
        key: widget.scaffoldkey,
        drawer: DrawerBody(widget.pageController),
        appBar: AppBar(
          backgroundColor: Color.fromARGB(250, 61, 56, 150),
          title: Text(
            "Avisos e eventos",
            style: TextStyle(color: Colors.white),
          ),
          leading: IconButton(
            icon: Icon(
              Icons.menu,
              size: 25,
              color: Colors.white,
            ),
            onPressed: () => widget.scaffoldkey.currentState.openDrawer(),
          ),
        ),
        body: ScopedModelDescendant<UserModel>(
          builder: (context, child, model){
            if(!model.isLoggedIn()){
              return Center(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      width: MediaQuery.of(context).size.width*0.75,
                      child: Text(
                        "Para acessar esse conteúdo é necessário que você faça login em sua conta",
                        style: TextStyle(
                            color: Colors.black.withOpacity(0.5),
                            fontWeight:
                            FontWeight
                                .bold,
                            fontSize: 15),
                        textAlign: TextAlign.center,),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Icon(Icons.login,
                      color: Colors.black.withOpacity(0.5),
                      size: 35,)
                  ],
                ),
              );
            }
            else if (check == false){
              return Scaffold(
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
            else{
              return FutureBuilder<QuerySnapshot>(
                future: getData(),
                builder: (context, snapshot) {
                  if (!snapshot.hasData)
                    return Center(
                      child: CircularProgressIndicator(
                        valueColor: AlwaysStoppedAnimation<Color>(
                            Color.fromARGB(250, 61, 56, 150)),
                      ),
                    );
                  else {
                    return GridView.builder(
                        padding: EdgeInsets.all(10),
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            mainAxisSpacing: 10,
                            crossAxisSpacing: 10),
                        itemCount: snapshot.data.docs.length,
                        itemBuilder: (context, index) {
                          return ModelAvisos(
                            imagem: snapshot.data.docs[index]["imagem"],
                            data: snapshot.data.docs[index]["data"].toDate(),
                            titulo: snapshot.data.docs[index]["titulo"],
                            subtitulo: snapshot.data.docs[index]["subtitulo"].replaceAll("\\n", "\n"),
                            link: snapshot.data.docs[index]["link"],
                          );
                        });
                  }
                },
              );
            }
          },
        ));
  }

  Future<QuerySnapshot> getData() async {
    await Firebase.initializeApp();
    return await FirebaseFirestore.instance
        .collection("avisos")
        .orderBy("data", descending: true)
        .get();
  }
}
