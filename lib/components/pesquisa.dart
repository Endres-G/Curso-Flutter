import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:teste_app/other/user_data_provider.dart';
import 'package:http/http.dart' as http;
import 'package:teste_app/pages/login_page.dart';

String globalotherUser = "";

class MySearch extends StatefulWidget {
  const MySearch({Key? key});

  @override
  State<MySearch> createState() => _MySearchState();
}

class _MySearchState extends State<MySearch> {
  TextEditingController _searchController = TextEditingController();
  bool _mostrarResultados = false;
  List<String> _listaDeNomes = [];

  Future<void> mandaApi(Map<String, dynamic> mapSearch) async {
    print(mapSearch);
    var envio = jsonEncode(mapSearch);
    print(envio);

    final url = Uri.parse("https://social-network-golang.onrender.com/search");
    final resposta = await http.post(
      url,
      body: envio,
      headers: {'Content-Type': 'application/json'},
    );

    if (resposta.statusCode == 200) {
      globalotherUser = resposta.body;
      print(globalotherUser);
      print("É A GLOBAAAAALL");

      setState(() {
        _mostrarResultados = true;
        _listaDeNomes = List<String>.from(jsonDecode(resposta.body)['results']);
      });

      showDialog(
        context: context,
        builder: (BuildContext context) {
          return Center(
            child: Container(
              height: 500,
              child: AlertDialog(
                shape: RoundedRectangleBorder(
                  borderRadius:
                      BorderRadius.all(Radius.circular(0)), // Quadrado
                ),
                title: Text('Resultados da Pesquisa'),
                content: SingleChildScrollView(
                  child: Column(
                    children: [
                      for (var username in _listaDeNomes)
                        Container(
                          width: 200,
                          margin: EdgeInsets.all(8),
                          padding: EdgeInsets.all(15),
                          decoration: BoxDecoration(
                            color: Colors.black,
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: GestureDetector(
                            onTap: () async {
                              print("vai ver perfil $username");
                              Navigator.pop(context); // Fecha o AlertDialog
                              await dadosUser(username);
                            },
                            child: Text(
                              username,
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                              ),
                            ),
                          ),
                        ),
                    ],
                  ),
                ),
                actions: <Widget>[
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: Text('Fechar'),
                  ),
                ],
              ),
            ),
          );
        },
      );
    } else {
      throw Exception("Erro ao enviar dados");
    }
  }

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

  @override
  Widget build(BuildContext context) {
    final userDataProvider = context.watch<UserDataProvider>();
    String userData = userDataProvider.userData;

    // var data = jsonDecode(userData);
    // var username = data["username"];
    // var name = data["name"];

    var mapSearch = {
      "username": globalUsername,
      "searchTerm": _searchController.text,
    };

    return Container(
      color: Colors.black,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            TextFormField(
              controller: _searchController,
              style: TextStyle(color: Colors.white),
              keyboardType: TextInputType.emailAddress,
              decoration: InputDecoration(
                prefixIconColor: Colors.white,
                prefixIcon: GestureDetector(
                  onTap: () {
                    if (_searchController.text != null ||
                        _searchController.text.isEmpty) {
                      mandaApi(mapSearch);
                    }
                  },
                  child: Icon(
                    Icons.search,
                    size: 35,
                  ),
                ),
                contentPadding: const EdgeInsets.symmetric(vertical: 3.0),
                label: Text("Pesquisa", style: TextStyle(color: Colors.white)),
                labelStyle: TextStyle(color: Colors.white),
                hintStyle: TextStyle(color: Colors.grey),
                hintText: "procure um conhecido",
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.white),
                ),
              ),
              onChanged: (value) {
                mapSearch["searchTerm"] = _searchController.text;
              },
            ),
          ],
        ),
      ),
    );
  }
}
