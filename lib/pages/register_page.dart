import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:teste_app/api/api_service.dart';
import 'package:teste_app/pages/home_page.dart';
import 'package:teste_app/models/models.dart';
import 'package:http/http.dart' as http;

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final _formKey = GlobalKey<FormState>();
  bool _versenha = false;
  TextEditingController _senhaController = TextEditingController();
  TextEditingController _usernameController = TextEditingController();
  TextEditingController _nomeController = TextEditingController();

  Future<void> logar(map) async {
    try {
      var url =
          Uri.parse('https://social-network-golang.onrender.com/register');

      print('Enviando requisição para: $url');
      print('Corpo da requisição: ${jsonEncode(map)}');

      var response = await http.post(
        url,
        body: jsonEncode(map),
        headers: {'Content-Type': 'application/json'},
      );

      print('Status code da resposta: ${response.statusCode}');

      if (response.statusCode == 200) {
        print('Requisição bem-sucedida. Redirecionando...');
        Navigator.of(context).pushReplacementNamed('/');
      } else {
        print('Erro na requisição. Status code: ${response.statusCode}');
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text("Algo deu errado. Status code: ${response.statusCode}"),
        ));
      }
    } catch (e) {
      print('Erro durante a requisição: $e');
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text("Ocorreu um erro inesperado."),
      ));
    }
  }

  _body() {
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
            TextFormField(
                style: TextStyle(color: Colors.white),
                controller: _usernameController,
                keyboardType: TextInputType.name,
                decoration: InputDecoration(
                  enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.white, width: 2.0)),
                  label:
                      Text("Username", style: TextStyle(color: Colors.white)),
                  labelStyle: TextStyle(color: Colors.white),
                  hintStyle: TextStyle(color: Colors.grey),
                  hintText: "Username",
                ),
                validator: (username) {
                  if (username == null || username.isEmpty) {
                    return "Digite seu Username";
                  }
                }),
            Padding(padding: EdgeInsets.all(10)),
            TextFormField(
              style: TextStyle(color: Colors.white),
              controller: _nomeController,
              keyboardType: TextInputType.emailAddress,
              decoration: InputDecoration(
                enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.white, width: 2.0)),
                label: Text("Nome", style: TextStyle(color: Colors.white)),
                labelStyle: TextStyle(color: Colors.white),
                hintStyle: TextStyle(color: Colors.grey),
                hintText: "Nome",
              ),
              validator: (nome) {
                if (nome == null || nome.isEmpty) {
                  return "Digite seu nome";
                }
              },
            ),
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
                    if (_formKey.currentState!.validate()) {
                      //registrou;
                      var map = {
                        'name': _nomeController.text,
                        'username': _usernameController.text,
                        'password': _senhaController.text,
                      };
                      print(map);
                      logar(map);
                    }
                  },
                  child: Text("Registrar"),
                ),
                Padding(padding: const EdgeInsets.all(8)),
                GestureDetector(
                  onTap: () {
                    Navigator.of(context).pushReplacementNamed('/');
                  },
                  child: Container(
                    child: Text("Ou fazer login!",
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

  Future manda(mapString) async {
    var envio = RegistrarUsuario().enviarDados(mapString);
    return envio;
  }

  @override
  Widget build(BuildContext context) {
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
}
