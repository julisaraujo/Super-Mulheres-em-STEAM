import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:data_connection_checker/data_connection_checker.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:super_mulheres_steam/drawer/mydrawer.dart';
import 'package:super_mulheres_steam/login/user_model.dart';
import 'model_artigos.dart';

class Artigos extends StatefulWidget {
  Artigos({Key key, this.pageController, this.scaffoldkey}) : super(key: key);

  final PageController pageController;
  final GlobalKey<ScaffoldState> scaffoldkey;

  @override
  _ArtigosState createState() => _ArtigosState();
}

class _ArtigosState extends State<Artigos> {

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
          "Artigos",
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
        builder: (context, child, model) {
          if (!model.isLoggedIn()) {
            return Center(
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
          else {
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
                  return ListView.builder(
                      itemCount: snapshot.data.docs.length,
                      itemBuilder: (context, index) {
                        return ModelArtigos(
                          titulo: snapshot.data.docs[index]["titulo"],
                          resumo: snapshot.data.docs[index]["resumo"],
                          autores: snapshot.data.docs[index]["autores"],
                          link: snapshot.data.docs[index]["link"],
                        );
                      });
                }
              },
            );
          }
        },
      ),
    );
  }

  Future<QuerySnapshot> getData() async {
    await Firebase.initializeApp();
    return await FirebaseFirestore.instance.collection("artigos").get();
  }
}