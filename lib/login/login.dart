import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:super_mulheres_steam/login/user_model.dart';
import 'package:super_mulheres_steam/page_view/page_view.dart';
import 'package:scoped_model/scoped_model.dart';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  bool check = false;

  final _emailcontroller = TextEditingController();
  final _senhacontroller = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: ScopedModelDescendant<UserModel>(
          builder: (context, child, model) {
            if (model.isLoading)
              return Center(child: CircularProgressIndicator(),);
            return Container(
              width: MediaQuery
                  .of(context)
                  .size
                  .width,
              height: MediaQuery
                  .of(context)
                  .size
                  .height,
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
                    width: MediaQuery
                        .of(context)
                        .size
                        .width * 0.3,
                    height: MediaQuery
                        .of(context)
                        .size
                        .width * 0.3,
                    decoration: BoxDecoration(
                      color: Colors.transparent,
                      image: DecorationImage(
                          fit: BoxFit.cover,
                          image: AssetImage("assets/super/logo_super.png")),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    "Mulheres em STEAM",
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 21),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Container(
                    width: MediaQuery
                        .of(context)
                        .size
                        .width * 0.8,
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.5),
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 5),
                      child: Form(
                        key: _formKey,
                        child: Column(
                          children: [
                            TextFormField(
                              controller: _emailcontroller,
                              style: TextStyle(color: Colors.white),
                              decoration: InputDecoration(
                                hintText: "Email",
                              ),
                              keyboardType: TextInputType.emailAddress,
                              validator: (text) {
                                if (text.isEmpty || !text.contains("@")) {
                                  return "E-mail inválido";
                                }
                                return null;
                              },
                            ),
                            TextFormField(
                              controller: _senhacontroller,
                              style: TextStyle(color: Colors.white),
                              decoration: InputDecoration(
                                  hintText: "Senha",
                                  suffixIcon: IconButton(
                                    icon: Icon(
                                      check == true
                                          ? FlutterIcons.eye_off_mco
                                          : FlutterIcons.eye_mco,
                                      color: Colors.white,
                                    ),
                                    onPressed: () {
                                      setState(() {
                                        check = !check;
                                      });
                                    },
                                  )),
                              obscureText: check,
                              validator: (text) {
                                if (text.isEmpty || text.length < 6) {
                                  return "Senha inválida";
                                }
                                return null;
                              },
                            ),
                            Align(
                              alignment: Alignment.bottomRight,
                              child: TextButton(
                                child: Text(
                                  "Esqueci minha senha",
                                  style: TextStyle(color: Colors.white),
                                ),
                                onPressed: () {
                                  if(_emailcontroller.text.isEmpty){
                                    ScaffoldMessenger.of(context).showSnackBar(
                                        SnackBar(content: Text("Insira o email de sua conta para recuperação de senha"),
                                            backgroundColor: Colors.redAccent,
                                            duration: Duration(seconds: 3),
                                            shape: RoundedRectangleBorder(
                                              borderRadius: BorderRadius.circular(10.0),
                                            ),
                                            margin: EdgeInsets.all(15),
                                            behavior: SnackBarBehavior.floating
                                        )
                                    );
                                  }
                                  else {
                                    model.recoverPass(_emailcontroller.text);
                                    ScaffoldMessenger.of(context).showSnackBar(
                                        SnackBar(content: Text("Acesse seu email para recuperação de senha"),
                                            backgroundColor: Colors.green,
                                            duration: Duration(seconds: 2),
                                            shape: RoundedRectangleBorder(
                                              borderRadius: BorderRadius.circular(10.0),
                                            ),
                                            margin: EdgeInsets.all(15),
                                            behavior: SnackBarBehavior.floating
                                        )
                                    );
                                  }
                                },
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      GestureDetector(
                        child: Container(
                          height: 35,
                          width: MediaQuery
                              .of(context)
                              .size
                              .width * 0.25,
                          decoration: BoxDecoration(
                            color: Color.fromARGB(250, 7, 176, 217),
                            borderRadius: BorderRadius.circular(15),
                          ),
                          alignment: Alignment.center,
                          child: Text(
                            "Voltar",
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 20,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                        onTap: () {
                          Navigator.pop(context);
                        },
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      GestureDetector(
                        onTap: () {
                          if (_formKey.currentState.validate()) {
                            model.signIn(
                                email: _emailcontroller.text,
                                pass: _senhacontroller.text,
                                onSuccess: _onSuccess,
                                onFail: _onFail
                            );
                          }
                        },
                        child: Container(
                          height: 35,
                          width: MediaQuery
                              .of(context)
                              .size
                              .width * 0.25,
                          decoration: BoxDecoration(
                            color: Color.fromARGB(250, 7, 176, 217),
                            borderRadius: BorderRadius.circular(15),
                          ),
                          alignment: Alignment.center,
                          child: Text(
                            "Entrar",
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 20,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                      )
                    ],
                  )
                ],
              ),
            );
          },
        )
    );
  }

  void _onSuccess(){
    Navigator.of(context).push(
        MaterialPageRoute(
            builder: (context) => ScreenPageView()));
  }
   void _onFail(){
    ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Não foi possível entrar na sua conta"),
            backgroundColor: Colors.redAccent,
            duration: Duration(seconds: 2),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10.0),
            ),
            margin: EdgeInsets.all(15),
            behavior: SnackBarBehavior.floating
        )
    );
  }
}
