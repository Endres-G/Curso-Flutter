import 'dart:convert';
import 'package:teste_app/components/pesquisa.dart';
import 'package:teste_app/models/user_profile.dart';
import 'package:teste_app/other/user_data_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:teste_app/other/user_data_provider.dart';
import 'package:teste_app/pages/config_page.dart';
import 'package:teste_app/pages/home_page.dart';
import 'package:teste_app/pages/login_page.dart';

class OtherDrawer extends StatefulWidget {
  const OtherDrawer({
    super.key,
  });

  @override
  State<OtherDrawer> createState() => _OtherDrawer();
}

class _OtherDrawer extends State<OtherDrawer> {
  @override
  Widget build(BuildContext context) {
    final userDataProvider = context.watch<UserDataProvider>();
    String meuUsername = userDataProvider.userData;

    print("aqqqqq"); // var name = data["name"];

    var dados = globalotherUser;
    var userProfile = UserProfile.fromJson(json.decode(dados));
    var name = userProfile.info.name;
    var username = userProfile.info.username;
    var bio = userProfile.info.bio;

    return Drawer(
      //CANTO SUPERIOR ESQUERDO
      child: Column(children: [
        Container(
          child: UserAccountsDrawerHeader(
            currentAccountPictureSize: Size(70, 70),
            decoration: BoxDecoration(color: Colors.black),
            currentAccountPicture: ClipRRect(
              borderRadius: BorderRadius.circular(40),
              child: Image.network(
                  "https://static.gameloop.com/img/d269c5a56a9f448f3d99dad86f06166b.png?imageMogr2/thumbnail/172.8x172.8/format/webp"),
            ),
            margin: EdgeInsets.all(0.0), // Adicione margens aqui

            accountName: Text(
              "$name",
              style: TextStyle(fontSize: 16),
            ),
            accountEmail: Text("@$username",
                style: TextStyle(color: Colors.grey, fontSize: 12)),
          ),
        ),
        Card(
          child: Expanded(
            child: ListTile(
              leading: Icon(Icons.person),
              title: Text(
                "$bio ",
                textAlign: TextAlign.start,
              ),
            ),
          ),
        ),
        Card(
          child: ListTile(
            leading: Icon(Icons.auto_awesome),
            title: Text(
              "Modo ",
              textAlign: TextAlign.start,
            ),
            trailing: CustomSwitch(),
            subtitle: Text(
              "escuro/claro",
              textAlign: TextAlign.start,
            ),
          ),
        ),
        Card(
          child: ListTile(
            leading: Icon(Icons.settings),
            title: Text("Meu perfil"),
            subtitle: Text("volte ao seu perfil"),
            onTap: () {
              print("quase mudaaa");
              Navigator.of(context).pushReplacementNamed('/home');
            },
          ),
        ),
        Card(
          child: ListTile(
            leading: Icon(Icons.home),
            title: Text("Logout"),
            subtitle: Text("encerrar sessão"),
            onTap: () {
              Navigator.of(context).pushReplacementNamed('/');
            },
          ),
        ),
      ]),
    );
  }
}
