import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:teste_app/components/my_drawer.dart';
import 'package:teste_app/components/pesquisa.dart';
import 'package:teste_app/components/postagens_card.dart';
import 'package:teste_app/models/models.dart';
import 'package:teste_app/models/my_posts_model.dart';
import 'package:teste_app/other/app_controller.dart';
import 'package:teste_app/other/user_data_provider.dart';
import 'package:teste_app/pages/login_page.dart';
import 'package:teste_app/models/user_profile.dart';
import 'package:http/http.dart' as http;

class ConfigPage extends StatefulWidget {
  const ConfigPage({super.key});

  @override
  State<ConfigPage> createState() => _ConfigPageState();
}

class _ConfigPageState extends State<ConfigPage> {
  TextEditingController _newNameController = TextEditingController();
  TextEditingController _newbioController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  var username = globalUsername;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Meu perfil"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Center(
            child: Container(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  TextFormField(
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Digite algo";
                      } else {
                        return null;
                      }
                    },
                    controller: _newNameController,
                    decoration: InputDecoration(
                      labelText: "Insira seu novo nome",
                    ),
                  ),
                  SizedBox(height: 16.0),
                  TextFormField(
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Digite sua senha";
                      } else {
                        return null;
                      }
                    },
                    controller: _newbioController,
                    decoration: InputDecoration(
                      labelText: "Insira sua biografia",
                    ),
                  ),
                  SizedBox(height: 16.0),
                  ElevatedButton(
                    onPressed: () {
                      if (_formKey.currentState?.validate() == true) {
                        var map = {
                          "name": _newNameController.text,
                          "bio": _newbioController.text,
                          "profilePicture": "dog.png"
                        };
                        enviarApi(username, map);

                        print("tenta enviaaaaa");
                      }
                    },
                    child: Text("Salvar mudanças"),
                  ),
                  SizedBox(height: 50.0),
                  Text(
                    "* Ao você salvar as mudanças, sera redirecionado ao login *",
                    style: TextStyle(
                        color: Colors.red, fontStyle: FontStyle.italic),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Future enviarApi(username, map) async {
    var url =
        Uri.parse("https://social-network-golang.onrender.com/users/$username");
    var response = await http.put(url, body: jsonEncode(map));

    if (response.statusCode == 200) {
      print(response.body);
      print("deu");
      // Fecha a tela atual
      Navigator.of(context).pushReplacementNamed('/home');
      return response.body;
      // Retorna para a tela anterior (pode ser a tela Home neste caso)
    } else {
      print("n deu");
      print(response.body);
    }
  }
}
