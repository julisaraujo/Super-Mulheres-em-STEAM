import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:super_mulheres_steam/login/user_model.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;

class EditAccount extends StatefulWidget {
  @override
  _EditAccountState createState() => _EditAccountState();
}

class _EditAccountState extends State<EditAccount> {

  final _formKey = GlobalKey<FormState>();
  File _image;
  bool checkload = false;
  bool loadimage = false;
  Widget _widget;

  final _nomecontroller = TextEditingController();
  final _sobrenomecontroller = TextEditingController();
  String genero = "Masculino";
  DateTime bday = DateTime.now();

  @override
  void initState() {
    super.initState();
   this.data();
  }

  Future data() async {
    DocumentSnapshot mydoc = await FirebaseFirestore.instance.collection("users").doc(UserModel.of(context).firebaseUser.uid).get();
    setState(() {
      if(mydoc["nome"] == null){
        _nomecontroller.text = "Nome";
      }
      else{
        _nomecontroller.text = mydoc["nome"];
      }
    });

    setState(() {
      if(mydoc["sobrenome"] == null){
        _sobrenomecontroller.text = "Nome";
      }
      else{
        _sobrenomecontroller.text = mydoc["sobrenome"];
      }
    });

    setState(() {
      if(mydoc["genero"] == null){
        genero = "Masculino";
      }
      else{
        genero = mydoc["genero"];
      }
    });

    setState(() {
      if(mydoc["nascimento"] == null){
        bday = DateTime.now();
      }
      else{
        bday = mydoc["nascimento"].toDate();
      }
    });

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Color.fromARGB(250, 61, 56, 150),
          title: Text(
            "Editar",
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
            } else {
              return ListView(
                padding: EdgeInsets.all(10),
                children: [
                  Container(
                      margin: EdgeInsets.symmetric(vertical: 15),
                      child: GestureDetector(
                        child: Container(
                            height: 150,
                            width: 150,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              boxShadow: <BoxShadow>[
                                BoxShadow(
                                    color: Colors.black.withOpacity(0.5),
                                    blurRadius: 10,
                                    offset: Offset(0.0, 5.0))
                              ],
                              shape: BoxShape.circle,
                              image: DecorationImage(
                                fit: BoxFit.contain,
                                image: _image == null
                                    ? NetworkImage("${model.userData["foto"]}")
                                    : FileImage(_image),
                              ),
                            ),
                            alignment: Alignment.center,
                            child: Icon(
                              Icons.camera_alt,
                              size: 35,
                              color: Colors.white.withOpacity(0.8),
                            ),),
                        onTap: () async {
                          final picker = ImagePicker();
                          final pickedFile = await picker.getImage(source: ImageSource.gallery);

                          setState(() {
                            if (pickedFile != null) {
                              _image = File(pickedFile.path);
                            } else {
                              print('No image selected.');
                            }
                          });
                        },
                      )),
                  Center(
                      child: Padding(
                    padding: EdgeInsets.symmetric(vertical: 10),
                    child: _widget,
                  )),
                  Text(
                    "Dados pessoais",
                    textAlign: TextAlign.start,
                    style: TextStyle(
                        color: Color.fromARGB(250, 61, 56, 150),
                        fontWeight: FontWeight.bold,
                        fontSize: 22),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Form(
                    key: _formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        TextFormField(
                            controller: _nomecontroller,
                            decoration: InputDecoration(
                                focusedBorder: OutlineInputBorder(
                                  borderRadius:
                                  BorderRadius.all(Radius.circular(20)),
                                  borderSide: BorderSide(
                                      width: 2,
                                      color: Color.fromARGB(250, 61, 56, 150)),
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderRadius:
                                  BorderRadius.all(Radius.circular(20)),
                                  borderSide: BorderSide(
                                      width: 1,
                                      color: Color.fromARGB(250, 61, 56, 150)),
                                ),
                                counterStyle: TextStyle(
                                  color: Color.fromARGB(250, 61, 56, 150),
                                ),
                                labelText: "Nome",
                                labelStyle: TextStyle(
                                    color: Color.fromARGB(250, 61, 56, 150),
                                    fontSize: 15,
                                    fontWeight: FontWeight.w500),
                                border: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        color: Color.fromARGB(250, 61, 56, 150)),
                                    borderRadius:
                                    BorderRadius.all(Radius.circular(20)))),
                            maxLength: 15,
                            validator: (text) {
                              if (text.isEmpty) {
                                return "Esse campo não pode estar vazio";
                              }
                              else if (text.length > 15){
                                return "Excesso de caracteres";
                              }
                              return null;
                            }),
                        SizedBox(
                          height: 10,
                        ),
                        TextFormField(
                            controller: _sobrenomecontroller,
                            decoration: InputDecoration(
                                focusedBorder: OutlineInputBorder(
                                  borderRadius:
                                  BorderRadius.all(Radius.circular(20)),
                                  borderSide: BorderSide(
                                      width: 2,
                                      color: Color.fromARGB(250, 61, 56, 150)),
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderRadius:
                                  BorderRadius.all(Radius.circular(20)),
                                  borderSide: BorderSide(
                                      width: 1,
                                      color: Color.fromARGB(250, 61, 56, 150)),
                                ),
                                counterStyle: TextStyle(
                                  color: Color.fromARGB(250, 61, 56, 150),
                                ),
                                labelText: "Sobrenome",
                                labelStyle: TextStyle(
                                    color: Color.fromARGB(250, 61, 56, 150),
                                    fontSize: 15,
                                    fontWeight: FontWeight.w500),
                                border: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        color: Color.fromARGB(250, 61, 56, 150)),
                                    borderRadius:
                                    BorderRadius.all(Radius.circular(20)))),
                            validator: (text) {
                              if (text.isEmpty) {
                                return "Esse campo não pode estar vazio";
                              }
                              return null;
                            }),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    "Gênero",
                    maxLines: 3,
                    textAlign: TextAlign.start,
                    style: TextStyle(
                        color: Color.fromARGB(250, 61, 56, 150),
                        fontWeight: FontWeight.bold,
                        fontSize: 15),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Container(
                    padding: EdgeInsets.all(5),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(20)),
                      border: Border.all(
                        color: Color.fromARGB(250, 61, 56, 150),
                      ),
                    ),
                    child: DropdownButton<String>(
                      value: genero,
                      icon: Icon(Icons.arrow_drop_down_sharp),
                      iconSize: 24,
                      elevation: 16,
                      isExpanded: true,
                      style: TextStyle(
                          color: Color.fromARGB(250, 61, 56, 150),
                          fontWeight: FontWeight.w500,
                          fontSize: 15),
                      underline: Container(
                        height: 0,
                      ),
                      onChanged: (String newValue) {
                        setState(() {
                          genero = newValue;
                        });
                      },
                      items: <String>[
                        'Masculino',
                        'Feminino',
                        'Homem transgênero',
                        'Mulher transgênero',
                        'Homem transexual',
                        'Mulher transexual',
                        'Cisgênero',
                        'Não sei responder',
                        'Prefiro não responder',
                        'Outro'
                      ].map<DropdownMenuItem<String>>((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        );
                      }).toList(),
                    ),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  GestureDetector(
                    child: Container(
                      padding: EdgeInsets.all(12.5),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(20)),
                        border: Border.all(
                          color: Color.fromARGB(250, 61, 56, 150),
                        ),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            bday == null ||
                                DateFormat('d-MM-yyyy').format(bday) ==
                                    DateFormat('d-MM-yyyy')
                                        .format(DateTime.now())
                                ? "Data de nascimento"
                                : "${DateFormat(DateFormat.YEAR_MONTH_DAY, 'pt_Br').format(bday)}",
                            textAlign: TextAlign.start,
                            style: TextStyle(
                                color: Color.fromARGB(250, 61, 56, 150),
                                fontWeight: FontWeight.w500,
                                fontSize: 15),
                          ),
                          Icon(
                            Icons.cake,
                            size: 22,
                          ),
                        ],
                      ),
                    ),
                    onTap: () async {
                      final DateTime picked = await showDatePicker(
                        context: context,
                        initialDate: bday,
                        firstDate: DateTime(1921),
                        lastDate: DateTime((DateTime.now().year) + 2),
                      );
                      if (picked != null && picked != bday)
                        setState(() {
                          bday = picked;
                        });
                    },
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  GestureDetector(
                    onTap: () async {
                      if(_formKey.currentState.validate()){
                        if(_image == null){
                          FirebaseFirestore.instance.collection("users").doc("${model.firebaseUser.uid}").update({
                            "nome": _nomecontroller.text,
                            "sobrenome": _sobrenomecontroller.text,
                            "genero": genero,
                            "nascimento": bday,
                          });
                          Navigator.pop(context);
                          showDialog(
                              context: context,
                              builder: (context){
                                Future.delayed(Duration(seconds: 1), () {
                                  Navigator.of(context).pop(true);
                                });
                                return AlertDialog(
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(20.0))),
                                  insetPadding: EdgeInsets.all(10),
                                  title: Container(
                                    width: 45,
                                    height: 45,
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: Colors.white,
                                      border: Border.all(
                                          width: 3,
                                          color: Color.fromARGB(
                                              250, 61, 56, 150)),
                                      boxShadow: [
                                        BoxShadow(
                                          color:
                                          Colors.grey.withOpacity(0.5),
                                          spreadRadius: 5,
                                          blurRadius: 7,
                                          offset: Offset(0,
                                              3), // changes position of shadow
                                        ),
                                      ],
                                    ),
                                    alignment: Alignment.center,
                                    child: Icon(
                                      Icons.check,
                                      size: 35,
                                    ),
                                  ),
                                  content: Container(
                                    width:
                                    MediaQuery.of(context).size.width *
                                        0.5,
                                    child: Text(
                                      "Dados atualizados com sucesso",
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                          color: Color.fromARGB(
                                              250, 61, 56, 150),
                                          fontWeight: FontWeight.bold,
                                          fontSize: 15),
                                    ),
                                  ),
                                );
                              });
                        }
                        else{
                          firebase_storage.UploadTask ref = firebase_storage
                              .FirebaseStorage.instance
                              .ref()
                              .child('photo users')
                              .child('${model.firebaseUser.email}')
                              .putFile(_image);

                          setState(() {
                            loadimage = true;
                          });

                          firebase_storage.TaskSnapshot tasksnapshot =
                          await ref.whenComplete(() => checkload = true);
                          String url = await tasksnapshot.ref.getDownloadURL();

                          if(checkload = true){
                            FirebaseFirestore.instance.collection("users").doc("${model.firebaseUser.uid}").update({
                              "nome": _nomecontroller.text,
                              "sobrenome": _sobrenomecontroller.text,
                              "genero": genero,
                              "nascimento": bday,
                              "foto": url
                            });
                            Navigator.pop(context);
                          }
                          showDialog(
                              context: context,
                              builder: (context){
                                Future.delayed(Duration(seconds: 1), () {
                                  Navigator.of(context).pop(true);
                                });
                                return AlertDialog(
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(20.0))),
                                  insetPadding: EdgeInsets.all(10),
                                  title: Container(
                                    width: 45,
                                    height: 45,
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: Colors.white,
                                      border: Border.all(
                                          width: 3,
                                          color: Color.fromARGB(
                                              250, 61, 56, 150)),
                                      boxShadow: [
                                        BoxShadow(
                                          color:
                                          Colors.grey.withOpacity(0.5),
                                          spreadRadius: 5,
                                          blurRadius: 7,
                                          offset: Offset(0,
                                              3), // changes position of shadow
                                        ),
                                      ],
                                    ),
                                    alignment: Alignment.center,
                                    child: Icon(
                                      Icons.check,
                                      size: 35,
                                    ),
                                  ),
                                  content: Container(
                                    width:
                                    MediaQuery.of(context).size.width *
                                        0.5,
                                    child: Text(
                                      "Dados atualizados com sucesso",
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                          color: Color.fromARGB(
                                              250, 61, 56, 150),
                                          fontWeight: FontWeight.bold,
                                          fontSize: 15),
                                    ),
                                  ),
                                );
                              });
                        }
                      }
                    },
                    child: Center(
                      child: loadimage == true
                          ? CircularProgressIndicator(
                        valueColor: new AlwaysStoppedAnimation<Color>(Color.fromARGB(250, 61, 56, 150)))
                          : Container(
                              padding: EdgeInsets.all(10),
                              width: MediaQuery.of(context).size.width * 0.5,
                              decoration: BoxDecoration(
                                color: Color.fromARGB(250, 61, 56, 150),
                                borderRadius: BorderRadius.circular(20),
                              ),
                              alignment: Alignment.center,
                              child: Text(
                                "Atualizar",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                    ),
                  )
                ],
              );
            }
          },
        ));
  }
}
