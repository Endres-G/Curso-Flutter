import 'package:flutter/material.dart';
import 'package:teste_app/models/user_profile.dart';

class UserDataProvider with ChangeNotifier {
  String _userData = "";

  String get userData => _userData;

  String _textValue = '';

  String get textValue => _textValue;

  List<String> _listaDeTextos = [];

  List<String> get listaDeTextos => _listaDeTextos;

  UserProfile? _userProfile;

  UserProfile? get userProfile => _userProfile;

  String _globalResponse = '';
  String get globalResponse => _globalResponse;

  String _globalUsername = '';
  String get globalUsername => _globalUsername;

  void updateUserData(String response, String username) {
    _globalResponse = response;
    _globalUsername = username;
    notifyListeners();
  }

  void setUserProfile(UserProfile userProfile) {
    _userProfile = userProfile;
    notifyListeners();
  }

  adicionarTexto(String texto) {
    _listaDeTextos.add(texto);
    notifyListeners();
  }

  void setUserData(String data) {
    _userData = data;
    notifyListeners();
  }

  void setTextValue(String value) {
    _textValue = value;
    notifyListeners();
  }
}
