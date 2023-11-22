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
              CustomSwitch(),
              CustomSwitch(),
              CustomSwitch(),
              CustomSwitch(),
              CustomSwitch(),
              CustomSwitch(),
              CustomSwitch(),
              CustomSwitch(),
              CustomSwitch(),
              CustomSwitch(),
              CustomSwitch(),
              CustomSwitch(),
              CustomSwitch(),
              CustomSwitch(),
              CustomSwitch(),
              CustomSwitch(),
              CustomSwitch(),
              CustomSwitch(),
              CustomSwitch(),
              CustomSwitch(),
              CustomSwitch(),
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
