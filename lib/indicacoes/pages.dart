import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:super_mulheres_steam/indicacoes/model_avaliacaoindicacao.dart';
import 'package:super_mulheres_steam/indicacoes/model_nota.dart';
import 'package:super_mulheres_steam/login/user_model.dart';
import 'package:scoped_model/scoped_model.dart';
import 'model_indicacoes.dart';

class Todos extends StatefulWidget {
  @override
  _TodosState createState() => _TodosState();
}

class _TodosState extends State<Todos> {
  @override
  Widget build(BuildContext context) {
    return ScopedModelDescendant<UserModel>(builder: (context, child, model) {
      return Container(
        color: Colors.white,
        child: FutureBuilder<QuerySnapshot>(
            future: getData(),
            builder: (context, snapshot) {
              if (!snapshot.hasData)
                return Center(
                  child: CircularProgressIndicator(
                    valueColor: AlwaysStoppedAnimation<Color>(
                        Color.fromARGB(250, 61, 56, 150)),
                  ),
                );
              else {
                return ListView.builder(
                    itemCount: snapshot.data.docs.length,
                    itemBuilder: (context, index) {
                      return ModelIndicacoes(
                        titulo: snapshot.data.docs[index]["titulo"],
                        subtitulo: snapshot.data.docs[index]["subtitulo"].replaceAll("\\n", "\n"),
                        tipo: snapshot.data.docs[index]["tipo"],
                        imagem: snapshot.data.docs[index]["image"],
                        like: AvaliacaoIndicacao(
                          indice: snapshot.data.docs[index]["indice"],
                        ),
                        nota: Nota(
                          indice: snapshot.data.docs[index]["indice"],
                        ),
                        link: snapshot.data.docs[index]["link"],
                      );
                    });
              }
            }),
      );
    });
  }

  Future<QuerySnapshot> getData() async {
    await Firebase.initializeApp();
    return await FirebaseFirestore.instance
        .collection("indicacoes")
        .orderBy("data", descending: true)
        .get();
  }
}

class Livros extends StatefulWidget {
  @override
  _LivrosState createState() => _LivrosState();
}

class _LivrosState extends State<Livros> {
  @override
  Widget build(BuildContext context) {
    return ScopedModelDescendant<UserModel>(builder: (context, child, model) {
      return Container(
        color: Colors.white,
        child: FutureBuilder<QuerySnapshot>(
            future: getData(),
            builder: (context, snapshot) {
              if (!snapshot.hasData)
                return Center(
                  child: CircularProgressIndicator(
                    valueColor: AlwaysStoppedAnimation<Color>(
                        Color.fromARGB(250, 61, 56, 150)),
                  ),
                );
              else {
                return ListView.builder(
                    itemCount: snapshot.data.docs.where((element) => element["tipo"] == "Livros").toList().length,
                    itemBuilder: (context, index) {
                      return ModelIndicacoes(
                        titulo: snapshot.data.docs.where((element) => element["tipo"] == "Livros").toList()[index]["titulo"],
                        subtitulo: snapshot.data.docs.where((element) => element["tipo"] == "Livros").toList()[index]["subtitulo"].replaceAll("\\n", "\n"),
                        tipo: snapshot.data.docs.where((element) => element["tipo"] == "Livros").toList()[index]["tipo"],
                        imagem: snapshot.data.docs.where((element) => element["tipo"] == "Livros").toList()[index]["image"],
                        like: AvaliacaoIndicacao(
                          indice: snapshot.data.docs.where((element) => element["tipo"] == "Livros").toList()[index]["indice"],
                        ),
                        nota: Nota(
                          indice: snapshot.data.docs.where((element) => element["tipo"] == "Livros").toList()[index]["indice"],
                        ),
                        link: snapshot.data.docs.where((element) => element["tipo"] == "Livros").toList()[index]["link"],
                      );
                    });
              }
            }),
      );
    });
  }

  Future<QuerySnapshot> getData() async {
    await Firebase.initializeApp();
    return await FirebaseFirestore.instance
        .collection("indicacoes")
        .orderBy("data", descending: true)
        .get();
  }

}


class FilmeseSeries extends StatefulWidget {
  @override
  _FilmeseSeriesState createState() => _FilmeseSeriesState();
}

