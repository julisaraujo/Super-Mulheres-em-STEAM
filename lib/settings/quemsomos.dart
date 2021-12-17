import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:super_mulheres_steam/login/user_model.dart';
import 'package:photo_view/photo_view.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:url_launcher/url_launcher.dart';

class QuemSomos extends StatefulWidget {

  @override
  _QuemSomosState createState() => _QuemSomosState();
}

class _QuemSomosState extends State<QuemSomos> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromARGB(250, 61, 56, 150),
        title: Text(
          "Quem somos",
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: ScopedModelDescendant<UserModel>(
        builder: (context, child, model) {

          Widget errowidget = Padding(
            padding: EdgeInsets.all(10),
            child: Material(
              elevation: 5,
              shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
              child: Container(
                height: 90,
                margin: EdgeInsets.all(10),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: Colors.white,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      margin: EdgeInsets.symmetric(
                          vertical: 5
                      ),
                      decoration: BoxDecoration(
                          gradient: LinearGradient(
                              colors: [
                                Colors.grey.shade300,
                                Colors.grey.shade200,
                              ]
                          )
                      ),
                      height: 20,
                      width: MediaQuery.of(context).size.width*0.5,
                    ),
                    Container(
                      margin: EdgeInsets.symmetric(
                          vertical: 5
                      ),
                      decoration: BoxDecoration(
                          gradient: LinearGradient(
                              colors: [
                                Colors.grey.shade300,
                                Colors.grey.shade200,
                              ]
                          )
                      ),
                      height: 20,
                      width: MediaQuery.of(context).size.width,
                    ),
                    Container(
                      margin: EdgeInsets.symmetric(
                          vertical: 5
                      ),
                      decoration: BoxDecoration(
                          gradient: LinearGradient(
                              colors: [
                                Colors.grey.shade300,
                                Colors.grey.shade200,
                              ]
                          )
                      ),
                      height: 20,
                      width: MediaQuery.of(context).size.width,
                    ),
                  ],
                ),
              ),
            ),
          );

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
          } else {
            return Container(
              color: Colors.white,
              child: ListView(
                padding: EdgeInsets.all(5),
                children: [
                  Container(
                    color: Colors.transparent,
                    height: 70,
                    alignment: Alignment.centerLeft,
                    padding: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                    child: Text(
                      "SUPER",
                      maxLines: 2,
                      textAlign: TextAlign.start,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                          color: Color.fromARGB(250, 61, 56, 150),
                          fontWeight: FontWeight.bold,
                          fontSize: 25),
                    ),
                  ),
                  StreamBuilder<QuerySnapshot>(
                    stream: FirebaseFirestore.instance
                        .collection("quemsomos")
                        .snapshots(),
                    builder: (context, snapshot) {
                      switch (snapshot.connectionState) {
                        case ConnectionState.waiting:
                        case ConnectionState.none:
                          return errowidget;
                        default:
                          List<DocumentSnapshot> documents =
                          snapshot.data.docs.reversed.toList();
                          return Padding(
                            padding: const EdgeInsets.all(5),
                            child: Material(
                                elevation: 14,
                                shape:
                                RoundedRectangleBorder(borderRadius: BorderRadius.circular(35)),
                              child: Container(
                                padding: EdgeInsets.all(15),
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(35)),
                                child: Text(
                                  documents[0]["super"],
                                  textAlign: TextAlign.justify,
                                  style: TextStyle(
                                      color: Color.fromARGB(250, 61, 56, 150),
                                      fontWeight: FontWeight.bold,
                                      fontSize: 14),
                                ),
                              ),
                            ),
                          );
                      }
                    },
                  ),
                  Container(
                    color: Colors.transparent,
                    height: 70,
                    alignment: Alignment.centerLeft,
                    padding: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                    child: Text(
                      "Mulheres em STEAM",
                      maxLines: 2,
                      textAlign: TextAlign.start,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                          color: Color.fromARGB(250, 61, 56, 150),
                          fontWeight: FontWeight.bold,
                          fontSize: 25),
                    ),
                  ),
                  StreamBuilder<QuerySnapshot>(
                    stream: FirebaseFirestore.instance
                        .collection("quemsomos")
                        .snapshots(),
                    builder: (context, snapshot) {
                      switch (snapshot.connectionState) {
                        case ConnectionState.waiting:
                        case ConnectionState.none:
                          return errowidget;
                        default:
                          List<DocumentSnapshot> documents =
                          snapshot.data.docs.reversed.toList();
                          return Padding(
                            padding: const EdgeInsets.all(5),
                            child: Material(
                              elevation: 14,
                              shape:
                              RoundedRectangleBorder(borderRadius: BorderRadius.circular(35)),
                              child: Container(
                                padding: EdgeInsets.all(15),
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(35),
                                    ),
                                child: Text(
                                  documents[0]["mulheressteam"],
                                  textAlign: TextAlign.justify,
                                  style: TextStyle(
                                      color: Color.fromARGB(250, 61, 56, 150),
                                      fontWeight: FontWeight.bold,
                                      fontSize: 14),
                                ),
                              ),
                            ),
                          );
                      }
                    },
                  ),
                  Container(
                    color: Colors.transparent,
                    height: 70,
                    alignment: Alignment.centerLeft,
                    padding: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                    child: Text(
                      "Coordenadora e bolsistas",
                      maxLines: 2,
                      textAlign: TextAlign.start,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                          color: Color.fromARGB(250, 61, 56, 150),
                          fontWeight: FontWeight.bold,
                          fontSize: 25),
                    ),
                  ),
                  Container(
                    child: StreamBuilder<QuerySnapshot>(
                      stream: FirebaseFirestore.instance
                          .collection("quemsomos")
                          .doc("0")
                          .collection("integrantes")
                          .snapshots(),
                      builder: (context, snapshot) {
                        switch (snapshot.connectionState) {
                          case ConnectionState.waiting:
                          case ConnectionState.none:
                            return errowidget;
                          default:
                            List<DocumentSnapshot> documents =
                            snapshot.data.docs.toList();
                            return ListView.builder(
                                itemCount: documents.length,
                                shrinkWrap: true,
                                physics: NeverScrollableScrollPhysics(),
                                itemBuilder: (context, index) {
                                  return Integrantes(
                                    documents[index]["nome"],
                                    documents[index]["cargo"],
                                    documents[index]["descrição"],
                                    documents[index]["foto"],
                                    documents[index]["tempo"],
                                  );
                                });
                        }
                      },
                    ),
                  ),
                ],
              ),
            );
          }
        },
      ),
    );
  }
}

