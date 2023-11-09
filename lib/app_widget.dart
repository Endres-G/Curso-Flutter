import 'package:flutter/material.dart';
import 'package:teste_app/app_controller.dart';
import 'package:teste_app/home_page.dart';

class AppWidget extends StatelessWidget {
  final String title;

  const AppWidget({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return AnimatedBuilder(
      animation: AppController.instance,
      builder: (context, child) {
        return MaterialApp(
          theme: ThemeData(
              primarySwatch: Colors.blue,
              brightness: AppController.instance.isDarkTheme
                  ? Brightness.dark // if
                  : Brightness.light //else
              ),
          home: HomePage(),
        );
      },
    );
  }
}
