import 'package:flutter/material.dart';
import 'package:teste_app/models/user_profile.dart';

class OtherUserDataProvider with ChangeNotifier {
  String _otherUserData = "";
  String get otherUserData => _otherUserData;

  UserProfile? _otherUserProfile;
  UserProfile? get otherUserProfile => _otherUserProfile;

  List<String> _otherListaDeTextos = [];

  List<String> get otherListaDeTextos => _otherListaDeTextos;

  String _otherGlobalResponse = '';
  String get otherGlobalResponse => _otherGlobalResponse;

  String _otherGlobalUsername = '';
  String get otherGlobalUsername => _otherGlobalUsername;
  String _textValue = '';

  String get textValue => _textValue;

  void updateOtherUserData(String response, String username) {
    _otherGlobalResponse = response;
    _otherGlobalUsername = username;
    notifyListeners();
  }

  void setOtherUserProfile(UserProfile userProfile) {
    _otherUserProfile = userProfile;
    notifyListeners();
  }

  adicionarOtherTexto(String texto) {
    _otherListaDeTextos.add(texto);
    notifyListeners();
  }

  void setOtherUserData(String data) {
    _otherUserData = data;
    notifyListeners();
  }
}