class Integrantes extends StatelessWidget {
  final String nome;
  final String cargo;
  final String descricao;
  final String foto;
  final String tempo;

  Integrantes(this.nome, this.cargo, this.descricao, this.foto, this.tempo);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(5),
      child: Material(
          elevation: 14,
          shape:
          RoundedRectangleBorder(borderRadius: BorderRadius.circular(35)),
        child: Container(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(35),),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(35),
              child: ExpansionTile(
                leading: GestureDetector(
                  child: Container(
                    margin: EdgeInsets.all(5),
                    width: 50,
                    height: 50,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.white,
                      image: DecorationImage(
                          fit: BoxFit.cover, image: NetworkImage(foto)),
                    ),
                  ),
                  onTap: () {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => SafeArea(
                          child: Scaffold(
                            body: Container(
                                width: MediaQuery.of(context).size.width,
                                height: MediaQuery.of(context).size.height,
                                child: Stack(
                                  children: [
                                    Container(
                                      child: PhotoView(
                                          imageProvider: NetworkImage(foto)),
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
                ),
                trailing: Icon(Icons.keyboard_arrow_down_sharp,
                    color: Color.fromARGB(250, 61, 56, 150)),
                backgroundColor: Colors.grey.withOpacity(0),
                title: Text(
                  nome,
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 17,
                      color: Color.fromARGB(250, 61, 56, 150)),
                ),
                subtitle: Text(
                  cargo,
                  style: TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: 14,
                      color: Color.fromARGB(250, 61, 56, 150)),
                ),
                children: [
                  Container(
                      margin: EdgeInsets.symmetric(horizontal: 20),
                      color: Colors.transparent,
                      alignment: Alignment.topLeft,
                      child: Text(
                        tempo,
                        textAlign: TextAlign.justify,
                        style: TextStyle(
                          color: Colors.black.withOpacity(0.5),
                          fontWeight: FontWeight.w500,
                          fontSize: 14,
                        ),
                      )),
                  SizedBox(
                    height: 10,
                  ),
                  Container(
                      margin: EdgeInsets.symmetric(horizontal: 20),
                      color: Colors.transparent,
                      child: Text(
                        descricao,
                        textAlign: TextAlign.justify,
                        style: TextStyle(
                          color: Color.fromARGB(250, 61, 56, 150),
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                        ),
                      )),
                  SizedBox(
                    height: 10,
                  )
                ],
              ),
            )),
      ),
    );
  }
}

class CircularRedes extends StatefulWidget {
  CircularRedes({Key key, this.icone, this.color, this.link}) : super(key: key);

  final IconData icone;
  final Color color;
  final String link;

  @override
  _CircularRedesState createState() => _CircularRedesState();
}

class _CircularRedesState extends State<CircularRedes> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 70,
      height: 70,
      margin: EdgeInsets.all(5),
      decoration: BoxDecoration(
          color: Colors.grey.withOpacity(0.2), shape: BoxShape.circle),
      child: IconButton(
        icon: Icon(
          widget.icone,
          color: widget.color,
        ),
        onPressed: () async {
          if (await canLaunch(widget.link)) {
            await launch(
              widget.link,
              forceSafariVC: false,
              forceWebView: false,
              headers: <String, String>{'my_header_key': 'my_header_value'},
            );
          } else {
            throw 'Could not launch ${widget.link}';
          }
        },
      ),
    );
  }
}
