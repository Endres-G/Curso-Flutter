import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:teste_app/pages/home_page.dart';
import 'package:teste_app/pages/login_page.dart';

class AppController extends ChangeNotifier {
  static AppController instance = AppController();
  bool isDarkTheme = false;

  changeTheme() {
    isDarkTheme = !isDarkTheme;
    notifyListeners();
  }
}

class Usuarios extends StatefulWidget {
  const Usuarios({super.key});

  @override
  State<Usuarios> createState() => _UsuariosState();
}

class _UsuariosState extends State<Usuarios> {
  @override
  initState() {
    super.initState();
    verificarUsuario().then((temUsuario) {
      if (temUsuario) {
        Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => HomePage(
                  //name: ""
                  ),
            ));
      } else {
        Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => LoginPage(),
            ));
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }

  Future<bool> verificarUsuario() async {
    SharedPreferences _sharedPreferences =
        await SharedPreferences.getInstance();
    String? token = _sharedPreferences.getString("token");
    if (token == null) {
      return false;
    } else {
      return true;
    }
  }
}
