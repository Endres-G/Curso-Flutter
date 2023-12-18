import 'dart:convert';

import 'package:http/http.dart' as http;

// To parse this JSON data, do
//
//     final models = modelsFromJson(jsonString);

Registro modelsFromJson(String str) => Registro.fromJson(json.decode(str));

String modelsToJson(Registro data) => json.encode(data.toJson());

class Registro {
  String type;
  String username;
  String name;
  String age;

  Registro({
    required this.type,
    required this.username,
    required this.name,
    required this.age,
  });

  factory Registro.fromJson(Map<String, dynamic> json) => Registro(
        type: json["type"],
        username: json["username"],
        name: json["name"],
        age: json["age"],
      );

  Map<String, dynamic> toJson() => {
        "type": type,
        "username": username,
        "name": name,
        "age": age,
      };
}

class RegistrarUsuario {
  registrar(type, user, nome) {
    var map = {
      "type": type,
      "username": user,
      "name": nome,
      "age": 23,
    };
    return map;
  }

  logar(user) {
    var map = {"username": user};
    return map;
  }

  Future enviarLogin(envio) async {
    final url = "https://social-network-graphs-api.onrender.com/login";
    final resposta = await http.post(Uri.parse(url),
        body: envio, headers: {'Content-Type': 'application/json'});
    if (resposta.statusCode == 200) {
      print("Resposta do servidor: ${resposta.body}");
    } else {
      print("erro ao enviar dados");
      print("$resposta.statusCode");
    }
  }

  Future enviarDados(envio) async {
    final url = "https://social-network-graphs-api.onrender.com/register";
    final response = await http.post(Uri.parse(url),
        body: envio, headers: {'Content-Type': 'application/json'});

    return enviarDados(envio);
  }

  Future receberUsuarioApi(username) async {
    final url = Uri.parse(
        "https://social-network-graphs-api.onrender.com/user/$username");
    final response = await http.get(url);
    print(response.body);
    if (response.statusCode == 200) {
      return true;
    }
    return false;
  }
}

class Info {
  String? age;
  int? followersQty;
  String? kind;
  String? name;
  String? username;

  Info({this.age, this.followersQty, this.kind, this.name, this.username});

  Info.fromJson(Map<String, dynamic> json) {
    age = json['age'];
    followersQty = json['followersQty'];
    kind = json['kind'];
    name = json['name'];
    username = json['username'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['age'] = this.age;
    data['followersQty'] = this.followersQty;
    data['kind'] = this.kind;
    data['name'] = this.name;
    data['username'] = this.username;
    return data;
  }
}

class SearchModel {
  String? username;
  String? searchTerm;

  SearchModel({this.username, this.searchTerm});

  SearchModel.fromJson(Map<String, dynamic> json) {
    username = json['username'];
    searchTerm = json['searchTerm'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['username'] = this.username;
    data['searchTerm'] = this.searchTerm;
    return data;
  }
}
