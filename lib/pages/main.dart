import 'package:flutter/material.dart';
import 'package:teste_app/other/app_widget.dart';
import 'package:provider/provider.dart';
import 'package:teste_app/other/other_user_provider.dart';
import 'package:teste_app/other/user_data_provider.dart';
import 'package:teste_app/pages/escrevendo_post.dart';
import 'package:teste_app/pages/escrever_post_others.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => OtherUserDataProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => UserDataProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => EscrevendoPostNotifier(),
        ),
      ],
      child: MaterialApp(
        home: AppWidget(
          title: "Orbee",
        ),
      ),
    ),
  );
}
