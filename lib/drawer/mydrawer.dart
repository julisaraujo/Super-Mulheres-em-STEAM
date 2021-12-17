import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:super_mulheres_steam/login/login.dart';
import 'package:super_mulheres_steam/login/user_model.dart';
import 'drawer_card.dart';

class DrawerBody extends StatelessWidget {
  final PageController pageController;

  DrawerBody(this.pageController);

  @override
  Widget build(BuildContext context) {
    return Drawer(
        elevation: 14,
        child: Container(
          decoration: BoxDecoration(
              gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color.fromARGB(250, 7, 176, 217),
              Color.fromARGB(250, 61, 56, 150),
            ],
          )),
          child: ListView(
            children: [
              DrawerHeader(
                child: Center(
                  child: Container(
                    color: Colors.transparent,
                    child: Image.asset("assets/super/logo_super.png"),
                  ),
                ),
              ),
              DrawerCard("Home", pageController, 0),
              Divider(
                height: 0,
                color: Colors.white,
                endIndent: 20,
              ),
              DrawerCard("Newsletters", pageController, 1),
              Divider(
                height: 0,
                color: Colors.white,
                endIndent: 20,
              ),
              DrawerCard("Avisos e Eventos", pageController, 2),
              Divider(
                height: 0,
                color: Colors.white,
                endIndent: 20,
              ),
              DrawerCard("Indicações", pageController, 3),
              Divider(
                height: 0,
                color: Colors.white,
                endIndent: 20,
              ),
              DrawerCard("Roda de conversas", pageController, 4),
              Divider(
                height: 0,
                color: Colors.white,
                endIndent: 20,
              ),
              DrawerCard("Artigos", pageController, 5),
              Divider(
                height: 0,
                color: Colors.white,
                endIndent: 20,
              ),
              DrawerCard("Projetos parceiros", pageController, 6),
              Divider(
                height: 0,
                color: Colors.white,
                endIndent: 20,
              ),
              DrawerCard("Configurações", pageController, 7),
              Divider(
                height: 0,
                color: Colors.white,
                endIndent: 20,
              ),
              SizedBox(
                height: 20,
              ),
              ScopedModelDescendant<UserModel>(
                  builder: (context, child, model) {
                    if(model.isLoggedIn()){
                      return Center(
                        child: GestureDetector(
                          onTap: () {
                            model.signOut();
                            Navigator.pop(context);
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) => Login()
                            ));
                          },
                          child: Container(
                            height: 35,
                            width: 100,
                            decoration: BoxDecoration(
                              color: Colors.white12,
                              borderRadius: BorderRadius.circular(15),
                            ),
                            alignment: Alignment.center,
                            child: Text(
                              "Sair",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                      );
                    }
                    else{
                      return Center(
                        child: GestureDetector(
                          onTap: () {
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) => Login()
                            ));
                          },
                          child: Container(
                            height: 35,
                            width: 100,
                            decoration: BoxDecoration(
                              color: Colors.white12,
                              borderRadius: BorderRadius.circular(15),
                            ),
                            alignment: Alignment.center,
                            child: Text(
                              "Fazer login",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                      );
                    }
              }),
              SizedBox(
                height: 50,
              ),
              Text(
                "Developed by Julis",
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(
                height: 50,
              )
            ],
          ),
        ));
  }
}
