import 'package:teste_app/models/user_profile.dart';

class OtherUserProfile {
  final Connections connections;
  final OtherUserInfo info;

  OtherUserProfile({required this.connections, required this.info});

  factory OtherUserProfile.fromJson(Map<String, dynamic> json) {
    return OtherUserProfile(
      connections: Connections.fromJson(json['connections']),
      info: OtherUserInfo.fromJson(json['info']),
    );
  }
}

class OtherUserInfo {
  final String? bio;
  final List<OtherMuralItem>? mural;
  final String? name;
  final String? profilePicture;
  final String? username;

  OtherUserInfo({
    required this.bio,
    required this.mural,
    required this.name,
    required this.profilePicture,
    required this.username,
  });

  factory OtherUserInfo.fromJson(Map<String, dynamic> json) {
    final bio = json['bio'] != null ? json['bio'] : null;
    final mural = json['mural'] != null
        ? List<OtherMuralItem>.from(
            json['mural'].map((item) => OtherMuralItem.fromJson(item)))
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
      return OtherUserInfo(
        bio: bio,
        mural: mural,
        name: name,
        profilePicture: profilePicture,
        username: username,
      );
    }

    return OtherUserInfo(
      bio: bio,
      mural: mural,
      name: name,
      profilePicture: profilePicture,
      username: username,
    );
  }

  List<OtherMuralItem>? get muralList => null;
}

class OtherMuralItem {
  final String text;
  final String username;

  OtherMuralItem({required this.text, required this.username});

  factory OtherMuralItem.fromJson(Map<String, dynamic> json) {
    return OtherMuralItem(
      text: json['text'],
      username: json['username'],
    );
  }
}
