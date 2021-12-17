import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:super_mulheres_steam/login/user_model.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:url_launcher/url_launcher.dart';

class FaleConosco extends StatefulWidget {
  @override
  _FaleConoscoState createState() => _FaleConoscoState();
}

class _FaleConoscoState extends State<FaleConosco> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromARGB(250, 61, 56, 150),
        title: Text(
          "Fale conosco",
          style: TextStyle(color: Colors.white),
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
          } else {
            return Container(
              color: Colors.white,
              child: StreamBuilder<QuerySnapshot>(
                stream: FirebaseFirestore.instance
                    .collection("redessociais")
                    .snapshots(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting ||
                      snapshot.connectionState == ConnectionState.none) {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                  else{
                    return ListView(
                      padding: EdgeInsets.only(left: 5),
                      children: [
                        Container(
                          color: Colors.transparent,
                          alignment: Alignment.centerLeft,
                          padding:
                          EdgeInsets.symmetric(vertical: 15, horizontal: 10),
                          child: Text(
                            "Siga nossas redes sociais",
                            maxLines: 2,
                            textAlign: TextAlign.start,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                                color: Color.fromARGB(250, 61, 56, 150),
                                fontWeight: FontWeight.bold,
                                fontSize: 25),
                          ),
                        ),
                        CircularRedes(
                          icone: FlutterIcons.facebook_faw5d,
                          color: Colors.blue,
                          link: !snapshot.hasData
                              ? "http://super.ufam.edu.br/"
                              : snapshot.data.docs[0]["link"],
                          nome: snapshot.data.docs[0]["nome"],
                        ),
                        CircularRedes(
                          icone: FlutterIcons.instagram_ant,
                          color: Colors.deepOrangeAccent,
                          link: !snapshot.hasData
                              ? "http://super.ufam.edu.br/"
                              : snapshot.data.docs[1]["link"],
                          nome: snapshot.data.docs[1]["nome"],
                        ),
                        CircularRedes(
                          icone: FlutterIcons.linkedin_square_ant,
                          color: Colors.blue,
                          link: !snapshot.hasData
                              ? "http://super.ufam.edu.br/"
                              : snapshot.data.docs[2]["link"],
                          nome: snapshot.data.docs[2]["nome"],
                        ),
                        CircularRedes(
                          icone: FlutterIcons.youtube_ant,
                          color: Colors.red,
                          link: !snapshot.hasData
                              ? "http://super.ufam.edu.br/"
                              : snapshot.data.docs[3]["link"],
                          nome: snapshot.data.docs[3]["nome"],
                        ),
                        CircularRedes(
                          icone: FlutterIcons.twitter_ant,
                          color: Colors.blue,
                          link: !snapshot.hasData
                              ? "http://super.ufam.edu.br/"
                              : snapshot.data.docs[4]["link"],
                          nome: snapshot.data.docs[4]["nome"],
                        ),
                        CircularRedes(
                          icone: FlutterIcons.web_mco,
                          color: Colors.green,
                          link: !snapshot.hasData
                              ? "http://super.ufam.edu.br/"
                              : snapshot.data.docs[5]["link"],
                          nome: snapshot.data.docs[5]["nome"],
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Container(
                          color: Colors.transparent,
                          alignment: Alignment.centerLeft,
                          padding:
                          EdgeInsets.symmetric(vertical: 15, horizontal: 10),
                          child: Text(
                            "Entre em contato através de nossos emails",
                            maxLines: 2,
                            textAlign: TextAlign.start,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                                color: Color.fromARGB(250, 61, 56, 150),
                                fontWeight: FontWeight.bold,
                                fontSize: 25),
                          ),
                        ),
                        CircularRedesEmail(
                          icone: FlutterIcons.email_outline_mco,
                          color: Color.fromARGB(250, 61, 56, 150),
                          link: !snapshot.hasData
                              ? "http://super.ufam.edu.br/"
                              : snapshot.data.docs[6]["link"],
                          nome: snapshot.data.docs[6]["nome"],
                        ),
                        CircularRedesEmail(
                          icone: FlutterIcons.email_outline_mco,
                          color: Color.fromARGB(250, 61, 56, 150),
                          link: !snapshot.hasData
                              ? "http://super.ufam.edu.br/"
                              : snapshot.data.docs[7]["link"],
                          nome: snapshot.data.docs[7]["nome"],
                        ),
                      ],
                    );
                  }
                },
              ),
            );
          }
        },
      ),
    );
  }
}

class CircularRedes extends StatefulWidget {
  CircularRedes({Key key, this.icone, this.color, this.link, this.nome})
      : super(key: key);

  final IconData icone;
  final Color color;
  final String link;
  final String nome;

  @override
  _CircularRedesState createState() => _CircularRedesState();
}

class _CircularRedesState extends State<CircularRedes> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ListTile(
          leading: Icon(
            widget.icone,
            color: widget.color,
          ),
          title: Text(
            widget.nome,
            style: TextStyle(
                color: Color.fromARGB(250, 61, 56, 150),
                fontSize: 17,
                fontWeight: FontWeight.bold),
          ),
          subtitle: SelectableText(
            widget.link,
            style: TextStyle(
              color: Color.fromARGB(250, 61, 56, 150),
              fontSize: 13,
            ),
          ),
          onTap: () async {
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
        Divider(
          color: Color.fromARGB(250, 61, 56, 150),
          height: 0,
          indent: 10,
          endIndent: 10,
        )
      ],
    );
  }
}

class CircularRedesEmail extends StatefulWidget {
  CircularRedesEmail({Key key, this.icone, this.color, this.link, this.nome})
      : super(key: key);

  final IconData icone;
  final Color color;
  final String link;
  final String nome;

  @override
  _CircularRedesEmailState createState() => _CircularRedesEmailState();
}

class _CircularRedesEmailState extends State<CircularRedesEmail> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ListTile(
          leading: Icon(
            widget.icone,
            color: widget.color,
          ),
          title: Text(
            widget.nome,
            style: TextStyle(
                color: Color.fromARGB(250, 61, 56, 150),
                fontSize: 17,
                fontWeight: FontWeight.bold),
          ),
          subtitle: SelectableText(
            widget.link,
            style: TextStyle(
              color: Color.fromARGB(250, 61, 56, 150),
              fontSize: 13,
            ),
          ),
          onTap: () async {
            launch("mailto:${widget.link}?subject=${widget.nome}&body= ");
          },
        ),
        Divider(
          color: Color.fromARGB(250, 61, 56, 150),
          height: 0,
          indent: 10,
          endIndent: 10,
        )
      ],
    );
  }
}
