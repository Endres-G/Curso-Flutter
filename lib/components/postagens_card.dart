import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:teste_app/other/user_data_provider.dart';
import 'package:teste_app/pages/login_page.dart';

class MyPostsCards extends StatefulWidget {
  final String texto;
  const MyPostsCards({Key? key, required this.texto}) : super(key: key);

  @override
  State<MyPostsCards> createState() => _MyPostsCardsState();
}

class _MyPostsCardsState extends State<MyPostsCards> {
  @override
  Widget build(BuildContext context) {
    final userDataProvider = context.watch<UserDataProvider>();
    String userData = userDataProvider.userData;

    // var data = jsonDecode(userData);
    // var username = data["username"];

    return Container(
      margin: EdgeInsets.all(3),
      width: MediaQuery.of(context).size.width / 1.03,
      color: Colors.black,
      padding: EdgeInsets.all(16.0),
      child: Column(
        mainAxisSize: MainAxisSize.min, // Altura dinâmica
        children: [
          Row(
            children: [
              CircleAvatar(
                radius: 30,
                // backgroundImage: NetworkImage(
                //   'https://static.gameloop.com/img/d269c5a56a9f448f3d99dad86f06166b.png?imageMogr2/thumbnail/172.8x172.8/format/webp', // URL da foto
                // ),
              ),
              SizedBox(width: 16.0), // Espaço entre a foto e o nome

              Text(
                globalUsername,
                style: TextStyle(fontSize: 16.0, color: Colors.white),
              ),
            ],
          ),

          SizedBox(height: 12.0),
          // Espaço entre o nome e o texto
          Align(
            alignment: Alignment.bottomLeft,
            child: Text(
              widget.texto,
              style: TextStyle(fontSize: 14.0, color: Colors.white),
            ),
          ),
          // Adicione mais Text widgets conforme necessário
        ],
      ),
    );
  }
}
