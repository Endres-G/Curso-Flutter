import 'package:flutter/material.dart';
import 'package:teste_app/other/app_controller.dart';
import 'package:teste_app/pages/config_page.dart';
import 'package:teste_app/pages/escrevendo_post.dart';
import 'package:teste_app/pages/escrever_post_others.dart';
import 'package:teste_app/pages/home_page.dart';
import 'package:teste_app/pages/login_page.dart';
import 'package:teste_app/pages/outras_home.dart';
import 'package:teste_app/pages/register_page.dart';

class AppWidget extends StatelessWidget {
  final String title;

  const AppWidget({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

    return AnimatedBuilder(
      animation: AppController.instance,
      builder: (context, child) {
        return MaterialApp(
          navigatorKey: navigatorKey,
          initialRoute: '/',
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
              primaryColor: Colors.black,
              brightness: AppController.instance.isDarkTheme
                  ? Brightness.dark //if
                  : Brightness.light //else
              ),
          routes: {
            '/': (context) => LoginPage(),
            '/home': (context) => HomePage(
                //name: "",
                ),
            '/register': (context) => RegisterPage(),
            '/escrita': (context) => EscrevendoMyPost(),
            '/escrita2': (context) => EscrevendoPostOthers(),
            '/config': (context) => ConfigPage(),
            '/user': (context) => OthersHomePage(),
          },
        );
      },
    );
  }
}

const MaterialColor primaryBlack = MaterialColor(
  _blackPrimaryValue,
  <int, Color>{
    50: Color(0xFF000000),
    100: Color(0xFF000000),
    200: Color(0xFF000000),
    300: Color(0xFF000000),
    400: Color(0xFF000000),
    500: Color(_blackPrimaryValue),
    600: Color(0xFF000000),
    700: Color(0xFF000000),
    800: Color(0xFF000000),
    900: Color(0xFF000000),
  },
);
const int _blackPrimaryValue = 0xFF000000;
