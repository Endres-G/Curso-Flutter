import 'dart:convert';

import 'package:http/http.dart';
import 'package:teste_app/models/models.dart';

class APIService {
  Future<Registro> dale(Registro RequestModel) async {
    String url = "https://social-network-graphs-api.onrender.com/register";

    final response = await post(Uri.parse(url), body: RequestModel.toJson());

    if (response.statusCode == 200 || response == 400) {
      return Registro.fromJson(json.decode(response.body));
    } else {
      throw Exception("Failed to load Data");
    }
  }
}
