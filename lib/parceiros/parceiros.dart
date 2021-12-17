import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:data_connection_checker/data_connection_checker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:super_mulheres_steam/drawer/mydrawer.dart';
import 'package:super_mulheres_steam/login/user_model.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:url_launcher/url_launcher.dart';

class Parceiros extends StatefulWidget {
  Parceiros({Key key, this.pageController, this.scaffoldkey}) : super(key: key);

  final PageController pageController;
  final GlobalKey<ScaffoldState> scaffoldkey;

  @override
  _ParceirosState createState() => _ParceirosState();
}

class _ParceirosState extends State<Parceiros> {

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
          "Projetos parceiros",
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
      body: ScopedModelDescendant<UserModel>(builder: (context, child, model) {
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
          return StreamBuilder<QuerySnapshot>(
              stream: FirebaseFirestore.instance
                  .collection("parceiros")
                  .snapshots(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting ||
                    snapshot.connectionState == ConnectionState.none) {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                } else {
                  List<DocumentSnapshot> documents =
                      snapshot.data.docs.toList();
                  return GridView.builder(
                      padding: EdgeInsets.all(10),
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          mainAxisSpacing: 10,
                          crossAxisSpacing: 10),
                      itemCount: documents.length,
                      itemBuilder: (context, index) {
                        return CardParceiros(
                          titulo: documents[index]["nome"],
                          imagem: documents[index]["image"],
                          descricao: documents[index]["descricao"],
                          contato: documents[index]["email"],
                          instagram: documents[index]["instagram"],
                          facebook: documents[index]["facebook"],
                        );
                      });
                }
              });
        }
      }),
    );
  }
}

class CardParceiros extends StatefulWidget {
  CardParceiros(
      {Key key,
      this.titulo,
      this.imagem,
      this.descricao,
      this.contato,
      this.instagram,
      this.facebook})
      : super(key: key);

  final String titulo;
  final String imagem;
  final String descricao;
  final String contato;
  final String instagram;
  final String facebook;

  @override
  _CardParceirosState createState() => _CardParceirosState();
}

class _CardParceirosState extends State<CardParceiros> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Material(
        elevation: 15,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        child: Container(
          padding: EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(15),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Expanded(
                child: Image.network(
                  widget.imagem,
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Text(
                widget.titulo,
                maxLines: 3,
                overflow: TextOverflow.ellipsis,
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 17,
                    color: Color.fromARGB(250, 61, 56, 150)),
              ),
            ],
          ),
        ),
      ),
      onTap: () {
        showModalBottomSheet(
            isScrollControlled: true,
            shape: RoundedRectangleBorder(
                borderRadius:
                BorderRadius.vertical(top: Radius.circular(25.0))),
            context: context,
            builder: (context) => Wrap(
              children: [
                Padding(
                  padding: EdgeInsets.all(10),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Container(
                        child: Text(
                          "${widget.titulo}",
                          textAlign: TextAlign.start,
                          style: TextStyle(
                              color: Color.fromARGB(250, 61, 56, 150),
                              fontWeight: FontWeight.bold,
                              fontSize: 25),
                        ),
                        alignment: Alignment.topLeft,
                        margin: EdgeInsets.all(5),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Divider(
                        color: Color.fromARGB(250, 61, 56, 150),
                        height: 0,
                      ),
                      Container(
                        height: MediaQuery.of(context).size.height * 0.3,
                        child: ListView(
                          padding: EdgeInsets.all(8.0),
                          children: [
                            Container(
                              alignment: Alignment.topLeft,
                              child: SelectableText(
                                widget.descricao,
                                textAlign: TextAlign.start,
                                style: TextStyle(
                                    color: Colors.black.withOpacity(0.7),
                                    fontSize: 14),
                              ),
                            ),
                          ],
                        ),
                      ),
                      widget.instagram == "" &&
                          widget.facebook == "" &&
                          widget.contato == ""
                          ? Container()
                          : Divider(
                        color: Color.fromARGB(250, 61, 56, 150),
                        height: 0,
                      ),
                      widget.instagram == "" &&
                          widget.facebook == "" &&
                          widget.contato == ""
                          ? Container()
                          : Container(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          crossAxisAlignment:
                          CrossAxisAlignment.center,
                          children: [
                            widget.instagram == ""
                                ? Container()
                                : IconButton(
                              icon: Icon(
                                FlutterIcons.instagram_ant,
                                color: Color.fromARGB(
                                    250, 61, 56, 150),
                              ),
                              onPressed: () async {
                                if (await canLaunch(
                                    widget.instagram)) {
                                  await launch(
                                    widget.instagram,
                                    forceSafariVC: false,
                                    forceWebView: false,
                                    headers: <String, String>{
                                      'my_header_key':
                                      'my_header_value'
                                    },
                                  );
                                } else {
                                  throw 'Could not launch ${widget.instagram}';
                                }
                              },
                            ),
                            widget.facebook == ""
                                ? Container()
                                : IconButton(
                              icon: Icon(
                                FlutterIcons.facebook_faw5d,
                                color: Color.fromARGB(
                                    250, 61, 56, 150),
                              ),
                              onPressed: () async {
                                if (await canLaunch(
                                    widget.facebook)) {
                                  await launch(
                                    widget.facebook,
                                    forceSafariVC: false,
                                    forceWebView: false,
                                    headers: <String, String>{
                                      'my_header_key':
                                      'my_header_value'
                                    },
                                  );
                                } else {
                                  throw 'Could not launch ${widget.facebook}';
                                }
                              },
                            ),
                            widget.contato == ""
                                ? Container()
                                : IconButton(
                              icon: Icon(
                                FlutterIcons.email_outline_mco,
                                color: Color.fromARGB(
                                    250, 61, 56, 150),
                              ),
                              onPressed: () async {
                                launch(
                                    "mailto:${widget.contato}?subject=${widget.titulo}&body= ");
                              },
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                )
              ],
            ));
      },
    );
  }
}
