import '../../domain/entitities/auth_entitiy.dart';

class AuthModel extends UserEntity {
  AuthModel({
    required String uid,
    required String email,
    required bool emailVerified,
    required String username,
  }) : super(
          uid: uid,
          email: email,
          emailVerified: emailVerified,
          username: username,
          password: '', 
        );

  factory AuthModel.fromJson(Map<String, dynamic> json, String uid) {
    return AuthModel(
      uid: uid,
      email: json['email'],
      emailVerified: json['emailVerified'],
      username: json['username'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'email': email,
      'emailVerified': emailVerified,
      'username': username,
    };
  }
}
