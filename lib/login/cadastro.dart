import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:super_mulheres_steam/login/user_model.dart';
import 'package:super_mulheres_steam/page_view/page_view.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;

class Cadastro extends StatefulWidget {
  @override
  _CadastroState createState() => _CadastroState();
}

class _CadastroState extends State<Cadastro> {

  final _nomecontroller = TextEditingController();
  final _sobrenomecontroller = TextEditingController();
  String genero = "Homem cisgênero";
  DateTime bday = DateTime.now();
  final _emailcontroller = TextEditingController();
  final _senhacontroller = TextEditingController();

  final _formKey = GlobalKey<FormState>();
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  File _image;

  bool checkload = false;
  bool loadimage = false;

  Widget _widget;

  String vinculo = 'Aluno(a)';
  String unidade = 'CETELI';
  String curso = 'Ciência da Computação';
  String cursomap = 'Ciência da Computação';
  String bolsista = 'Sim';

  void _validador() {
    if (vinculo != 'Aluno(a)') {
      setState(() {
        cursomap = "Não se aplica";
      });
    } else if (vinculo == 'Aluno(a)') {
      setState(() {
        cursomap = curso;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: _scaffoldKey,
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Color.fromARGB(250, 61, 56, 150),
          title: Text(
            "Nova conta",
            style: TextStyle(color: Colors.white),
          ),
          centerTitle: true,
        ),
        body: ScopedModelDescendant<UserModel>(
          builder: (context, child, model) {
            if (model.isLoading)
              return Center(child: CircularProgressIndicator());
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
                              image: _image == null
                                  ? AssetImage("assets/avatar/avatar.png")
                                  : FileImage(_image),
                            ),
                          ),
                          alignment: Alignment.center,
                          child: Icon(
                            Icons.camera_alt,
                            size: 35,
                            color: Colors.white.withOpacity(0.8),
                          )),
                      onTap: () async {
                        final picker = ImagePicker();
                        final pickedFile =
                            await picker.getImage(source: ImageSource.gallery);

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
                  height: 10,
                ),
                Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      TextFormField(
                          controller: _nomecontroller,
                          style: TextStyle(fontSize: 15),
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
                            } else if (text.length > 15) {
                              return "Excesso de caracteres";
                            }
                            return null;
                          }),
                      SizedBox(
                        height: 10,
                      ),
                      TextFormField(
                          controller: _sobrenomecontroller,
                          style: TextStyle(fontSize: 15),
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
                      SizedBox(
                        height: 20,
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
                            'Homem cisgênero',
                            'Mulher cisgênero',
                            'Homem transgênero',
                            'Mulher transgênero',
                            'Não binário',
                            'Prefiro não responder',
                          ].map<DropdownMenuItem<String>>((String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Text(value),
                            );
                          }).toList(),
                        ),
                      ),
                      SizedBox(
                        height: 20,
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
                            firstDate: DateTime(1950),
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
                      Text(
                        "Vínculo institucional",
                        textAlign: TextAlign.start,
                        style: TextStyle(
                            color: Color.fromARGB(250, 61, 56, 150),
                            fontWeight: FontWeight.bold,
                            fontSize: 22),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Text(
                        "Qual seu vínculo com a UFAM?",
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
                          value: vinculo,
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
                              vinculo = newValue;
                              _validador();
                            });
                          },
                          items: <String>[
                            'Aluno(a)',
                            'Professor(a)',
                            'Técnico(a) Administrativo(a)',
                            'Prestador(a) de serviço',
                            'Outros',
                            'Nenhum'
                          ].map<DropdownMenuItem<String>>((String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Text(value),
                            );
                          }).toList(),
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        "A qual unidade acadêmica você está vinculado?",
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
                          value: unidade,
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
                              unidade = newValue;
                            });
                          },
                          items: <String>[
                            'CETELI',
                            'ICE',
                            'IComp',
                            'FT',
                            'FLet',
                            'FaPsi',
                            'Outros'
                          ].map<DropdownMenuItem<String>>((String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Text(value),
                            );
                          }).toList(),
                        ),
                      ),
                      vinculo == "Aluno(a)"
                          ? Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizedBox(
                                  height: 10,
                                ),
                                Text(
                                  "Qual o seu curso?",
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
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(20)),
                                    border: Border.all(
                                      color: Color.fromARGB(250, 61, 56, 150),
                                    ),
                                  ),
                                  child: DropdownButton<String>(
                                    value: curso,
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
                                        curso = newValue;
                                        _validador();
                                      });
                                    },
                                    items: <String>[
                                      'Ciência da Computação',
                                      'Design',
                                      'Engenharia da Computação',
                                      'Engenharia de Produção',
                                      'Engenharia de Software',
                                      'Engenharia Elétrica - Eletrônica',
                                      'Engenharia Elétrica - Eletrotécnica',
                                      'Engenharia Elétrica - Telecomunicações',
                                      'Outros'
                                    ].map<DropdownMenuItem<String>>(
                                        (String value) {
                                      return DropdownMenuItem<String>(
                                        value: value,
                                        child: Text(value),
                                      );
                                    }).toList(),
                                  ),
                                ),
                              ],
                            )
                          : Container(),
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        "Você é bolsista SUPER?",
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
                          value: bolsista,
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
                              bolsista = newValue;
                            });
                          },
                          items: <String>['Sim', 'Não']
                              .map<DropdownMenuItem<String>>((String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Text(value),
                            );
                          }).toList(),
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Text(
                        "Cadastro",
                        textAlign: TextAlign.start,
                        style: TextStyle(
                            color: Color.fromARGB(250, 61, 56, 150),
                            fontWeight: FontWeight.bold,
                            fontSize: 22),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      FutureBuilder<QuerySnapshot>(
                        future: users(),
                        builder: (context, usersnapshot) {
                          if (!usersnapshot.hasData) {
                            return CircularProgressIndicator();
                          } else {
                            List usuarios = usersnapshot.data.docs;
                            return TextFormField(
                              controller: _emailcontroller,
                              decoration: InputDecoration(
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(20)),
                                    borderSide: BorderSide(
                                        width: 2,
                                        color:
                                            Color.fromARGB(250, 61, 56, 150)),
                                  ),
                                  enabledBorder: OutlineInputBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(20)),
                                    borderSide: BorderSide(
                                        width: 1,
                                        color:
                                            Color.fromARGB(250, 61, 56, 150)),
                                  ),
                                  counterStyle: TextStyle(
                                    color: Color.fromARGB(250, 61, 56, 150),
                                  ),
                                  labelText: "Email",
                                  labelStyle: TextStyle(
                                      color: Color.fromARGB(250, 61, 56, 150),
                                      fontSize: 15,
                                      fontWeight: FontWeight.w500),
                                  border: OutlineInputBorder(
                                      borderSide: BorderSide(
                                          color:
                                              Color.fromARGB(250, 61, 56, 150)),
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(20)))),
                              validator: (text) {
                                if (text.isEmpty ||
                                    !text.contains("@") ||
                                    text.contains(" ")) {
                                  return "Email inválido";
                                } else if (usuarios
                                        .where((element) =>
                                            element["email"] == text)
                                        .length !=
                                    0) {
                                  return "Este email já está em uso";
                                }
                                return null;
                              },
                            );
                          }
                        },
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      TextFormField(
                        controller: _senhacontroller,
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
                            labelText: "Senha",
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
                            return "Este campo não pode estar vazio";
                          } else if (text.length < 6) {
                            return "Senha muito curta";
                          }
                          return null;
                        },
                      ),
                      SizedBox(
                        height: 25,
                      ),
                    ],
                  ),
                ),
                GestureDetector(
                  onTap: () async {
                    if (_nomecontroller.text.isEmpty ||
                        _nomecontroller.text == " " ||
                        _nomecontroller.text == "  ") {
                      return showDialog(
                          context: context,
                          builder: (context) {
                            Future.delayed(Duration(seconds: 2), () {
                              Navigator.of(context).pop(true);
                            });
                            return Alert(FlutterIcons.account_edit_mco,
                                "O campo nome não pode estar vazio.");
                          });
                    } else if (_nomecontroller.text.length > 15) {
                      return showDialog(
                          context: context,
                          builder: (context) {
                            Future.delayed(Duration(seconds: 2), () {
                              Navigator.of(context).pop(true);
                            });
                            return Alert(FlutterIcons.account_edit_mco,
                                "O campo nome não pode ter o número de caracteres maior que 15.");
                          });
                    } else if (_sobrenomecontroller.text.isEmpty) {
                      return showDialog(
                          context: context,
                          builder: (context) {
                            Future.delayed(Duration(seconds: 2), () {
                              Navigator.of(context).pop(true);
                            });
                            return Alert(FlutterIcons.account_edit_mco,
                                "O campo sobrenome não pode estar vazio.");
                          });
                    } else if (bday == null ||
                        (bday.year == DateTime.now().year &&
                            bday.month == DateTime.now().month &&
                            bday.day == DateTime.now().day)) {
                      return showDialog(
                          context: context,
                          builder: (context) {
                            Future.delayed(Duration(seconds: 3), () {
                              Navigator.of(context).pop(true);
                            });
                            return Alert(Icons.cake,
                                "A data de nascimento não pode ser igual a data atual.");
                          });
                    }
                    else if (bday.year == DateTime.now().year || bday.year > DateTime.now().year) {
                      return showDialog(
                          context: context,
                          builder: (context) {
                            Future.delayed(Duration(seconds: 3), () {
                              Navigator.of(context).pop(true);
                            });
                            return Alert(Icons.cake,
                                "O ano de nascimento não pode ser igual ou maior ao ano atual.");
                          });
                    }
                    else if (_image == null) {
                      return showDialog(
                          context: context,
                          builder: (context) {
                            Future.delayed(Duration(seconds: 3), () {
                              Navigator.of(context).pop(true);
                            });
                            return Alert(Icons.person,
                                "Para criar uma conta é necessário adicionar uma foto de perfil.");
                          });
                    }
                    else if(_emailcontroller.text.endsWith(" ")){
                      return showDialog(
                          context: context,
                          builder: (context) {
                            Future.delayed(Duration(seconds: 3), () {
                              Navigator.of(context).pop(true);
                            });
                            return Alert(Icons.email_outlined,
                                "O último caractere não pode ser um espaço no campo email");
                          });
                    }
                    else if(_emailcontroller.text.startsWith(" ")){
                      return showDialog(
                          context: context,
                          builder: (context) {
                            Future.delayed(Duration(seconds: 3), () {
                              Navigator.of(context).pop(true);
                            });
                            return Alert(Icons.email_outlined,
                                "O primeiro caractere não pode ser um espaço no campo email");
                          });
                    }
                    else if(_emailcontroller.text.contains(" ")){
                      return showDialog(
                          context: context,
                          builder: (context) {
                            Future.delayed(Duration(seconds: 3), () {
                              Navigator.of(context).pop(true);
                            });
                            return Alert(Icons.email_outlined,
                                "Não é permitido usar espaço no campo email");
                          });
                    }
                    else if(_senhacontroller.text.endsWith(" ")){
                      return showDialog(
                          context: context,
                          builder: (context) {
                            Future.delayed(Duration(seconds: 3), () {
                              Navigator.of(context).pop(true);
                            });
                            return Alert(Icons.password,
                                "O último caractere não pode ser um espaço no campo senha");
                          });
                    }
                    else if(_senhacontroller.text.startsWith(" ")){
                      return showDialog(
                          context: context,
                          builder: (context) {
                            Future.delayed(Duration(seconds: 3), () {
                              Navigator.of(context).pop(true);
                            });
                            return Alert(Icons.password,
                                "O primeiro caractere não pode ser um espaço no campo senha");
                          });
                    }
                    else if(_senhacontroller.text.contains(" ")){
                      return showDialog(
                          context: context,
                          builder: (context) {
                            Future.delayed(Duration(seconds: 3), () {
                              Navigator.of(context).pop(true);
                            });
                            return Alert(Icons.password,
                                "Não é permitido usar o caractere espaço no campo senha");
                          });
                    }
                    else {
                      if (_formKey.currentState.validate() && _image != null) {
                        firebase_storage.UploadTask ref = firebase_storage
                            .FirebaseStorage.instance
                            .ref()
                            .child('photo users')
                            .child('${_emailcontroller.text}')
                            .putFile(_image);

                        setState(() {
                          loadimage = true;
                        });

                        firebase_storage.TaskSnapshot tasksnapshot =
                            await ref.whenComplete(() => checkload = true);
                        String url = await tasksnapshot.ref.getDownloadURL();

                        if (checkload = true) {
                          Map<String, dynamic> userData = {
                            "email": _emailcontroller.text,
                            "nome": _nomecontroller.text,
                            "sobrenome": _sobrenomecontroller.text,
                            "genero": genero,
                            "nascimento": bday,
                            "vinculo": vinculo,
                            "unidade": unidade,
                            "curso": cursomap,
                            "bolsista": bolsista,
                            "foto": url,
                          };
                          model.signUp(
                              userData: userData,
                              pass: _senhacontroller.text,
                              onSuccess: _onSuccess,
                              onFail: _onFail);
                        }
                      } else if (_image == null) {
                        setState(() {
                          _widget = Text(
                            "Para criar uma conta é necessário que você adicione uma foto de perfil.",
                            style: TextStyle(
                              color: Colors.red,
                            ),
                            textAlign: TextAlign.center,
                          );
                        });
                      }
                    }
                  },
                  child: Center(
                    child: loadimage == true
                        ? CircularProgressIndicator()
                        : Container(
                            padding: EdgeInsets.all(10),
                            width: MediaQuery.of(context).size.width * 0.5,
                            decoration: BoxDecoration(
                              color: Color.fromARGB(250, 61, 56, 150),
                              borderRadius: BorderRadius.circular(20),
                            ),
                            alignment: Alignment.center,
                            child: Text(
                              "Criar conta",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                  ),
                ),
              ],
            );
          },
        ));
  }

  Future<QuerySnapshot> users() async {
    await Firebase.initializeApp();
    return await FirebaseFirestore.instance.collection("users").get();
  }

  void _onSuccess() {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text("Usuário criado com sucesso!"),
        backgroundColor: Colors.green,
        duration: Duration(seconds: 3),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        margin: EdgeInsets.all(15),
        behavior: SnackBarBehavior.floating));
    Future.delayed(Duration(seconds: 2)).then((_) {
      Navigator.of(context)
          .push(MaterialPageRoute(builder: (context) => ScreenPageView()));
    });
  }

  void _onFail() {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text("Falha ao cadastrar usuário"),
        backgroundColor: Colors.redAccent,
        duration: Duration(seconds: 2),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        margin: EdgeInsets.all(15),
        behavior: SnackBarBehavior.floating));
    _nomecontroller.clear();
    _emailcontroller.clear();
    _senhacontroller.clear();
  }
}

class Alert extends StatelessWidget {
  final IconData icon;
  final String text;

  Alert(this.icon, this.text);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(20.0))),
      title: Container(
        width: 45,
        height: 45,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: Colors.white,
          border: Border.all(width: 3, color: Color.fromARGB(250, 61, 56, 150)),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 5,
              blurRadius: 7,
              offset: Offset(0, 3), // changes position of shadow
            ),
          ],
        ),
        alignment: Alignment.center,
        child: Icon(
          icon,
          size: 35,
        ),
      ),
      content: Container(
        child: Text(
          text,
          textAlign: TextAlign.center,
          style: TextStyle(
              color: Colors.red,
              fontWeight: FontWeight.w500,
              fontSize: 17),
        ),
      ),
    );
  }
}
