import 'dart:async';

import 'package:data_connection_checker/data_connection_checker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:super_mulheres_steam/drawer/mydrawer.dart';
import 'package:super_mulheres_steam/indicacoes/pages.dart';
import 'package:super_mulheres_steam/login/user_model.dart';
import 'package:scoped_model/scoped_model.dart';

class Indicacoes extends StatefulWidget {
  Indicacoes({Key key, this.pageController, this.scaffoldkey})
      : super(key: key);

  final PageController pageController;
  final GlobalKey<ScaffoldState> scaffoldkey;

  @override
  _IndicacoesState createState() => _IndicacoesState();
}

class _IndicacoesState extends State<Indicacoes> {

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
      length: 8,
      child: Scaffold(
          key: widget.scaffoldkey,
          drawer: DrawerBody(widget.pageController),
          appBar: AppBar(
            backgroundColor: Color.fromARGB(250, 61, 56, 150),
            elevation: 0,
            title: Text(
              "Indicações",
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
            else{
              return Column(
                children: [
                  SizedBox(
                    height: 5,
                  ),
                  TabBar(
                    isScrollable: true,
                    unselectedLabelColor: Color.fromARGB(250, 61, 56, 150),
                    indicatorSize: TabBarIndicatorSize.tab,
                    indicatorPadding: EdgeInsets.fromLTRB(5,7,5,9),
                    labelPadding: EdgeInsets.symmetric(
                        horizontal: 5
                    ),
                    indicator: BoxDecoration(
                        borderRadius: BorderRadius.circular(50),
                        color: Color.fromARGB(250, 61, 56, 150)),
                    tabs: [
                      Tab(
                        child: Container(
                          padding: EdgeInsets.all(5),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(50),
                              border: Border.all(color: Color.fromARGB(250, 61, 56, 150), width: 1)),
                          child: Text("Todos"),
                        ),
                      ),
                      Tab(
                        child: Container(
                          padding: EdgeInsets.all(5),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(50),
                              border: Border.all(color: Color.fromARGB(250, 61, 56, 150), width: 1)),
                          child: Row(
                            children: [
                              Icon(Icons.menu_book_outlined,size: 20,),
                              SizedBox(
                                width: 3,
                              ),
                              Text("Livros")
                            ],
                          ),
                        ),
                      ),
                      Tab(
                        child: Container(
                          padding: EdgeInsets.all(5),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(50),
                              border: Border.all(color: Color.fromARGB(250, 61, 56, 150), width: 1)),
                          child: Row(
                            children: [
                              Icon(FlutterIcons.play_video_fou,size: 20,),
                              SizedBox(
                                width: 3,
                              ),
                              Text("Filmes e séries")
                            ],
                          ),
                        ),
                      ),
                      Tab(
                        child: Container(
                          padding: EdgeInsets.all(5),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(50),
                              border: Border.all(color: Color.fromARGB(250, 61, 56, 150), width: 1)),
                          child: Row(
                            children: [
                              Icon(Icons.music_note_outlined,size: 20,),
                              SizedBox(
                                width: 3,
                              ),
                              Text("Músicas")
                            ],
                          ),
                        ),
                      ),
                      Tab(
                        child: Container(
                          padding: EdgeInsets.all(5),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(50),
                              border: Border.all(color: Color.fromARGB(250, 61, 56, 150), width: 1)),
                          child: Row(
                            children: [
                              Icon(FlutterIcons.mic_ent,size: 20,),
                              SizedBox(
                                width: 3,
                              ),
                              Text("Podcasts")
                            ],
                          ),
                        ),
                      ),
                      Tab(
                        child: Container(
                          padding: EdgeInsets.all(5),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(50),
                              border: Border.all(color: Color.fromARGB(250, 61, 56, 150), width: 1)),
                          child: Row(
                            children: [
                              Icon(FlutterIcons.card_text_outline_mco,size: 20,),
                              SizedBox(
                                width: 3,
                              ),
                              Text("Artigos")
                            ],
                          ),
                        ),
                      ),
                      Tab(
                        child: Container(
                          padding: EdgeInsets.all(5),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(50),
                              border: Border.all(color: Color.fromARGB(250, 61, 56, 150), width: 1)),
                          child: Row(
                            children: [
                              Icon(FlutterIcons.video_vintage_mco,size: 20,),
                              SizedBox(
                                width: 3,
                              ),
                              Text("Videos")
                            ],
                          ),
                        ),
                      ),
                      Tab(
                        child: Container(
                          padding: EdgeInsets.all(5),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(50),
                              border: Border.all(color: Color.fromARGB(250, 61, 56, 150), width: 1)),
                          child: Row(
                            children: [
                              Icon(FlutterIcons.people_mdi,size: 20,),
                              SizedBox(
                                width: 3,
                              ),
                              Text("Perfis")
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                  Expanded(
                    child: TabBarView(
                      children: [
                        Todos(),
                        Livros(),
                        FilmeseSeries(),
                        Musicas(),
                        Podcasts(),
                        Artigos(),
                        Videos(),
                        Perfis(),
                      ],
                    ),
                  ),
                ],
              );
            }
          },
        ),
      ),
    );
  }
}