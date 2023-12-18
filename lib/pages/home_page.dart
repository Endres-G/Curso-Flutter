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

class HomePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return HomePageState();
  }
}

class HomePageState extends State<HomePage> {
  List<String> _listaDeTextos = [];

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

  Future<void> _atualizarDados() async {
    await Future.delayed(Duration(seconds: 2));
    // Limpe a lista antes de adicionarmos os novos textos
    _listaDeTextos.clear();

    setState(() {
      dadosUser(globalUsername);
      // Adicione os novos textos
      var dados = globalResponse;
      var userProfile = UserProfile.fromJson(json.decode(dados));

      print("DENTRO DO CARREGANDO DA HOME");

      // Itera sobre os murais e adiciona os textos à lista
      if (userProfile.info.mural != null) {
        // verifica se esse usuario é um que recebe
        for (var muralItem in userProfile.info.mural!) {
          _listaDeTextos.add(muralItem.text);
          print(muralItem.text);
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    // Limpe a lista antes de adicionarmos os novos textos
    var dados = globalResponse;
    var userProfile = UserProfile.fromJson(json.decode(dados));
    List<String> _myTexts = context.read<UserDataProvider>().listaDeTextos;

    print("DENTRO DO CARREGANDO DA HOME");
    print(userProfile.info.name);

    // Itera sobre os murais e adiciona os textos à lista
    if (userProfile.info.mural != null) {
      for (var muralItem in userProfile.info.mural!) {
        _listaDeTextos.add(muralItem.text);
        print(muralItem.text);
      }
    }
    return Scaffold(
      drawer: MyDrawer(),
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.white),
        title: Text(
          "OrBee",
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.black,
      ),
      body: RefreshIndicator(
        onRefresh: _atualizarDados,
        child: ListView(
          children: [
            MySearch(),
            for (var texto in _listaDeTextos) MyPostsCards(texto: texto),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        shape: CircleBorder(),
        onPressed: () {
          print("tentando");
          Navigator.of(context).pushNamed('/escrita');
        },
        backgroundColor: Colors.amber,
        child: const Icon(Icons.add, color: Colors.black),
      ),
    );
  }
}

class CustomSwitch extends StatelessWidget {
  const CustomSwitch({Key? key});

  @override
  Widget build(BuildContext context) {
    return Switch(
      value: AppController.instance.isDarkTheme,
      onChanged: (value) {
        AppController.instance.changeTheme();
      },
    );
  }
}
