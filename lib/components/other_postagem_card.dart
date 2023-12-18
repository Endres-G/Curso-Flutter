import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:teste_app/components/pesquisa.dart';
import 'package:teste_app/models/user_profile.dart';
import 'package:teste_app/other/other_user_provider.dart';
import 'package:teste_app/other/user_data_provider.dart';

class OthersPostCard extends StatefulWidget {
  final String texto;
  const OthersPostCard({Key? key, required this.texto}) : super(key: key);

  @override
  State<OthersPostCard> createState() => OthersPostCardState();
}

class OthersPostCardState extends State<OthersPostCard> {
  @override
  Widget build(BuildContext context) {
    var otherUserDataProvider = context.watch<OtherUserDataProvider>();
    var otherGlobalResponse = otherUserDataProvider.otherGlobalResponse;

    var dados = globalotherUser;
    var userProfile = UserProfile.fromJson(json.decode(dados));
    var user = userProfile.info.username;
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
                "$user",
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
