import 'dart:convert';

import 'package:teste_app/pages/login_page.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class UserProfile {
  final Connections connections;
  final UserInfo info;

  UserProfile({required this.connections, required this.info});

  factory UserProfile.fromJson(Map<String, dynamic> json) {
    return UserProfile(
      connections: Connections.fromJson(json['connections']),
      info: UserInfo.fromJson(json['info']),
    );
  }
}

class Connections {
  final List<String>? followers;
  final List<String>? follows;

  Connections({required this.followers, required this.follows});

  factory Connections.fromJson(Map<String, dynamic> json) {
    final followers =
        json['followers'] != null ? List<String>.from(json['followers']) : null;
    final follows =
        json['follows'] != null ? List<String>.from(json['follows']) : null;

    if (followers == null && follows == null) {
      return Connections(followers: null, follows: null);
    }

    return Connections(
      followers: followers,
      follows: follows,
    );
  }
}

class UserInfo {
  final String? bio;
  final List<MuralItem>? mural;
  final String? name;
  final String? profilePicture;
  final String? username;

  UserInfo({
    required this.bio,
    required this.mural,
    required this.name,
    required this.profilePicture,
    required this.username,
  });

  factory UserInfo.fromJson(Map<String, dynamic> json) {
    final bio = json['bio'] != null ? json['bio'] : null;
    final mural = json['mural'] != null
        ? List<MuralItem>.from(
            json['mural'].map((item) => MuralItem.fromJson(item)))
        : null;
    final name = json['name'] != null ? json['name'] : null;
    final profilePicture =
        json['profilePicture'] != null ? json['profilePicture'] : null;
    final username = json['username'] != null ? json['username'] : null;

    if (bio == null &&
        mural == null &&
        name == null &&
        profilePicture == null &&
        username == null) {
      return UserInfo(
        bio: bio,
        mural: mural,
        name: name,
        profilePicture: profilePicture,
        username: username,
      );
    }

    return UserInfo(
      bio: bio,
      mural: mural,
      name: name,
      profilePicture: profilePicture,
      username: username,
    );
  }

  List<MuralItem>? get muralList => null;
}

class MuralItem {
  final String text;
  final String username;

  MuralItem({required this.text, required this.username});

  factory MuralItem.fromJson(Map<String, dynamic> json) {
    return MuralItem(
      text: json['text'],
      username: json['username'],
    );
  }
}
