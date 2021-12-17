import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:data_connection_checker/data_connection_checker.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:super_mulheres_steam/drawer/mydrawer.dart';
import 'package:super_mulheres_steam/login/user_model.dart';
import 'package:super_mulheres_steam/newsletter/model_comment.dart';
import 'package:super_mulheres_steam/newsletter/model_like.dart';
import 'package:scoped_model/scoped_model.dart';

import 'model_newsletter.dart';

class Newsletter extends StatefulWidget {
  Newsletter({Key key, this.pageController, this.scaffoldkey})
      : super(key: key);

  final PageController pageController;
  final GlobalKey<ScaffoldState> scaffoldkey;

  @override
  _NewsletterState createState() => _NewsletterState();
}

class _NewsletterState extends State<Newsletter> {

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
    return DefaultTabController(
      length: 2,
      child: Scaffold(
          key: widget.scaffoldkey,
          drawer: DrawerBody(widget.pageController),
          appBar: AppBar(
            backgroundColor: Color.fromARGB(250, 61, 56, 150),
            title: Text(
              "Newsletters",
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
            bottom: TabBar(
              indicatorWeight: 2.5,
              unselectedLabelColor: Colors.white,
              labelColor: Colors.white,
              indicatorSize: TabBarIndicatorSize.tab,
              indicatorColor: Colors.white,
              tabs: [
                Tab(
                    child: Container(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            FlutterIcons.newspaper_mco,
                            color: Colors.white,
                          ),
                          SizedBox(
                            width: 5,
                          ),
                          Text(
                            "Últimas",
                            maxLines: 2,
                            textAlign: TextAlign.center,
                            style: TextStyle(color: Colors.white),
                          )
                        ],
                      ),
                    )),
                Tab(
                    child: Container(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.local_fire_department_outlined,
                            color: Colors.white,
                          ),
                          SizedBox(
                            width: 5,
                          ),
                          Text(
                            "Mais lidas",
                            maxLines: 2,
                            textAlign: TextAlign.center,
                            style: TextStyle(color: Colors.white),
                          )
                        ],
                      ),
                    )),
              ],
            ),
          ),
          body: TabBarView(
            children: [
              ScopedModelDescendant<UserModel>(
                  builder: (context, child, model){
                    if (!model.isLoggedIn()) {
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
                    else {
                      return Container(
                      color: Colors.white,
                      child: FutureBuilder<QuerySnapshot>(
                          future: getData(),
                          builder: (context, snapshot){
                            if (!snapshot.hasData)
                              return Center(
                                child: CircularProgressIndicator(
                                  valueColor: AlwaysStoppedAnimation<Color>(
                                      Color.fromARGB(250, 61, 56, 150)),
                                ),
                              );
                            else {
                              return ListView.builder(
                                  padding: EdgeInsets.only(
                                      top: 5
                                  ),
                                  itemCount: snapshot.data.docs.length,
                                  itemBuilder: (context, index){
                                    return ModelNews(
                                      cabecalho:snapshot.data.docs[index]["cabecalho"],
                                      titulo:snapshot.data.docs[index]["titulo"],
                                      data:snapshot.data.docs[index]["data"].toDate(),
                                      text1:snapshot.data.docs[index]["text1"].replaceAll("\\n", "\n"),
                                      image1:snapshot.data.docs[index]["image1"],
                                      text2:snapshot.data.docs[index]["text2"].replaceAll("\\n", "\n"),
                                      image2:snapshot.data.docs[index]["image2"],
                                      text3:snapshot.data.docs[index]["text3"].replaceAll("\\n", "\n"),
                                      indice: snapshot.data.docs[index]["indice"],
                                      like: LikeNewsletter(
                                        indice: snapshot.data.docs[index]["indice"],
                                      ),
                                      comment: CommentNewsletter(
                                        indice: snapshot.data.docs[index]["indice"],
                                      ),
                                    );
                                  });
                            }
                          }),
                    );
                    }
                  }),
              ScopedModelDescendant<UserModel>(
                  builder: (context, child, model){
                    if (!model.isLoggedIn()) {
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
                    else {
                      return Container(
                      color: Colors.white,
                      child: FutureBuilder<QuerySnapshot>(
                          future: getDataMore(),
                          builder: (context, snapshot){
                            if (!snapshot.hasData)
                              return Center(
                                child: CircularProgressIndicator(
                                  valueColor: AlwaysStoppedAnimation<Color>(
                                      Color.fromARGB(250, 61, 56, 150)),
                                ),
                              );
                            else {
                              return ListView.builder(
                                  padding: EdgeInsets.only(
                                      top: 5
                                  ),
                                  itemCount: snapshot.data.docs.length,
                                  itemBuilder: (context, index){
                                    return ModelNews(
                                      cabecalho:snapshot.data.docs[index]["cabecalho"],
                                      titulo:snapshot.data.docs[index]["titulo"],
                                      data:snapshot.data.docs[index]["data"].toDate(),
                                      text1:snapshot.data.docs[index]["text1"].replaceAll("\\n", "\n"),
                                      image1:snapshot.data.docs[index]["image1"],
                                      text2:snapshot.data.docs[index]["text2"].replaceAll("\\n", "\n"),
                                      image2:snapshot.data.docs[index]["image2"],
                                      text3:snapshot.data.docs[index]["text3"].replaceAll("\\n", "\n"),
                                      like: LikeNewsletter(
                                        indice: snapshot.data.docs[index]["indice"],
                                      ),
                                      comment: CommentNewsletter(
                                        indice: snapshot.data.docs[index]["indice"],
                                      ),
                                      indice: snapshot.data.docs[index]["indice"],
                                    );
                                  });
                            }
                          }),
                    );
                    }
                  })
            ],
          )
      ),
    );
  }

  Future<QuerySnapshot> getData() async {
    await Firebase.initializeApp();
    return await FirebaseFirestore.instance
        .collection("newsletter").orderBy("data", descending: true)
        .get();
  }

  Future<QuerySnapshot> getDataMore() async {
    await Firebase.initializeApp();
    return await FirebaseFirestore.instance
        .collection("newsletter").orderBy("numberlikes", descending: true)
        .get();
  }

}