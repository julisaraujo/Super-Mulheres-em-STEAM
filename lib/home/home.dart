import 'package:carousel_slider/carousel_slider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:super_mulheres_steam/drawer/mydrawer.dart';
import 'package:super_mulheres_steam/home/info_profile.dart';
import 'package:super_mulheres_steam/home/model_newsletter_home.dart';
import 'package:super_mulheres_steam/indicacoes/model_avaliacaoindicacao.dart';
import 'package:super_mulheres_steam/indicacoes/model_indicacoes.dart';
import 'package:super_mulheres_steam/indicacoes/model_nota.dart';
import 'package:super_mulheres_steam/login/user_model.dart';
import 'package:super_mulheres_steam/newsletter/model_comment.dart';
import 'package:super_mulheres_steam/newsletter/model_like.dart';
import 'package:super_mulheres_steam/quadro_de_avisos/model_avisos.dart';
import 'package:photo_view/photo_view.dart';
import 'package:scoped_model/scoped_model.dart';

class Home extends StatefulWidget {
  Home({Key key, this.pageController, this.scaffoldkey}) : super(key: key);

  final PageController pageController;
  final GlobalKey<ScaffoldState> scaffoldkey;

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Color.fromARGB(250, 7, 176, 217),
      child: SafeArea(
        child: Scaffold(
          key: widget.scaffoldkey,
          drawer: DrawerBody(widget.pageController),
          body: CustomScrollView(
            slivers: [
              SliverAppBar(
                pinned: false,
                snap: false,
                floating: false,
                leading: IconButton(
                  icon: Icon(
                    Icons.menu,
                    size: 25,
                    color: Colors.white,
                  ),
                  onPressed: () => widget.scaffoldkey.currentState.openDrawer(),
                ),
                expandedHeight: 280,
                flexibleSpace: FlexibleSpaceBar(
                  background: Container(
                    decoration: BoxDecoration(
                        gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        Color.fromARGB(250, 7, 176, 217),
                        Color.fromARGB(250, 61, 56, 150)
                      ],
                    )),
                    child: ScopedModelDescendant<UserModel>(
                      builder: (context, child, model) {
                        if (!model.isLoggedIn()) {
                          return Center(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(
                                  FlutterIcons.emoticon_sad_outline_mco,
                                  color: Colors.white.withOpacity(0.5),
                                  size: 50,
                                ),
                                SizedBox(
                                  height: 15,
                                ),
                                Container(
                                  width: MediaQuery.of(context).size.width * 0.75,
                                  child: Text(
                                    "Para visualizar seu perfil é necessário que faça login em sua conta",
                                    style: TextStyle(
                                        color: Colors.white.withOpacity(0.6),
                                        fontWeight: FontWeight.bold,
                                        fontSize: 15),
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                              ],
                            ),
                          );
                        } else {
                          return StreamBuilder<QuerySnapshot>(
                            stream: FirebaseFirestore.instance
                                .collection("users").where("email", isEqualTo: model.firebaseUser.email).snapshots(),
                            builder: (context, snapshotdados) {
                              return Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Container(
                                      child: GestureDetector(
                                        child: Container(
                                          margin: EdgeInsets.only(top: 20),
                                          width: 100,
                                          height: 100,
                                          decoration: BoxDecoration(
                                            color: Colors.white,
                                            boxShadow: <BoxShadow>[
                                              BoxShadow(
                                                  color: Colors.deepOrangeAccent,
                                                  blurRadius: 50,
                                                  offset: Offset(0.0, 5.0))
                                            ],
                                            shape: BoxShape.circle,
                                            image: DecorationImage(
                                                fit: BoxFit.cover,
                                                image: snapshotdados.connectionState == ConnectionState.waiting ||
                                                    snapshotdados.connectionState == ConnectionState.none
                                                    ? AssetImage(
                                                        "assets/avatar/avatar.png")
                                                    : NetworkImage(
                                                        "${snapshotdados.data.docs[0]["foto"]}")),
                                          ),
                                          alignment: Alignment.center,
                                        ),
                                        onTap: (){
                                          Navigator.of(context).push(MaterialPageRoute(
                                              builder: (context) => SafeArea(
                                                child: Scaffold(
                                                  body: Container(
                                                      width:
                                                      MediaQuery.of(context).size.width,
                                                      height:
                                                      MediaQuery.of(context).size.height,
                                                      child: Stack(
                                                        children: [
                                                          Container(
                                                            child: PhotoView(
                                                                imageProvider: snapshotdados.connectionState == ConnectionState.waiting ||
                                                                    snapshotdados.connectionState == ConnectionState.none
                                                                    ? AssetImage(
                                                                    "assets/avatar/avatar.png")
                                                                    : NetworkImage(
                                                                    "${snapshotdados.data.docs[0]["foto"]}")),
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
                                                                      Icons
                                                                          .arrow_back_outlined,
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
                                      snapshotdados.connectionState == ConnectionState.waiting ||
                                          snapshotdados.connectionState == ConnectionState.none
                                          ? ""
                                          : snapshotdados.data.docs[0]["nome"],
                                      maxLines: 2,
                                      textAlign: TextAlign.center,
                                      overflow: TextOverflow.ellipsis,
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 18),
                                    ),
                                  ),
                                  InfoProfile()
                                ],
                              );
                            }
                          );
                        }
                      },
                    ),
                  ),
                ),
              ),
              ScopedModelDescendant<UserModel>(builder: (context, child, model) {
                Widget errocard = Padding(
                  padding: EdgeInsets.all(10),
                  child: Material(
                    elevation: 5,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20)),
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
                            margin: EdgeInsets.symmetric(vertical: 5),
                            decoration: BoxDecoration(
                                gradient: LinearGradient(colors: [
                              Colors.grey.shade300,
                              Colors.grey.shade200,
                            ])),
                            height: 20,
                            width: MediaQuery.of(context).size.width * 0.5,
                          ),
                          Container(
                            margin: EdgeInsets.symmetric(vertical: 5),
                            decoration: BoxDecoration(
                                gradient: LinearGradient(colors: [
                              Colors.grey.shade300,
                              Colors.grey.shade200,
                            ])),
                            height: 20,
                            width: MediaQuery.of(context).size.width,
                          ),
                          Container(
                            margin: EdgeInsets.symmetric(vertical: 5),
                            decoration: BoxDecoration(
                                gradient: LinearGradient(colors: [
                              Colors.grey.shade300,
                              Colors.grey.shade200,
                            ])),
                            height: 20,
                            width: MediaQuery.of(context).size.width,
                          ),
                        ],
                      ),
                    ),
                  ),
                );

                if (!model.isLoggedIn()) {
                  return SliverList(
                      delegate: SliverChildListDelegate(<Widget>[
                    errocard,
                    errocard,
                    errocard,
                    errocard,
                    errocard,
                    errocard,
                    errocard,
                  ]));
                } else {
                  return SliverList(
                      delegate: SliverChildListDelegate(<Widget>[
                    Container(
                      color: Colors.transparent,
                      height: 70,
                      alignment: Alignment.centerLeft,
                      padding: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                      child: Text(
                        "Últimas Newsletters",
                        maxLines: 2,
                        textAlign: TextAlign.start,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                            color: Color.fromARGB(250, 61, 56, 150),
                            fontWeight: FontWeight.bold,
                            fontSize: 25),
                      ),
                    ),
                    FutureBuilder<QuerySnapshot>(
                        future: getDataNewsletter(),
                        builder: (context, snapshot) {
                          if (!snapshot.hasData){
                            return errocard;
                          }
                          else if(snapshot.data.docs.isEmpty){
                            return CardVazio("Ainda não temos novas newsletters por aqui...");
                          }
                          else {
                            return CarouselSlider.builder(
                              options: CarouselOptions(
                                height: 215,
                                viewportFraction: 0.85,
                                autoPlay: true,
                                autoPlayInterval: Duration(seconds: 3),
                                autoPlayAnimationDuration:
                                    Duration(milliseconds: 800),
                                autoPlayCurve: Curves.decelerate,
                                pauseAutoPlayOnTouch: true,
                                aspectRatio: 2.0,
                              ),
                              itemCount: 10,
                              itemBuilder: (BuildContext context, int index, int) {
                                return ModelNewsHome(
                                  cabecalho: snapshot.data.docs[index]["cabecalho"],
                                  titulo: snapshot.data.docs[index]["titulo"],
                                  data: snapshot.data.docs[index]["data"].toDate(),
                                  text1: snapshot.data.docs[index]["text1"]
                                      .replaceAll("\\n", "\n"),
                                  image1: snapshot.data.docs[index]["image1"],
                                  text2: snapshot.data.docs[index]["text2"]
                                      .replaceAll("\\n", "\n"),
                                  image2: snapshot.data.docs[index]["image2"],
                                  text3: snapshot.data.docs[index]["text3"]
                                      .replaceAll("\\n", "\n"),
                                  like: LikeNewsletter(
                                    indice: snapshot.data.docs[index]["indice"],
                                  ),
                                  comment: CommentNewsletter(
                                    indice: snapshot.data.docs[index]["indice"],
                                  ),
                                  indice: snapshot.data.docs[index]["indice"],
                                );
                              },
                            );
                          }
                        }),
                    Container(
                      color: Colors.transparent,
                      height: 70,
                      alignment: Alignment.centerLeft,
                      padding: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                      child: Text(
                        "Últimos Eventos",
                        maxLines: 2,
                        textAlign: TextAlign.start,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                            color: Color.fromARGB(250, 61, 56, 150),
                            fontWeight: FontWeight.bold,
                            fontSize: 25),
                      ),
                    ),
                    FutureBuilder<QuerySnapshot>(
                      future: getDataAviso(),
                      builder: (context, snapshot) {
                        if (!snapshot.hasData){
                          return errocard;
                        }
                        else if(snapshot.data.docs.isEmpty){
                          return CardVazio("Ainda não temos novos eventos para você...");
                        }
                        else {
                          return Container(
                            width: MediaQuery.of(context).size.width,
                            height: 185,
                            color: Colors.transparent,
                            child: ListView.builder(
                                padding: EdgeInsets.all(10),
                                itemCount: 5,
                                scrollDirection: Axis.horizontal,
                                itemBuilder: (context, index) {
                                  return Padding(
                                    padding: EdgeInsets.only(
                                      left: 5,
                                      right: 5,
                                      bottom: 15
                                    ),
                                    child: ModelAvisos(
                                      imagem: snapshot.data.docs[index]["imagem"],
                                      data: snapshot.data.docs[index]["data"]
                                          .toDate(),
                                      titulo: snapshot.data.docs[index]["titulo"],
                                      subtitulo: snapshot.data.docs[index]
                                          ["subtitulo"],
                                      link: snapshot.data.docs[index]["link"],
                                    ),
                                  );
                                }),
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
                        "Nossas Indicações",
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
                      child: FutureBuilder<QuerySnapshot>(
                          future: getDataIndicacoes(),
                          builder: (context, snapshot) {
                            if (!snapshot.hasData) {
                              return errocard;
                            }
                            else if(snapshot.data.docs.isEmpty){
                              return CardVazio("Ainda não temos novas indicações para você...");
                            }
                            else {
                              return ListView.builder(
                                  padding: EdgeInsets.zero,
                                  itemCount: 3,
                                  shrinkWrap: true,
                                  physics: NeverScrollableScrollPhysics(),
                                  itemBuilder: (context, index) {
                                    return ModelIndicacoes(
                                      titulo: snapshot.data.docs[index]["titulo"],
                                      subtitulo: snapshot
                                          .data.docs[index]["subtitulo"]
                                          .replaceAll("\\n", "\n"),
                                      tipo: snapshot.data.docs[index]["tipo"],
                                      imagem: snapshot.data.docs[index]["image"],
                                      like: AvaliacaoIndicacao(
                                        indice: snapshot.data.docs[index]["indice"],
                                      ),
                                      nota: Nota(
                                        indice: snapshot.data.docs[index]["indice"],
                                      ),
                                      link: snapshot.data.docs[index]["link"],
                                    );
                                  });
                            }
                          }),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                  ]));
                }
              }),
            ],
          ),
        ),
      ),
    );
  }

  Future<QuerySnapshot> getDataIndicacoes() async {
    await Firebase.initializeApp();
    return await FirebaseFirestore.instance
        .collection("indicacoes")
        .orderBy("data", descending: true)
        .get();
  }

  Future<QuerySnapshot> getDataNewsletter() async {
    await Firebase.initializeApp();
    return await FirebaseFirestore.instance
        .collection("newsletter")
        .orderBy("data", descending: true)
        .get();
  }

  Future<QuerySnapshot> getDataAviso() async {
    await Firebase.initializeApp();
    return await FirebaseFirestore.instance
        .collection("avisos")
        .orderBy("data", descending: true)
        .get();
  }
}

class CardVazio extends StatelessWidget {
  final String text;

  CardVazio(this.text);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(10),
      child: Material(
        elevation: 5,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20)),
        child: Container(
          height: 90,
          margin: EdgeInsets.all(10),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            color: Colors.white,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(FlutterIcons.sad_tear_faw5,
                size: 30,),
              SizedBox(
                height: 10,
              ),
              Text(text,
                style: TextStyle(
                    color: Color.fromARGB(250, 61, 56, 150),
                    fontWeight: FontWeight.bold,
                    fontSize: 14),)
            ],
          ),
        ),
      ),
    );
  }
}
