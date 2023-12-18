import 'dart:convert';
import 'package:teste_app/models/user_profile.dart';
import 'package:teste_app/other/user_data_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:teste_app/other/user_data_provider.dart';
import 'package:teste_app/pages/config_page.dart';
import 'package:teste_app/pages/home_page.dart';
import 'package:teste_app/pages/login_page.dart';

class MyDrawer extends StatefulWidget {
  const MyDrawer({
    super.key,
  });

  @override
  State<MyDrawer> createState() => _MyDrawerState();
}

class _MyDrawerState extends State<MyDrawer> {
  @override
  Widget build(BuildContext context) {
    final userDataProvider = context.watch<UserDataProvider>();
    String meuUsername = userDataProvider.userData;

    print("aqqqqq"); // var name = data["name"];

    var dados = globalResponse;
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
                  "https://media.discordapp.net/attachments/1051613820289822740/1185665734483922964/image.png?ex=65907043&is=657dfb43&hm=dde75d5c5462ad343c358f15e3ac5d44e45f8a371bb5e853eacf837c1b4b8072&=&format=webp&quality=lossless&width=735&height=683"),
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
            subtitle: Text("edite sua bio"),
            onTap: () {
              print("quase mudaaa");
              Navigator.of(context)
                  .push(MaterialPageRoute(builder: (context) => ConfigPage()))
                  .then((_) {
                // Atualiza os dados após retornar da página de configuração
                userDataProvider.setUserProfile(
                    UserProfile.fromJson(json.decode(globalResponse)));
              });
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
