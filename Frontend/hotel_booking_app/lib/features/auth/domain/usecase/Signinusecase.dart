// lib/features/auth/domain/usecases/signin.dart

import 'package:dartz/dartz.dart';
import 'package:hotel_booking_app/features/auth/domain/entitities/auth_entitiy.dart';
import 'package:hotel_booking_app/features/auth/domain/repositories/auth_repository.dart';


class SignIn {
  final AuthRepository repository;

  SignIn(this.repository);

  Future<Either<String, UserEntity>> call({
    required String email,
    required String password,
  }) async {
    return await repository.signIn(
      email: email,
      password: password,
    );
  }
}
