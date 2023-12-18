import 'dart:convert';
import 'dart:ffi';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:teste_app/other/user_data_provider.dart';
import 'package:teste_app/pages/home_page.dart';
import 'package:http/http.dart' as http;
import 'package:teste_app/pages/register_page.dart';

String globalResponse = ''; // Variável global para armazenar o response.body
String globalUsername = '';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  bool _versenha = false;
  final _usernameController = TextEditingController();
  final _senhaController = TextEditingController();

  void onPressedEntrar(BuildContext context) {
    var map = {
      'username': _usernameController.text,
      'password': _senhaController.text,
    };

    logar(map, context);
  }

  static Future<String> dadosUser(String username) async {
    final url =
        Uri.parse("https://social-network-golang.onrender.com/users/$username");

    try {
      var response = await http.get(url);
      if (response.statusCode == 200) {
        globalResponse = response.body; // Atualiza a variável global
        globalUsername = username;
        print(response.body);
        print("DEU CERTO NAS APIS VINCULADAS");
        return response.body;
      } else {
        print("DEU ERRADO NA API");
        return ""; // ou outro valor padrão, dependendo do seu caso
      }
    } catch (error) {
      print("Erro na requisição: $error");
      return ""; // ou outro valor padrão, dependendo do seu caso
    }
  }

  Widget _body() {
    return Form(
      key: _formKey,
      child: Center(
          child: SizedBox(
        width: MediaQuery.of(context).size.width / 1.3,
        height: MediaQuery.of(context).size.height,
        child: Padding(
          padding: const EdgeInsets.all(8),
          child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
            Image.asset(
              "assets/images/logo2.png",
              width: 300,
              height: 300,
            ),
            Padding(padding: EdgeInsets.all(10)),
            TextFormField(
                style: TextStyle(color: Colors.white),
                controller: _usernameController,
                keyboardType: TextInputType.emailAddress,
                decoration: InputDecoration(
                  enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.white, width: 2.0)),
                  label:
                      Text("Username", style: TextStyle(color: Colors.white)),
                  labelStyle: TextStyle(color: Colors.white),
                  hintStyle: TextStyle(color: Colors.grey),
                  hintText: "username",
                ),
                validator: (username) {
                  if (username == null || username.isEmpty) {
                    return "Digite seu username";
                  }
                }),
            Padding(padding: EdgeInsets.all(10)),
            TextFormField(
              style: TextStyle(color: Colors.white),
              controller: _senhaController,
              keyboardType: TextInputType.visiblePassword,
              obscureText: !_versenha,
              decoration: InputDecoration(
                  suffixIcon: IconButton(
                    icon: Icon(_versenha
                        ? Icons.visibility_outlined
                        : Icons.visibility_off_outlined),
                    onPressed: () {
                      setState(() {
                        _versenha = !_versenha;
                      });
                    },
                    color: Colors.white,
                  ),
                  enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.white, width: 2.0)),
                  label: Text("Senha", style: TextStyle(color: Colors.white)),
                  labelStyle: TextStyle(color: Colors.white),
                  hintStyle: TextStyle(color: Colors.grey),
                  hintText: "digite sua senha"),
              validator: (senha) {
                if (senha == null || senha.isEmpty) {
                  return "Digite sua senha";
                } else if (senha.length < 6) {
                  return "digite uma senha maior";
                }
                return null;
              },
            ),
            SizedBox(
              height: 60,
              child:
                  Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                ElevatedButton(
                  onPressed: () {
                    onPressedEntrar(context);
                  },
                  child: Text("Entrar"),
                ),
                Padding(padding: const EdgeInsets.all(8)),
                GestureDetector(
                  onTap: () {
                    Navigator.of(context).pushReplacementNamed('/register');
                  },
                  child: Container(
                    child: Text("Registrar",
                        style: TextStyle(color: Colors.white)),
                  ),
                )
              ]),
            )
          ]),
        ),
      )),
    );
  }

  @override
  Widget build(BuildContext context) {
    final userDataProvider = Provider.of<UserDataProvider>(context);

    return Scaffold(
        body: Stack(
      children: [
        SizedBox(
            height: MediaQuery.of(context).size.height,
            child: Image.asset("assets/images/fundo2.jpeg", fit: BoxFit.cover)),
        Container(color: Colors.black.withOpacity(0.9)),
        SingleChildScrollView(child: _body()),
      ],
    ));
  }

  Future<void> logar(Map<String, dynamic> map, BuildContext context) async {
    final userDataProvider =
        Provider.of<UserDataProvider>(context, listen: false);

    if (_usernameController.text.isNotEmpty) {
      var response = await http.post(
        Uri.parse('https://social-network-golang.onrender.com/login'),
        body: (jsonEncode(map)),
        headers: {'Content-Type': 'application/json'},
      );

      if (response.statusCode == 200) {
        String userData = await dadosUser(_usernameController.text);
        userDataProvider.updateUserData(userData, _usernameController.text);
        Navigator.of(context).pushReplacementNamed('/home');
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Senha ou usuário inválidos")),
        );
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("invalid")),
      );
    }
  }
}
