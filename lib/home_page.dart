import 'dart:io';

import 'package:flutter/material.dart';
import 'package:teste_app/app_controller.dart';

class HomePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return HomePageState();
  }
}

class HomePageState extends State<HomePage> {
  int count = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(
        child: Column(children: [
          UserAccountsDrawerHeader(
              currentAccountPicture: ClipRRect(
                borderRadius: BorderRadius.circular(40),
                child: Image.network(
                    "https://static.gameloop.com/img/d269c5a56a9f448f3d99dad86f06166b.png?imageMogr2/thumbnail/172.8x172.8/format/webp"),
              ),
              accountName: Text("Gabriel"),
              accountEmail: Text("1")),
          ListTile(
            leading: Icon(Icons.home),
            title: Text("inicio"),
            subtitle: Text("epaa"),
          ),
          ListTile(
            leading: Icon(Icons.home),
            title: Text("Logout"),
            subtitle: Text("encerrar sessão"),
            onTap: () {
              Navigator.of(context).pushReplacementNamed('/');
            },
          ),
        ]),
      ),
      appBar: AppBar(
        title: Text("Home Page"),
        actions: [CustomSwitch()],
      ),
      body: Container(
        width: double.infinity,
        height: double.infinity,
        child: ListView(
            //mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    width: 50,
                    height: 80,
                    color: Colors.black,
                  ),
                  Container(
                    width: 50,
                    height: 80,
                    color: Colors.yellow,
                  ),
                  Container(
                    width: 50,
                    height: 80,
                    color: Colors.red,
                  )
                ],
              ),
              Container(
                height: 50,
              ),
              CustomSwitch(),
              CustomSwitch(),
              CustomSwitch(),
              CustomSwitch(),
              Text("Contador: $count"),
            ]),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          setState(() {
            count++;
          });
        },
      ),
    );
  }
}

class CustomSwitch extends StatelessWidget {
  const CustomSwitch({super.key});

  @override
  Widget build(BuildContext context) {
    return Switch(
        value: AppController.instance.isDarkTheme,
        onChanged: (value) {
          AppController.instance.changeTheme();
        });
  }
}
