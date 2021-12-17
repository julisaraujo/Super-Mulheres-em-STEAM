import 'package:flutter/material.dart';
import 'package:super_mulheres_steam/login/user_model.dart';
import 'package:super_mulheres_steam/page_view/page_view.dart';
import 'package:scoped_model/scoped_model.dart';
import 'cadastro.dart';
import 'login.dart';

class HomeEntrar extends StatefulWidget {
  @override
  _HomeEntrarState createState() => _HomeEntrarState();
}

class _HomeEntrarState extends State<HomeEntrar> {

  DateTime bday = DateTime.now();

  @override
  Widget build(BuildContext context) {
    return ScopedModelDescendant<UserModel>(
        builder: (context, child, model){
          if(model.isLoggedIn()){
            return ScreenPageView();
          }
          else {
            return Scaffold(
              body: Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height,
                decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        Color.fromARGB(250, 7, 176, 217),
                        Color.fromARGB(250, 61, 56, 150),
                      ],
                    )),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      width: MediaQuery.of(context).size.width*0.3,
                      height: MediaQuery.of(context).size.width*0.3,
                      decoration: BoxDecoration(
                        color: Colors.transparent,
                        image: DecorationImage(
                            fit: BoxFit.cover,
                            image: AssetImage(
                                "assets/super/logo_super.png")),
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text("Mulheres em STEAM",
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 21
                      ),),
                    SizedBox(
                      height: 25,
                    ),
                    GestureDetector(
                      onTap: (){
                        Navigator.of(context).push(
                            MaterialPageRoute(
                                builder: (context) => Login()));
                      },
                      child: Container(
                        height: 50,
                        width: MediaQuery.of(context).size.width*0.5,
                        decoration: BoxDecoration(
                          color: Color.fromARGB(250, 7, 176, 217),
                          borderRadius: BorderRadius.circular(15),
                          boxShadow: <BoxShadow>[
                            BoxShadow(
                                color: Colors.black.withOpacity(0.5),
                                blurRadius: 10,
                                offset: Offset(0.0, 5.0))
                          ],
                        ),
                        alignment: Alignment.center,
                        child: Text("Entrar",
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                              fontWeight: FontWeight.bold
                          ),),
                      ),
                    ),
                    SizedBox(
                      height: 25,
                    ),
                    GestureDetector(
                      onTap: (){
                        Navigator.of(context).push(
                            MaterialPageRoute(
                                builder: (context) => Cadastro()));
                      },
                      child: Container(
                        height: 50,
                        width: MediaQuery.of(context).size.width*0.5,
                        decoration: BoxDecoration(
                          color: Color.fromARGB(250, 7, 176, 217),
                          borderRadius: BorderRadius.circular(15),
                          boxShadow: <BoxShadow>[
                            BoxShadow(
                                color: Colors.black.withOpacity(0.5),
                                blurRadius: 10,
                                offset: Offset(0.0, 5.0))
                          ],
                        ),
                        alignment: Alignment.center,
                        child: Text("Cadastre-se",
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                              fontWeight: FontWeight.bold
                          ),),
                      ),
                    ),
                  ],
                ),
              ),
            );
          }
        });
  }
}