class _FilmeseSeriesState extends State<FilmeseSeries> {
  @override
  Widget build(BuildContext context) {
    return ScopedModelDescendant<UserModel>(builder: (context, child, model) {
      return Container(
        color: Colors.white,
        child: FutureBuilder<QuerySnapshot>(
            future: getData(),
            builder: (context, snapshot) {
              if (!snapshot.hasData)
                return Center(
                  child: CircularProgressIndicator(
                    valueColor: AlwaysStoppedAnimation<Color>(
                        Color.fromARGB(250, 61, 56, 150)),
                  ),
                );
              else {
                return ListView.builder(
                    itemCount: snapshot.data.docs.where((element) => element["tipo"] == "Filmes e séries").toList().length,
                    itemBuilder: (context, index) {
                      return ModelIndicacoes(
                        titulo: snapshot.data.docs.where((element) => element["tipo"] == "Filmes e séries").toList()[index]["titulo"],
                        subtitulo: snapshot.data.docs.where((element) => element["tipo"] == "Filmes e séries").toList()[index]["subtitulo"].replaceAll("\\n", "\n"),
                        tipo: snapshot.data.docs.where((element) => element["tipo"] == "Filmes e séries").toList()[index]["tipo"],
                        imagem: snapshot.data.docs.where((element) => element["tipo"] == "Filmes e séries").toList()[index]["image"],
                        like: AvaliacaoIndicacao(
                          indice: snapshot.data.docs.where((element) => element["tipo"] == "Filmes e séries").toList()[index]["indice"],
                        ),
                        nota: Nota(
                          indice: snapshot.data.docs.where((element) => element["tipo"] == "Filmes e séries").toList()[index]["indice"],
                        ),
                        link: snapshot.data.docs.where((element) => element["tipo"] == "Filmes e séries").toList()[index]["link"],
                      );
                    });
              }
            }),
      );
    });
  }

  Future<QuerySnapshot> getData() async {
    await Firebase.initializeApp();
    return await FirebaseFirestore.instance
        .collection("indicacoes")
        .orderBy("data", descending: true)
        .get();
  }

}


class Musicas extends StatefulWidget {
  @override
  _MusicasState createState() => _MusicasState();
}

class _MusicasState extends State<Musicas> {
  @override
  Widget build(BuildContext context) {
    return ScopedModelDescendant<UserModel>(builder: (context, child, model) {
      return Container(
        color: Colors.white,
        child: FutureBuilder<QuerySnapshot>(
            future: getData(),
            builder: (context, snapshot) {
              if (!snapshot.hasData)
                return Center(
                  child: CircularProgressIndicator(
                    valueColor: AlwaysStoppedAnimation<Color>(
                        Color.fromARGB(250, 61, 56, 150)),
                  ),
                );
              else {
                return ListView.builder(
                    itemCount: snapshot.data.docs.where((element) => element["tipo"] == "Músicas").toList().length,
                    itemBuilder: (context, index) {
                      return ModelIndicacoes(
                        titulo: snapshot.data.docs.where((element) => element["tipo"] == "Músicas").toList()[index]["titulo"],
                        subtitulo: snapshot.data.docs.where((element) => element["tipo"] == "Músicas").toList()[index]["subtitulo"].replaceAll("\\n", "\n"),
                        tipo: snapshot.data.docs.where((element) => element["tipo"] == "Músicas").toList()[index]["tipo"],
                        imagem: snapshot.data.docs.where((element) => element["tipo"] == "Músicas").toList()[index]["image"],
                        like: AvaliacaoIndicacao(
                          indice: snapshot.data.docs.where((element) => element["tipo"] == "Músicas").toList()[index]["indice"],
                        ),
                        nota: Nota(
                          indice: snapshot.data.docs.where((element) => element["tipo"] == "Músicas").toList()[index]["indice"],
                        ),
                        link: snapshot.data.docs.where((element) => element["tipo"] == "Músicas").toList()[index]["link"],
                      );
                    });
              }
            }),
      );
    });
  }

  Future<QuerySnapshot> getData() async {
    await Firebase.initializeApp();
    return await FirebaseFirestore.instance
        .collection("indicacoes")
        .orderBy("data", descending: true)
        .get();
  }

}


