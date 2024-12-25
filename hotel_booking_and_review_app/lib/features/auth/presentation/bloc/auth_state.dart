import 'package:equatable/equatable.dart';
import 'package:hotel_booking_and_review_app/features/auth/domain/entitities/auth_entitiy.dart';

abstract class AuthState extends Equatable {
  const AuthState();

  @override
  List<Object?> get props => [];
}

class AuthInitialState extends AuthState {}

class AuthLoadingState extends AuthState {}

class SignedUpState extends AuthState {
  final UserEntity user;

  const SignedUpState({required this.user});

  @override
  List<Object?> get props => [user];
}

class SignedInState extends AuthState {
  final UserEntity user;

  const SignedInState({required this.user});

  @override
  List<Object?> get props => [user];
}

class SignedOutState extends AuthState {}

class UserProfileFetchedState extends AuthState {
  final UserEntity user;

  const UserProfileFetchedState({required this.user});

  @override
  List<Object?> get props => [user];
}
class CodeResentState extends AuthState {}

class EmailVerifiedState extends AuthState {}

class AuthErrorState extends AuthState {
  final String errorMessage;

  const AuthErrorState({required this.errorMessage});

  @override
  List<Object?> get props => [errorMessage];
}
