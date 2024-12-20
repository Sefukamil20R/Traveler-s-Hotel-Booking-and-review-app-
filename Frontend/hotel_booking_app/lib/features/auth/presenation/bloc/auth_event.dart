import 'package:equatable/equatable.dart';
import 'package:hotel_booking_app/features/auth/domain/entitities/auth_entitiy.dart';


abstract class AuthEvent extends Equatable {
  const AuthEvent();

  @override
  List<Object?> get props => [];
}

class SignUpEvent extends AuthEvent {
  final UserEntity user;

  const SignUpEvent({required this.user});

  @override
  List<Object?> get props => [user];
}

class SignInEvent extends AuthEvent {
  final String email;
  final String password;

  const SignInEvent({required this.email, required this.password});

  @override
  List<Object?> get props => [email, password];
}

class SignOutEvent extends AuthEvent {}

class FetchUserProfileEvent extends AuthEvent {}

class VerifyEmailEvent extends AuthEvent {}
