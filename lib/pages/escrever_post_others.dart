import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:teste_app/components/pesquisa.dart';
import 'package:teste_app/models/other_user_profile.dart';
import 'package:teste_app/models/user_profile.dart';
import 'package:teste_app/other/other_user_provider.dart';
import 'package:teste_app/other/user_data_provider.dart';
import 'package:teste_app/pages/login_page.dart';
import 'package:http/http.dart' as http;

class EscrevendoPostNotifier extends ChangeNotifier {
  Map<String, dynamic>? _enviadoMap;

  Map<String, dynamic>? get enviadoMap => _enviadoMap;

  void updateEnvaidoMap(Map<String, dynamic>? map) {
    _enviadoMap = map;
    notifyListeners();
  }
}

class EscrevendoPostOthers extends StatefulWidget {
  const EscrevendoPostOthers({super.key});

  @override
  State<EscrevendoPostOthers> createState() => _EscrevendoMyPostState();
}

class _EscrevendoMyPostState extends State<EscrevendoPostOthers> {
  static var _meuTextoControllerOther = TextEditingController();
  Map<String, dynamic>? _enviadoMap;

  Map<String, dynamic>? get enviadoMap => _enviadoMap;

  onPressedEnviar() {
    var dados = globalotherUser;
    var otherUserProfile = OtherUserProfile.fromJson(json.decode(dados));

    print(otherUserProfile.info.name);
    var user = otherUserProfile.info.username;

    print(user);
    print("esse é o user");

    String meutexto = _meuTextoControllerOther.text;
    Provider.of<OtherUserDataProvider>(context, listen: false)
        .adicionarOtherTexto(meutexto);
    var map = {
      "username1": globalUsername,
      "username2": user,
      "text": meutexto,
    };
    _enviadoMap = map;

    return map;
  }

  Future mandaApi() async {
    var map = onPressedEnviar();

    EscrevendoPostNotifier notifier =
        Provider.of<EscrevendoPostNotifier>(context, listen: false);
    notifier.updateEnvaidoMap(map);

    var url =
        Uri.parse("https://social-network-golang.onrender.com/create-post");

    var response = await http.post(url,
        body: jsonEncode(map), headers: {'Content-Type': 'application/json'});

    if (response.statusCode == 200) {
      print("postado");
      print(map);
    }
  }

  Future<void> saveMessage(String? username, String text) async {
    if (username != null) {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      List<String>? messages = prefs.getStringList('$username-messages') ?? [];
      messages.add(text);
      prefs.setStringList('$username-messages', messages);
    }
  }

  @override
  Widget build(BuildContext context) {
    Provider.of<OtherUserDataProvider>(context, listen: false);

    final otherUserDataProvider = context.watch<OtherUserDataProvider>();
    String userMessageText = otherUserDataProvider.textValue;

    var _otherUserDataProvider = context.watch<OtherUserDataProvider>();
    var otherGlobalResponse = otherUserDataProvider.otherGlobalResponse;

    var dados = globalotherUser;
    var otherUserProfile = OtherUserProfile.fromJson(json.decode(dados));

    print(otherUserProfile.info.name);
    var user = otherUserProfile.info.username;

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
                    Navigator.of(context).pop();
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
                    _meuTextoControllerOther.text = '';
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
                      controller: _meuTextoControllerOther,
                      maxLines: null, // Permite múltiplas linhas
                      autofocus: true,
                      style: TextStyle(color: Colors.white),
                      decoration: InputDecoration(
                        labelText: 'Digite algo para $user',
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
