import 'package:flutter/material.dart';
import 'package:super_mulheres_steam/drawer/mydrawer.dart';
import 'package:super_mulheres_steam/login/user_model.dart';
import 'package:super_mulheres_steam/settings/faleconosco.dart';
import 'package:super_mulheres_steam/settings/quemsomos.dart';
import 'package:scoped_model/scoped_model.dart';

import 'edit_account.dart';

class Settings extends StatefulWidget {
  Settings({Key key, this.pageController, this.scaffoldkey}) : super(key: key);

  final PageController pageController;
  final GlobalKey<ScaffoldState> scaffoldkey;

  @override
  _SettingsState createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: widget.scaffoldkey,
      drawer: DrawerBody(widget.pageController),
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Color.fromARGB(250, 61, 56, 150),
        title: Text(
          "Configurações",
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
          else{
            return ListView(
                children: [
                  Column(
                    children: [
                      ListTile(
                        leading: Icon(Icons.account_circle_outlined,
                            color: Color.fromARGB(250, 61, 56, 150)),
                        title: Text("Perfil",
                          style: TextStyle(
                              color: Color.fromARGB(250, 61, 56, 150),
                              fontSize: 17,
                              fontWeight: FontWeight.bold
                          ),),
                        onTap: (){
                          Navigator.of(context).push(
                              MaterialPageRoute(builder: (context) => EditAccount()));
                        },
                      ),
                      Divider(
                        color: Color.fromARGB(250, 61, 56, 150),
                        height: 0,
                        indent: 10,
                        endIndent: 10,
                      )
                    ],
                  ),
                  Column(
                    children: [
                      ListTile(
                        leading: Icon(Icons.people_alt_rounded,
                            color: Color.fromARGB(250, 61, 56, 150)),
                        title: Text("Quem somos",
                          style: TextStyle(
                              color: Color.fromARGB(250, 61, 56, 150),
                              fontSize: 17,
                              fontWeight: FontWeight.bold
                          ),),
                        onTap: (){
                          Navigator.of(context).push(
                              MaterialPageRoute(builder: (context) => QuemSomos()));
                        },
                      ),
                      Divider(
                        color: Color.fromARGB(250, 61, 56, 150),
                        height: 0,
                        indent: 10,
                        endIndent: 10,
                      )
                    ],
                  ),
                  Column(
                    children: [
                      ListTile(
                        leading: Icon(Icons.headset_mic_outlined,
                            color: Color.fromARGB(250, 61, 56, 150)),
                        title: Text("Fale conosco",
                          style: TextStyle(
                              color: Color.fromARGB(250, 61, 56, 150),
                              fontSize: 17,
                              fontWeight: FontWeight.bold
                          ),),
                        onTap: (){
                          Navigator.of(context).push(
                              MaterialPageRoute(builder: (context) => FaleConosco()));
                        },
                      ),
                      Divider(
                        color: Color.fromARGB(250, 61, 56, 150),
                        height: 0,
                        indent: 10,
                        endIndent: 10,
                      )
                    ],
                  )
                ]
            );
          }
        },
      )
    );
  }
}
