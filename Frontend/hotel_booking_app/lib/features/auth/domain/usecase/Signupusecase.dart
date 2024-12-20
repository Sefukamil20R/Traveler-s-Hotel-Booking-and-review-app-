// lib/features/auth/domain/usecases/signup.dart

import 'package:dartz/dartz.dart';
import 'package:hotel_booking_app/features/auth/domain/entitities/auth_entitiy.dart';

import 'package:hotel_booking_app/features/auth/domain/repositories/auth_repository.dart';

class SignupUseCase {
  final AuthRepository repository;

  SignupUseCase(this.repository);

  Future<Either<String, UserEntity>> call(UserEntity user) async {
    try {
      return await repository.signUp(
        email: user.email,
        password: user.password,
        username: user.username,
      );
    } catch (e) {
      return Left(e.toString());
    }
  }
}