class Podcasts extends StatefulWidget {
  @override
  _PodcastsState createState() => _PodcastsState();
}

class _PodcastsState extends State<Podcasts> {
  @override
  Widget build(BuildContext context) {
    return ScopedModelDescendant<UserModel>(builder: (context, child, model) {
      return Container(
        color: Colors.white,
        child: FutureBuilder<QuerySnapshot>(
            future: getData(),
            builder: (context, snapshot) {
              if (!snapshot.hasData)
                return Center(
                  child: CircularProgressIndicator(
                    valueColor: AlwaysStoppedAnimation<Color>(
                        Color.fromARGB(250, 61, 56, 150)),
                  ),
                );
              else {
                return ListView.builder(
                    itemCount: snapshot.data.docs.where((element) => element["tipo"] == "Podcasts").toList().length,
                    itemBuilder: (context, index) {
                      return ModelIndicacoes(
                        titulo: snapshot.data.docs.where((element) => element["tipo"] == "Podcasts").toList()[index]["titulo"],
                        subtitulo: snapshot.data.docs.where((element) => element["tipo"] == "Podcasts").toList()[index]["subtitulo"].replaceAll("\\n", "\n"),
                        tipo: snapshot.data.docs.where((element) => element["tipo"] == "Podcasts").toList()[index]["tipo"],
                        imagem: snapshot.data.docs.where((element) => element["tipo"] == "Podcasts").toList()[index]["image"],
                        like: AvaliacaoIndicacao(
                          indice: snapshot.data.docs.where((element) => element["tipo"] == "Podcasts").toList()[index]["indice"],
                        ),
                        nota: Nota(
                          indice: snapshot.data.docs.where((element) => element["tipo"] == "Podcasts").toList()[index]["indice"],
                        ),
                        link: snapshot.data.docs.where((element) => element["tipo"] == "Podcasts").toList()[index]["link"],
                      );
                    });
              }
            }),
      );
    });
  }

  Future<QuerySnapshot> getData() async {
    await Firebase.initializeApp();
    return await FirebaseFirestore.instance
        .collection("indicacoes")
        .orderBy("data", descending: true)
        .get();
  }

}

class Artigos extends StatefulWidget {
  @override
  _ArtigosState createState() => _ArtigosState();
}

class _ArtigosState extends State<Artigos> {
  @override
  Widget build(BuildContext context) {
    return ScopedModelDescendant<UserModel>(builder: (context, child, model) {
      return Container(
        color: Colors.white,
        child: FutureBuilder<QuerySnapshot>(
            future: getData(),
            builder: (context, snapshot) {
              if (!snapshot.hasData)
                return Center(
                  child: CircularProgressIndicator(
                    valueColor: AlwaysStoppedAnimation<Color>(
                        Color.fromARGB(250, 61, 56, 150)),
                  ),
                );
              else {
                return ListView.builder(
                    itemCount: snapshot.data.docs.where((element) => element["tipo"] == "Artigos").toList().length,
                    itemBuilder: (context, index) {
                      return ModelIndicacoes(
                        titulo: snapshot.data.docs.where((element) => element["tipo"] == "Artigos").toList()[index]["titulo"],
                        subtitulo: snapshot.data.docs.where((element) => element["tipo"] == "Artigos").toList()[index]["subtitulo"].replaceAll("\\n", "\n"),
                        tipo: snapshot.data.docs.where((element) => element["tipo"] == "Artigos").toList()[index]["tipo"],
                        imagem: snapshot.data.docs.where((element) => element["tipo"] == "Artigos").toList()[index]["image"],
                        like: AvaliacaoIndicacao(
                          indice: snapshot.data.docs.where((element) => element["tipo"] == "Artigos").toList()[index]["indice"],
                        ),
                        nota: Nota(
                          indice: snapshot.data.docs.where((element) => element["tipo"] == "Artigos").toList()[index]["indice"],
                        ),
                        link: snapshot.data.docs.where((element) => element["tipo"] == "Artigos").toList()[index]["link"],
                      );
                    });
              }
            }),
      );
    });
  }

  Future<QuerySnapshot> getData() async {
    await Firebase.initializeApp();
    return await FirebaseFirestore.instance
        .collection("indicacoes")
        .orderBy("data", descending: true)
        .get();
  }

}


