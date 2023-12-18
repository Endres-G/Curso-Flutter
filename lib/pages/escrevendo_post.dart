import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:teste_app/components/pesquisa.dart';
import 'package:teste_app/models/user_profile.dart';
import 'package:teste_app/other/user_data_provider.dart';
import 'package:teste_app/pages/login_page.dart';
import 'package:http/http.dart' as http;

class EscrevendoMyPost extends StatefulWidget {
  const EscrevendoMyPost({super.key});

  @override
  State<EscrevendoMyPost> createState() => _EscrevendoMyPostState();
}

class _EscrevendoMyPostState extends State<EscrevendoMyPost> {
  static var meuTextoController = TextEditingController();

  onPressedEnviar() {
    var dados =
        Provider.of<UserDataProvider>(context, listen: false).globalResponse;
    var userProfile = UserProfile.fromJson(json.decode(dados));
    var a = userProfile.info.name;

    String meutexto = meuTextoController.text;
    Provider.of<UserDataProvider>(context, listen: false)
        .adicionarTexto(meutexto);
    var map = {
      "username1": globalUsername,
      "username2": globalUsername,
      "text": meutexto,
    };
    return map;
  }

  Future mandaApi() async {
    var map = onPressedEnviar();

    var url =
        Uri.parse("https://social-network-golang.onrender.com/create-post");

    var response = await http.post(url,
        body: jsonEncode(map), headers: {'Content-Type': 'application/json'});

    if (response.statusCode == 200) {
      print("postado");
      print(map);
    }
  }

  @override
  Widget build(BuildContext context) {
    final userDataProvider = context.watch<UserDataProvider>();
    String userMessageText = userDataProvider.textValue;
    var dados = globalResponse;
    var userProfile = UserProfile.fromJson(json.decode(dados));

    // var dados = globalotherUser;
    // var userProfile = UserProfile.fromJson(json.decode(dados));
    //var user = userProfile.info.username;

    return Scaffold(
        body: Container(
      padding: EdgeInsets.all(15),
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      color: Colors.black,
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(
                top:
                    50.0), // Adiciona uma margem de 20 unidades na parte superior
            child: Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment
                  .spaceBetween, // Alinha os elementos à esquerda e à direita

              children: [
                FloatingActionButton(
                  shape: CircleBorder(),
                  backgroundColor: Colors.amber,
                  child: const Icon(
                    Icons.arrow_back_sharp,
                    color: Colors.black,
                  ),
                  onPressed: () {
                    Navigator.of(context).pushReplacementNamed('/home');
                  },
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(primary: Colors.amber),
                  child: Text(
                    "Enviar",
                    style: TextStyle(fontSize: 14),
                  ),
                  onPressed: () async {
                    // Adiciona o texto à lista
                    mandaApi();

                    await Future.delayed(Duration(seconds: 2));

                    // Obtém os novos textos após o envio
                    meuTextoController.text = '';
                    // Atualiza a tela da HomePage
                    Navigator.of(context).pop();
                  },
                ),
              ],
            ),
          ),
          SizedBox(
            height: 50,
          ),
          Row(
            children: [
              CircleAvatar(
                radius: 40,
                backgroundImage: NetworkImage(
                  'https://media.discordapp.net/attachments/1051613820289822740/1185665734483922964/image.png?ex=65907043&is=657dfb43&hm=dde75d5c5462ad343c358f15e3ac5d44e45f8a371bb5e853eacf837c1b4b8072&=&format=webp&quality=lossless&width=735&height=683', // URL da foto
                ),
              ),
              SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Container(
                    width: 200, // Defina a largura desejada aqui
                    child: TextFormField(
                      controller: meuTextoController,
                      maxLines: null, // Permite múltiplas linhas
                      autofocus: true,
                      style: TextStyle(color: Colors.white),
                      decoration: InputDecoration(
                        labelText: 'Digite algo',
                        hintStyle: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                ),
              )
            ],
          )
        ],
      ),
    ));
  }
}
