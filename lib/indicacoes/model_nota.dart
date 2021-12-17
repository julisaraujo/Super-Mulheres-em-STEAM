import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

class Nota extends StatefulWidget {

  Nota({Key key, this.indice}) : super(key: key);

  final int indice;

  @override
  _NotaState createState() => _NotaState();
}


class _NotaState extends State<Nota> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<QuerySnapshot>(
      future: getDatalike(),
        builder: (context, likesnapshot) {
          if (!likesnapshot.hasData) {
            return Text(
              "0",
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Color.fromARGB(250, 61, 56, 150)),
            );
          }
        else{
          return Text(
            likesnapshot.data.docs.where((element) => element["like"] == true).length == 0
                ? "0"
                :"${((likesnapshot.data.docs.where((element) => element["like"] == true).length/likesnapshot.data.docs.length)*10).round()}",
          style: TextStyle(
          fontWeight: FontWeight.bold,
          color: Color.fromARGB(250, 61, 56, 150)),
          );
          }
        }
    );
  }

  Future<QuerySnapshot> getDatalike() async {
    await Firebase.initializeApp();
    return await FirebaseFirestore.instance
        .collection("indicacoes")
        .doc("${widget.indice}")
        .collection("likes")
        .get();
  }

}
