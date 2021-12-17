import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:super_mulheres_steam/login/user_model.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:scoped_model/scoped_model.dart';

class InfoProfile extends StatefulWidget {
  @override
  _InfoProfileState createState() => _InfoProfileState();
}

class _InfoProfileState extends State<InfoProfile> {

  int newscomment;
  int newslike;
  int forum;
  int indica;

  int pontos;
  int nivel;
  double pontosbarra;
  int maxbar;
  int pontoslegenda;

  String autor;
  String bio;
  String foto;
  String frase;

  List infonivel;

  String linkerror ="https://firebasestorage.googleapis.com/v0/b/supermulheressteam.appspot.com/o/niveis%2Ferror_image.png?alt=media&token=23c814c0-dd1e-4592-98c0-d5ca23ae9c99";

  @override
  Widget build(BuildContext context) {
    return ScopedModelDescendant<UserModel>(
        builder:  (context, child, model){
          return StreamBuilder<QuerySnapshot>(
            stream: FirebaseFirestore.instance.collection("infoniveis").orderBy("nivel", descending: false).snapshots(),
            builder: (context, snapshotnivel){
              infonivel = !snapshotnivel.hasData ? [] : snapshotnivel.data.docs;
              return StreamBuilder<QuerySnapshot>(
                stream: FirebaseFirestore.instance.collection("users").doc(model.firebaseUser.uid).collection("newscomment").snapshots(),
                builder: (context, snapnewscomment){
                  newscomment = !snapnewscomment.hasData ? 0 : snapnewscomment.data.docs.length;
                  return StreamBuilder<QuerySnapshot>(
                    stream: FirebaseFirestore.instance.collection("users").doc(model.firebaseUser.uid).collection("newslike").snapshots(),
                    builder: (context, snapnewslike){
                      newslike = !snapnewslike.hasData ? 0 : snapnewslike.data.docs.length;
                      return StreamBuilder<QuerySnapshot>(
                        stream: FirebaseFirestore.instance.collection("users").doc(model.firebaseUser.uid).collection("forum").snapshots(),
                        builder: (context, snapforum){
                          forum = !snapforum.hasData ? 0 : snapforum.data.docs.length;
                          return StreamBuilder<QuerySnapshot>(
                            stream: FirebaseFirestore.instance.collection("users").doc(model.firebaseUser.uid).collection("indica").snapshots(),
                            builder: (context, snapindica){
                              indica = !snapindica.hasData ? 0 : snapindica.data.docs.length;

                              pontos = (newscomment-1) + 4*(newslike-1) + (forum-1) + 4*(indica-1);

                              if(100 >= pontos){
                                nivel = 1;
                                pontosbarra = (pontos/100).toDouble();
                                maxbar = 100;
                                pontoslegenda = pontos;

                                autor = !snapshotnivel.hasData ? "" : infonivel[0]["autor"];
                                bio = !snapshotnivel.hasData ? "" : infonivel[0]["bio"];
                                foto = !snapshotnivel.hasData ? linkerror : infonivel[0]["foto"];
                                frase = !snapshotnivel.hasData ? "Algo não está funcionando como o esperado" : infonivel[0]["frase"];
                              }
                              else if (100 < pontos && 300 >= pontos){
                                nivel = 2;
                                pontosbarra = ((pontos-100)/200).toDouble();
                                maxbar = 200;
                                pontoslegenda = pontos-100;

                                autor = !snapshotnivel.hasData ? "" : infonivel[1]["autor"];
                                bio = !snapshotnivel.hasData ? "" : infonivel[1]["bio"];
                                foto = !snapshotnivel.hasData ? linkerror : infonivel[1]["foto"];
                                frase = !snapshotnivel.hasData ? "Algo não está funcionando como o esperado" : infonivel[1]["frase"];
                              }
                              else if (300 < pontos && 600 >= pontos){
                                nivel = 3;
                                pontosbarra = ((pontos-300)/300).toDouble();
                                maxbar = 300;
                                pontoslegenda = pontos-300;

                                autor = !snapshotnivel.hasData ? "" : infonivel[2]["autor"];
                                bio = !snapshotnivel.hasData ? "" : infonivel[2]["bio"];
                                foto = !snapshotnivel.hasData ? linkerror : infonivel[2]["foto"];
                                frase = !snapshotnivel.hasData ? "Algo não está funcionando como o esperado" : infonivel[2]["frase"];
                              }
                              else if (600 < pontos && 1000 >= pontos){
                                nivel = 4;
                                pontosbarra = ((pontos-600)/400).toDouble();
                                maxbar = 400;
                                pontoslegenda = pontos-600;

                                autor = !snapshotnivel.hasData ? "" : infonivel[3]["autor"];
                                bio = !snapshotnivel.hasData ? "" : infonivel[3]["bio"];
                                foto = !snapshotnivel.hasData ? linkerror : infonivel[3]["foto"];
                                frase = !snapshotnivel.hasData ? "Algo não está funcionando como o esperado" : infonivel[3]["frase"];
                              }
                              else if (1000 < pontos && 1500 >= pontos){
                                nivel = 5;
                                pontosbarra = ((pontos-1000)/500).toDouble();
                                maxbar = 500;
                                pontoslegenda = pontos-1000;

                                autor = !snapshotnivel.hasData ? "" : infonivel[4]["autor"];
                                bio = !snapshotnivel.hasData ? "" : infonivel[4]["bio"];
                                foto = !snapshotnivel.hasData ? linkerror : infonivel[4]["foto"];
                                frase = !snapshotnivel.hasData ? "Algo não está funcionando como o esperado" : infonivel[4]["frase"];
                              }
                              else if (1500 < pontos && 2100 >= pontos){
                                nivel = 6;
                                pontosbarra = ((pontos-1500)/600).toDouble();
                                maxbar = 600;
                                pontoslegenda = pontos-1500;

                                autor = !snapshotnivel.hasData ? "" : infonivel[5]["autor"];
                                bio = !snapshotnivel.hasData ? "" : infonivel[5]["bio"];
                                foto = !snapshotnivel.hasData ? linkerror : infonivel[5]["foto"];
                                frase = !snapshotnivel.hasData ? "Algo não está funcionando como o esperado" : infonivel[5]["frase"];
                              }
                              else if (2100 < pontos && 2800 >= pontos){
                                nivel = 7;
                                pontosbarra = ((pontos-2100)/700).toDouble();
                                maxbar = 700;
                                pontoslegenda = pontos-2100;

                                autor = !snapshotnivel.hasData ? "" : infonivel[6]["autor"];
                                bio = !snapshotnivel.hasData ? "" : infonivel[6]["bio"];
                                foto = !snapshotnivel.hasData ? linkerror : infonivel[6]["foto"];
                                frase = !snapshotnivel.hasData ? "Algo não está funcionando como o esperado" : infonivel[6]["frase"];
                              }
                              else if (2800 < pontos && 3600 >= pontos){
                                nivel = 8;
                                pontosbarra = ((pontos-2800)/800).toDouble();
                                maxbar = 800;
                                pontoslegenda = pontos-2800;

                                autor = !snapshotnivel.hasData ? "" : infonivel[7]["autor"];
                                bio = !snapshotnivel.hasData ? "" : infonivel[7]["bio"];
                                foto = !snapshotnivel.hasData ? linkerror : infonivel[7]["foto"];
                                frase = !snapshotnivel.hasData ? "Algo não está funcionando como o esperado" : infonivel[7]["frase"];
                              }
                              else if (3600 < pontos && 4500 >= pontos){
                                nivel = 9;
                                pontosbarra = ((pontos-3600)/900).toDouble();
                                maxbar = 900;
                                pontoslegenda = pontos-3600;

                                autor = !snapshotnivel.hasData ? "" : infonivel[8]["autor"];
                                bio = !snapshotnivel.hasData ? "" : infonivel[8]["bio"];
                                foto = !snapshotnivel.hasData ? linkerror : infonivel[8]["foto"];
                                frase = !snapshotnivel.hasData ? "Algo não está funcionando como o esperado" : infonivel[8]["frase"];
                              }
                              else if (4500 < pontos && 5500 >= pontos){
                                nivel = 10;
                                pontosbarra = ((pontos-4500)/1000).toDouble();
                                maxbar = 1000;
                                pontoslegenda = pontos-4500;

                                autor = !snapshotnivel.hasData ? "" : infonivel[9]["autor"];
                                bio = !snapshotnivel.hasData ? "" : infonivel[9]["bio"];
                                foto = !snapshotnivel.hasData ? linkerror : infonivel[9]["foto"];
                                frase = !snapshotnivel.hasData ? "Algo não está funcionando como o esperado" : infonivel[9]["frase"];
                              }
                              else if(5500 < pontos && 6600 >= pontos){
                                nivel = 11;
                                pontosbarra = ((pontos-5500)/1100).toDouble();
                                maxbar = 1100;
                                pontoslegenda = pontos-5500;

                                autor = !snapshotnivel.hasData ? "" : infonivel[10]["autor"];
                                bio = !snapshotnivel.hasData ? "" : infonivel[10]["bio"];
                                foto = !snapshotnivel.hasData ? linkerror : infonivel[10]["foto"];
                                frase = !snapshotnivel.hasData ? "Algo não está funcionando como o esperado" : infonivel[10]["frase"];
                              }
                              else if (6600 < pontos && 7800 >= pontos){
                                nivel = 12;
                                pontosbarra = ((pontos-6600)/1200).toDouble();
                                maxbar = 1200;
                                pontoslegenda = pontos-6600;

                                autor = !snapshotnivel.hasData ? "" : infonivel[11]["autor"];
                                bio = !snapshotnivel.hasData ? "" : infonivel[11]["bio"];
                                foto = !snapshotnivel.hasData ? linkerror : infonivel[11]["foto"];
                                frase = !snapshotnivel.hasData ? "Algo não está funcionando como o esperado" : infonivel[11]["frase"];
                              }
                              else if (7800 < pontos && 9100 >= pontos){
                                nivel = 13;
                                pontosbarra = ((pontos-7800)/1300).toDouble();
                                maxbar = 1300;
                                pontoslegenda = pontos-7800;

                                autor = !snapshotnivel.hasData ? "" : infonivel[12]["autor"];
                                bio = !snapshotnivel.hasData ? "" : infonivel[12]["bio"];
                                foto = !snapshotnivel.hasData ? linkerror : infonivel[12]["foto"];
                                frase = !snapshotnivel.hasData ? "Algo não está funcionando como o esperado" : infonivel[12]["frase"];
                              }
                              else if (9100 < pontos && 10500 >= pontos){
                                nivel = 14;
                                pontosbarra = ((pontos-9100)/1400).toDouble();
                                maxbar = 1400;
                                pontoslegenda = pontos-9100;

                                autor = !snapshotnivel.hasData ? "" : infonivel[13]["autor"];
                                bio = !snapshotnivel.hasData ? "" : infonivel[13]["bio"];
                                foto = !snapshotnivel.hasData ? linkerror : infonivel[13]["foto"];
                                frase = !snapshotnivel.hasData ? "Algo não está funcionando como o esperado" : infonivel[13]["frase"];
                              }
                              else if (10500 < pontos && 12000 >= pontos){
                                nivel = 15;
                                pontosbarra = ((pontos-10500)/1500).toDouble();
                                maxbar = 1500;
                                pontoslegenda = pontos-10500;

                                autor = !snapshotnivel.hasData ? "" : infonivel[14]["autor"];
                                bio = !snapshotnivel.hasData ? "" : infonivel[14]["bio"];
                                foto = !snapshotnivel.hasData ? linkerror : infonivel[14]["foto"];
                                frase = !snapshotnivel.hasData ? "Algo não está funcionando como o esperado" : infonivel[14]["frase"];
                              }
                              else if (12000 < pontos && 13600 >= pontos){
                                nivel = 16;
                                pontosbarra = ((pontos-12000)/1600).toDouble();
                                maxbar = 1600;
                                pontoslegenda = pontos-12000;

                                autor = !snapshotnivel.hasData ? "" : infonivel[15]["autor"];
                                bio = !snapshotnivel.hasData ? "" : infonivel[15]["bio"];
                                foto = !snapshotnivel.hasData ? linkerror : infonivel[15]["foto"];
                                frase = !snapshotnivel.hasData ? "Algo não está funcionando como o esperado" : infonivel[15]["frase"];
                              }
                              else if (13600 < pontos && 15300 >= pontos){
                                nivel = 17;
                                pontosbarra = ((pontos-13600)/1700).toDouble();
                                maxbar = 1700;
                                pontoslegenda = pontos-13600;

                                autor = !snapshotnivel.hasData ? "" : infonivel[16]["autor"];
                                bio = !snapshotnivel.hasData ? "" : infonivel[16]["bio"];
                                foto = !snapshotnivel.hasData ? linkerror : infonivel[16]["foto"];
                                frase = !snapshotnivel.hasData ? "Algo não está funcionando como o esperado" : infonivel[16]["frase"];
                              }
                              else if (15300 < pontos && 17100 >= pontos){
                                nivel = 18;
                                pontosbarra = ((pontos-15300)/1800).toDouble();
                                maxbar = 1800;
                                pontoslegenda = pontos-15300;

                                autor = !snapshotnivel.hasData ? "" : infonivel[17]["autor"];
                                bio = !snapshotnivel.hasData ? "" : infonivel[17]["bio"];
                                foto = !snapshotnivel.hasData ? linkerror : infonivel[17]["foto"];
                                frase = !snapshotnivel.hasData ? "Algo não está funcionando como o esperado" : infonivel[17]["frase"];
                              }
                              else if (17100 < pontos && 19000 >= pontos){
                                nivel = 19;
                                pontosbarra = ((pontos-17100)/1900).toDouble();
                                maxbar = 1900;
                                pontoslegenda = pontos-17100;

                                autor = !snapshotnivel.hasData ? "" : infonivel[18]["autor"];
                                bio = !snapshotnivel.hasData ? "" : infonivel[18]["bio"];
                                foto = !snapshotnivel.hasData ? linkerror : infonivel[18]["foto"];
                                frase = !snapshotnivel.hasData ? "Algo não está funcionando como o esperado" : infonivel[18]["frase"];
                              }
                              else if (19000 < pontos ){
                                nivel = 20;
                                pontosbarra = 1;
                                maxbar = 0;
                                pontoslegenda = 0;

                                autor = !snapshotnivel.hasData ? "" : infonivel[19]["autor"];
                                bio = !snapshotnivel.hasData ? "" : infonivel[19]["bio"];
                                foto = !snapshotnivel.hasData ? linkerror : infonivel[19]["foto"];
                                frase = !snapshotnivel.hasData ? "Algo não está funcionando como o esperado" : infonivel[19]["frase"];
                              }
                              else {
                                nivel = 0;
                                pontosbarra = 1;
                                maxbar = 0;
                                pontoslegenda = 0;

                                autor = "";
                                bio = "";
                                foto = linkerror;
                                frase = "Algo não está funcionando como o esperado";
                              }

                              return Column(
                                children: [
                                  Padding(
                                    padding: EdgeInsets.symmetric(horizontal: 35),
                                    child: Row(
                                      crossAxisAlignment: CrossAxisAlignment.center,
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Column(
                                          crossAxisAlignment: CrossAxisAlignment.center,
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          children: [
                                            Text(
                                              !snapforum.hasData || !snapnewscomment.hasData ? "0" : "${(snapforum.data.docs.length-1)+(snapnewscomment.data.docs.length-1)}",
                                              maxLines: 1,
                                              textAlign: TextAlign.center,
                                              overflow: TextOverflow.ellipsis,
                                              style: TextStyle(
                                                  color: Colors.deepOrangeAccent,
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 20),
                                            ),
                                            SizedBox(
                                              height: 5,
                                            ),
                                            Text(
                                              "Interações",
                                              maxLines: 1,
                                              textAlign: TextAlign.center,
                                              overflow: TextOverflow.ellipsis,
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 13),
                                            ),
                                          ],
                                        ),
                                        Column(
                                          crossAxisAlignment: CrossAxisAlignment.center,
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          children: [
                                            Text(
                                              pontos < 0 ? "0" : "$pontos",
                                              maxLines: 1,
                                              textAlign: TextAlign.center,
                                              overflow: TextOverflow.ellipsis,
                                              style: TextStyle(
                                                  color: Colors.deepOrangeAccent,
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 20),
                                            ),
                                            SizedBox(
                                              height: 5,
                                            ),
                                            Text(
                                              "Pontos",
                                              maxLines: 1,
                                              textAlign: TextAlign.center,
                                              overflow: TextOverflow.ellipsis,
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 13),
                                            ),
                                          ],
                                        ),
                                        Column(
                                          crossAxisAlignment: CrossAxisAlignment.center,
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          children: [
                                            Text(
                                              "$nivel",
                                              maxLines: 1,
                                              textAlign: TextAlign.center,
                                              overflow: TextOverflow.ellipsis,
                                              style: TextStyle(
                                                  color: Colors.deepOrangeAccent,
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 20),
                                            ),
                                            SizedBox(
                                              height: 5,
                                            ),
                                            Text(
                                              "Nível",
                                              maxLines: 1,
                                              textAlign: TextAlign.center,
                                              overflow: TextOverflow.ellipsis,
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 13),
                                            ),
                                          ],
                                        ),
                                        Column(
                                          crossAxisAlignment: CrossAxisAlignment.center,
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          children: [
                                            Text(
                                              !snapnewslike.hasData ? "0" : "${snapnewslike.data.docs.length-1}",
                                              maxLines: 1,
                                              textAlign: TextAlign.center,
                                              overflow: TextOverflow.ellipsis,
                                              style: TextStyle(
                                                  color: Colors.deepOrangeAccent,
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 20),
                                            ),
                                            SizedBox(
                                              height: 5,
                                            ),
                                            Text(
                                              "Newsletters",
                                              maxLines: 2,
                                              textAlign: TextAlign.center,
                                              overflow: TextOverflow.ellipsis,
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 13),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.only(
                                        top: 15, left: 15, right: 15, bottom: 15),
                                    child: GestureDetector(
                                      child: LinearPercentIndicator(
                                        animation: true,
                                        animationDuration: 1000,
                                        animateFromLastPercent: true,
                                        alignment: MainAxisAlignment.center,
                                        lineHeight: 10,
                                        percent: pontosbarra < 0 || pontosbarra > 1 ? 0 : pontosbarra,
                                        linearStrokeCap: LinearStrokeCap.roundAll,
                                        progressColor: Colors.deepOrangeAccent,
                                        backgroundColor: Colors.white.withOpacity(0.3),
                                        trailing: Text(pontos < 19000 ? "${pontoslegenda < 0 ? 0 : pontoslegenda}/$maxbar" : "",
                                            style: TextStyle(
                                                color: Colors.deepOrangeAccent,
                                                fontWeight: FontWeight.bold,
                                                fontSize: 15)
                                        ),
                                      ),
                                      onTap: (){
                                        showDialog(
                                            context: context,
                                            builder: (BuildContext context){
                                              return AlertDialog(
                                                shape: RoundedRectangleBorder(
                                                    borderRadius: BorderRadius.all(Radius.circular(20.0))),
                                                insetPadding: EdgeInsets.all(10),
                                                title: Text(
                                                  "Parabéns, você está no nível $nivel!",
                                                  maxLines: 2,
                                                  textAlign: TextAlign.center,
                                                  overflow: TextOverflow.ellipsis,
                                                  style: TextStyle(
                                                      color: Color.fromARGB(250, 61, 56, 150),
                                                      fontWeight: FontWeight.bold,
                                                      fontSize: 20),
                                                ),
                                                content: Container(
                                                  color: Colors.transparent,
                                                  child: Column(
                                                    mainAxisAlignment: MainAxisAlignment.start,
                                                    crossAxisAlignment: CrossAxisAlignment.start,
                                                    mainAxisSize: MainAxisSize.min,
                                                    children: [
                                                      Center(
                                                        child: Container(
                                                          height: 150,
                                                          width: 150,
                                                          color: Colors.transparent,
                                                          child: Image.network("$foto"),
                                                        ),
                                                      ),
                                                      Text(
                                                        "$frase",
                                                        textAlign: TextAlign.center,
                                                        style: TextStyle(
                                                            color: Color.fromARGB(250, 61, 56, 150),
                                                            fontWeight: FontWeight.bold,
                                                            fontStyle: FontStyle.italic,
                                                            fontSize: 20),
                                                      ),
                                                      SizedBox(
                                                        height: 10,
                                                      ),
                                                      Text(
                                                        "$autor",
                                                        maxLines: 2,
                                                        textAlign: TextAlign.center,
                                                        overflow: TextOverflow.ellipsis,
                                                        style: TextStyle(
                                                            color: Color.fromARGB(250, 61, 56, 150),
                                                            fontWeight: FontWeight.bold,
                                                            fontStyle: FontStyle.italic,
                                                            fontSize: 15),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              );
                                            });
                                      },
                                    ),
                                  ),
                                ],
                              );
                            },
                          );
                        },
                      );
                    },
                  );
                },
              );
            },
          );
        });
  }
}