class Videos extends StatefulWidget {
  @override
  _VideosState createState() => _VideosState();
}

class _VideosState extends State<Videos> {
  @override
  Widget build(BuildContext context) {
    return ScopedModelDescendant<UserModel>(builder: (context, child, model) {
      return Container(
        color: Colors.white,
        child: FutureBuilder<QuerySnapshot>(
            future: getData(),
            builder: (context, snapshot) {
              if (!snapshot.hasData)
                return Center(
                  child: CircularProgressIndicator(
                    valueColor: AlwaysStoppedAnimation<Color>(
                        Color.fromARGB(250, 61, 56, 150)),
                  ),
                );
              else {
                return ListView.builder(
                    itemCount: snapshot.data.docs.where((element) => element["tipo"] == "Videos").toList().length,
                    itemBuilder: (context, index) {
                      return ModelIndicacoes(
                        titulo: snapshot.data.docs.where((element) => element["tipo"] == "Videos").toList()[index]["titulo"],
                        subtitulo: snapshot.data.docs.where((element) => element["tipo"] == "Videos").toList()[index]["subtitulo"].replaceAll("\\n", "\n"),
                        tipo: snapshot.data.docs.where((element) => element["tipo"] == "Videos").toList()[index]["tipo"],
                        imagem: snapshot.data.docs.where((element) => element["tipo"] == "Videos").toList()[index]["image"],
                        like: AvaliacaoIndicacao(
                          indice: snapshot.data.docs.where((element) => element["tipo"] == "Videos").toList()[index]["indice"],
                        ),
                        nota: Nota(
                          indice: snapshot.data.docs.where((element) => element["tipo"] == "Videos").toList()[index]["indice"],
                        ),
                        link: snapshot.data.docs.where((element) => element["tipo"] == "Videos").toList()[index]["link"],
                      );
                    });
              }
            }),
      );
    });
  }

  Future<QuerySnapshot> getData() async {
    await Firebase.initializeApp();
    return await FirebaseFirestore.instance
        .collection("indicacoes")
        .orderBy("data", descending: true)
        .get();
  }

}


class Perfis extends StatefulWidget {
  @override
  _PerfisState createState() => _PerfisState();
}

class _PerfisState extends State<Perfis> {
  @override
  Widget build(BuildContext context) {
    return ScopedModelDescendant<UserModel>(builder: (context, child, model) {
      return Container(
        color: Colors.white,
        child: FutureBuilder<QuerySnapshot>(
            future: getData(),
            builder: (context, snapshot) {
              if (!snapshot.hasData)
                return Center(
                  child: CircularProgressIndicator(
                    valueColor: AlwaysStoppedAnimation<Color>(
                        Color.fromARGB(250, 61, 56, 150)),
                  ),
                );
              else {
                return ListView.builder(
                    itemCount: snapshot.data.docs.where((element) => element["tipo"] == "Perfis").toList().length,
                    itemBuilder: (context, index) {
                      return ModelIndicacoes(
                        titulo: snapshot.data.docs.where((element) => element["tipo"] == "Perfis").toList()[index]["titulo"],
                        subtitulo: snapshot.data.docs.where((element) => element["tipo"] == "Perfis").toList()[index]["subtitulo"].replaceAll("\\n", "\n"),
                        tipo: snapshot.data.docs.where((element) => element["tipo"] == "Perfis").toList()[index]["tipo"],
                        imagem: snapshot.data.docs.where((element) => element["tipo"] == "Perfis").toList()[index]["image"],
                        like: AvaliacaoIndicacao(
                          indice: snapshot.data.docs.where((element) => element["tipo"] == "Perfis").toList()[index]["indice"],
                        ),
                        nota: Nota(
                          indice: snapshot.data.docs.where((element) => element["tipo"] == "Perfis").toList()[index]["indice"],
                        ),
                        link: snapshot.data.docs.where((element) => element["tipo"] == "Perfis").toList()[index]["link"],
                      );
                    });
              }
            }),
      );
    });
  }

  Future<QuerySnapshot> getData() async {
    await Firebase.initializeApp();
    return await FirebaseFirestore.instance
        .collection("indicacoes")
        .orderBy("data", descending: true)
        .get();
  }

}
