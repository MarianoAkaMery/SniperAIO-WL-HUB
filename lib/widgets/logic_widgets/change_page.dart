import 'package:flutter/material.dart';
import 'package:sniper_wl_web_app/pages/main_page.dart';
import 'package:sniper_wl_web_app/pages/question_page.dart';
import 'package:sniper_wl_web_app/pages/status_page.dart';
import '../../pages/category_page.dart';
import '../../pages/auth_page.dart';
import '../../pages/final_page.dart';

// ignore: must_be_immutable
class CambiaPagina extends StatefulWidget {
  CambiaPagina({super.key, required this.indexFromPage});
  int indexFromPage;

  @override
  State<CambiaPagina> createState() => CambiaPaginaState();
}

class CambiaPaginaState extends State<CambiaPagina> {
  late int _index;
  int ndomanda = 0;

  @override
  void initState() {
    super.initState();
    _index = widget.indexFromPage;
  }

  void nextScreen() {
    setState(() {
      if (_index < 4) {
        _index += 1;
      }
    });
  }

  void backScreen() {
    setState(() {
      if (_index == 0) {
      } else {
        _index -= 1;
      }
    });
  }

  void statusScreen() {
    setState(() {
      _index = 8;
    });
  }

  void homeScreen() {
    setState(() {
      _index = 0;
    });
  }

  @override
  Widget build(BuildContext context) {
    Widget currentScreen =
        MainPage(nextScreen, backScreen, statusScreen, homeScreen);
    if (_index == 0) {
      currentScreen =
          MainPage(nextScreen, backScreen, statusScreen, homeScreen);
    }
    if (_index == 1) {
      currentScreen = AuthPage(nextScreen, backScreen, homeScreen);
    }
    if (_index == 2) {
      currentScreen = CategoryPage(nextScreen, backScreen);
    }
    if (_index == 3) {
      currentScreen = QuestionPage(nextScreen, backScreen);
    }
    if (_index == 4) {
      currentScreen = const FinalPage();
    }
    if (_index == 8) {
      currentScreen = StatusPage(homeScreen);
    }
    return MaterialApp(
      title: 'whitelist',
      theme: ThemeData(
          hintColor: Colors.grey,
          inputDecorationTheme: const InputDecorationTheme(
              labelStyle: TextStyle(color: Colors.red))),
      home: Scaffold(
        body: Container(
          child: currentScreen,
        ),
      ),
      debugShowCheckedModeBanner: false,
    );
  }
}
