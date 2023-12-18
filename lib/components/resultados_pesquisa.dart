import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:teste_app/components/pesquisa.dart';

class ResultadoPesquisa extends StatelessWidget {
  final Future<Map<String, dynamic>> resultadoPesquisa;

  ResultadoPesquisa({required this.resultadoPesquisa});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: resultadoPesquisa,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return CircularProgressIndicator();
        } else if (snapshot.hasError) {
          return Text('Erro: ${snapshot.error}');
        } else {
          Map<String, dynamic> resultado =
              snapshot.data as Map<String, dynamic>;
          // Construa a interface com base no resultado
          // Exemplo: exibindo o resultado em um Text

          List<String> listaDeStrings = List<String>.from(resultado['results']);

          listaDeStrings.forEach((elemento) {
            print(elemento);
            print("qqisso");
          });

          // List<String> listaDeNomes =
          //     jsonDecode(resultado).cast<String>();
          // print(listaDeNomes);
          // print("aaaaaaaaa");
          // listaDeNomes.forEach((nome) {
          //   print(nome);
          // });

          return Center(
            child: Container(
              color: Colors.amber,
              width: 300, // Ajuste conforme necessário
              child: ListView.builder(
                itemCount: listaDeStrings.length,
                itemBuilder: (context, index) {
                  return Container(
                    padding: EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: Colors.black,
                    ),
                    child: Text(
                      listaDeStrings[index],
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                      ),
                    ),
                  );
                },
              ),
            ),
          );
        }
      },
    );
  }
}
