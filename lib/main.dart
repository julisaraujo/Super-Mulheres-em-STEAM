import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:scoped_model/scoped_model.dart';
import 'login/home.dart';
import 'login/user_model.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return ScopedModel<UserModel>(
        model: UserModel(),
        child: MaterialApp(
            title: 'Mulheres em STEAM',
            debugShowCheckedModeBanner: false,
            theme: ThemeData(
              primarySwatch: Colors.blue,
              iconTheme: IconThemeData(
                  color: Color.fromARGB(250, 61, 56, 150)
              ),
            ),
            home: HomeEntrar(),
          localizationsDelegates: [
            GlobalMaterialLocalizations.delegate
          ],
          supportedLocales: [
            const Locale('pt')
          ],
        )
    );
  }
}