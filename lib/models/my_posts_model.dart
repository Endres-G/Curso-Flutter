import 'dart:convert';
import 'package:http/http.dart' as http;

class MinhasMensagens {
  minhasMensagens() {
    List<String> listaDeTextos = [
      "Texto 1",
      "Texto 2",
      "Texto 3",
    ];

    String jsonListaDeTextos = jsonEncode(listaDeTextos);
    print(jsonListaDeTextos);
    return jsonListaDeTextos;
  }
}
