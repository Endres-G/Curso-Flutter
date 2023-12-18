import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:teste_app/components/my_drawer.dart';
import 'package:teste_app/components/other_drawer.dart';
import 'package:teste_app/components/other_postagem_card.dart';
import 'package:teste_app/components/pesquisa.dart';
import 'package:teste_app/components/postagens_card.dart';
import 'package:teste_app/models/models.dart';
import 'package:teste_app/models/my_posts_model.dart';
import 'package:teste_app/models/other_user_profile.dart';
import 'package:teste_app/models/others_model.dart';
import 'package:teste_app/models/user_profile.dart';
import 'package:teste_app/other/app_controller.dart';
import 'package:teste_app/models/models.dart';
import 'package:http/http.dart' as http;
import 'package:teste_app/other/other_user_provider.dart';
import 'package:teste_app/other/user_data_provider.dart';
import 'package:teste_app/pages/escrever_post_others.dart';
import 'package:teste_app/pages/login_page.dart';

class OthersHomePage extends StatefulWidget {
  // String name;
//  HomePage({Key? key, required this.name});
  @override
  State<StatefulWidget> createState() {
    return OthersHomePageState();
  }
}

class OthersHomePageState extends State<OthersHomePage> {
  List<String> _listaDeTextos = [];

  Future<String> dadosUser(String username) async {
    final url =
        Uri.parse("https://social-network-golang.onrender.com/users/$username");

    try {
      var response = await http.get(url);
      if (response.statusCode == 200) {
        globalotherUser = response.body;
        print(response.body);
        print("DEU CERTO NAS APIS VINCULADAS");

        Navigator.of(context).pushReplacementNamed('/user');
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

  Future<void> _loadMessages(String? username) async {
    if (username != null) {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      List<String>? messages = prefs.getStringList('$username-messages') ?? [];
      setState(() {
        _listaDeTextos = messages;
      });
    }
  }

  Future<void> _atualizarDados() async {
    await Future.delayed(Duration(seconds: 2));

    // Limpe a lista antes de adicionarmos os novos textos

    setState(() {
      // Adicione os novos textos
      var dados = globalResponse;
      var userProfile = OtherUserProfile.fromJson(json.decode(dados));
      var user = userProfile.info.username;
      print("DENTRO DO CARREGANDO DA HOMEOUTRO");
      print(userProfile.info.name);

      // Itera sobre os murais e adiciona os textos à lista
      if (userProfile.info.mural != null) {
        // verifica se esse usuario é um que recebe
        for (var muralItem in userProfile.info.mural!) {
          _loadMessages(user!); // Load messages for this user
          print(muralItem.text);
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    List<String> _listaDeTextos =
        context.read<OtherUserDataProvider>().otherListaDeTextos;

    var dados = globalotherUser;
    var otherUserProfile = OtherUserProfile.fromJson(json.decode(dados));

    print(otherUserProfile.info.name);
    var user = otherUserProfile.info.username;

    Map<String, dynamic>? enviadoMap =
        context.watch<EscrevendoPostNotifier>().enviadoMap;

    print(enviadoMap);

    print(enviadoMap?["username2"]);

    print(globalUsername);
    return Scaffold(
      drawer: OtherDrawer(),
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.white),
        title: Text(
          "@$user",
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.black,
      ),
      body: RefreshIndicator(
        onRefresh: _atualizarDados,
        child: ListView(
          children: [
            MySearch(),
            // verifica se esse usuario é um que recebe

            for (var texto in _listaDeTextos)
              if (user == enviadoMap?['username2'])
                OthersPostCard(texto: texto),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        shape: CircleBorder(),
        onPressed: () {
          print("tentando");
          Navigator.of(context).pushNamed('/escrita2');
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
