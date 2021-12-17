import 'package:flutter/material.dart';
import 'package:super_mulheres_steam/artigos/artigos.dart';
import 'package:super_mulheres_steam/forum/forum.dart';
import 'package:super_mulheres_steam/home/home.dart';
import 'package:super_mulheres_steam/indicacoes/indicacoes.dart';
import 'package:super_mulheres_steam/newsletter/newsletter.dart';
import 'package:super_mulheres_steam/parceiros/parceiros.dart';
import 'package:super_mulheres_steam/quadro_de_avisos/quadro_de_aviso.dart';
import 'package:super_mulheres_steam/settings/settings.dart';

class ScreenPageView extends StatefulWidget {
  @override
  _ScreenPageViewState createState() => _ScreenPageViewState();
}

class _ScreenPageViewState extends State<ScreenPageView> {

  final GlobalKey<ScaffoldState> _home = new GlobalKey<ScaffoldState>();
  final GlobalKey<ScaffoldState> _newsletter = new GlobalKey<ScaffoldState>();
  final GlobalKey<ScaffoldState> _quadro = new GlobalKey<ScaffoldState>();
  final GlobalKey<ScaffoldState> _indicacoes = new GlobalKey<ScaffoldState>();
  final GlobalKey<ScaffoldState> _forum = new GlobalKey<ScaffoldState>();
  final GlobalKey<ScaffoldState> _artigos = new GlobalKey<ScaffoldState>();
  final GlobalKey<ScaffoldState> _parceiros = new GlobalKey<ScaffoldState>();
  final GlobalKey<ScaffoldState> _settings = new GlobalKey<ScaffoldState>();

  final pageController = PageController();

  @override
  Widget build(BuildContext context) {
    return PageView(
      controller: pageController,
      physics: NeverScrollableScrollPhysics(),
      children: [
        Home(
          scaffoldkey: _home,
          pageController: pageController,
        ),
        Newsletter(
          scaffoldkey: _newsletter,
          pageController: pageController,
        ),
        Quadro(
          scaffoldkey: _quadro,
          pageController: pageController,
        ),
        Indicacoes(
          scaffoldkey: _indicacoes,
          pageController: pageController,
        ),
        Forum(
          scaffoldkey: _forum,
          pageController: pageController,
        ),
        Artigos(
          scaffoldkey: _artigos,
          pageController: pageController,
        ),
        Parceiros(
          scaffoldkey: _parceiros,
          pageController: pageController,
        ),
        Settings(
          scaffoldkey: _settings,
          pageController: pageController,
        ),
      ],
    );
  }
}
