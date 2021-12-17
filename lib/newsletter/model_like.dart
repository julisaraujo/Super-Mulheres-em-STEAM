import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:super_mulheres_steam/login/user_model.dart';
import 'package:scoped_model/scoped_model.dart';

class LikeNewsletter extends StatefulWidget {
  LikeNewsletter({Key key, this.indice}) : super(key: key);

  final int indice;

  @override
  _LikeNewsletterState createState() => _LikeNewsletterState();
}

class _LikeNewsletterState extends State<LikeNewsletter> {
  @override
  Widget build(BuildContext context) {
    return ScopedModelDescendant<UserModel>(builder: (context, child, model) {
      return Container(
        color: Colors.transparent,
        child: FutureBuilder<QuerySnapshot>(
          future: getDatalike(),
          builder: (context, likesnapshot) {
            if (!likesnapshot.hasData) {
              return Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text(
                    "Carregando...",
                    style: TextStyle(
                        color: Color.fromARGB(250, 61, 56, 150),
                        fontWeight: FontWeight.bold),
                  ),
                ],
              );
            } else {
              return Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  IconButton(
                    icon: Icon(
                      likesnapshot.data.docs
                                      .where((e) =>
                                          e["email"] == model.userData["email"])
                                      .length ==
                                  0 ||
                              likesnapshot.data.docs
                                      .where((element) =>
                                          element["email"] ==
                                          model.userData["email"])
                                      .toList()[0]["like"] ==
                                  false
                          ? FlutterIcons.hearto_ant
                          : FlutterIcons.heart_ant,
                      color: Color.fromARGB(250, 61, 56, 150),
                    ),
                    onPressed: () async {
                      setState(() {
                        if (likesnapshot.data.docs
                                .where((e) =>
                                    e["email"] == model.userData["email"])
                                .length ==
                            0) {
                          FirebaseFirestore.instance
                              .collection("newsletter")
                              .doc("${widget.indice}")
                              .collection("likes")
                              .doc("${model.userData["email"]}")
                              .set({
                            "like": true,
                            "email": "${model.userData["email"]}"
                          });
                        } else {
                          if (likesnapshot.data.docs
                                  .where((element) =>
                                      element["email"] ==
                                      model.userData["email"])
                                  .toList()[0]["like"] ==
                              true) {
                            FirebaseFirestore.instance
                                .collection("newsletter")
                                .doc("${widget.indice}")
                                .collection("likes")
                                .doc("${model.userData["email"]}")
                                .update({
                              "like": false,
                            });
                          } else if (likesnapshot.data.docs
                                  .where((element) =>
                                      element["email"] ==
                                      model.userData["email"])
                                  .toList()[0]["like"] ==
                              false) {
                            FirebaseFirestore.instance
                                .collection("newsletter")
                                .doc("${widget.indice}")
                                .collection("likes")
                                .doc("${model.userData["email"]}")
                                .update({
                              "like": true,
                            });
                          } else {
                            FirebaseFirestore.instance
                                .collection("newsletter")
                                .doc("${widget.indice}")
                                .collection("likes")
                                .doc("${model.userData["email"]}")
                                .set({
                              "like": false,
                              "email": "${model.userData["email"]}"
                            });
                          }
                        }
                        Future.delayed(Duration(seconds: 1),() async {
                          FirebaseFirestore.instance.collection("newsletter").doc("${widget.indice}").update({
                            "numberlikes": likesnapshot.data.docs.length + 1
                          });
                        });

                        FirebaseFirestore.instance.collection("users").doc(model.firebaseUser.uid).collection("newslike").doc("${widget.indice}").set({
                          "indice": widget.indice,
                          "time": DateTime.now()
                        });

                      });
                    },
                  ),
                  Text(
                    likesnapshot.data.docs.where((element) => element["like"] == true).length == 0
                        ? ""
                        : "${likesnapshot.data.docs.where((element) => element["like"] == true).length}",
                    style: TextStyle(
                        color: Color.fromARGB(250, 61, 56, 150),
                        fontWeight: FontWeight.bold),
                  ),
                ],
              );
            }
          },
        ),
      );
    });
  }

  Future<QuerySnapshot> getDatalike() async {
    await Firebase.initializeApp();
    return await FirebaseFirestore.instance
        .collection("newsletter")
        .doc("${widget.indice}")
        .collection("likes")
        .get();
  }
}
