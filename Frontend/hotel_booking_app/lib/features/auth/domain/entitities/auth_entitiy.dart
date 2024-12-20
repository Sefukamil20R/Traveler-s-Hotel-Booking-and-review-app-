import 'package:equatable/equatable.dart';

class UserEntity extends Equatable {
  final String uid;
  final String email;
  final bool emailVerified;
  final String username;  
  final String password;

  UserEntity({
    required this.uid,
    required this.email,
    required this.emailVerified,
    required this.username,  
    required this.password
  });
  
  @override
  List<Object> get props => [uid, email, emailVerified, username, password];
}
