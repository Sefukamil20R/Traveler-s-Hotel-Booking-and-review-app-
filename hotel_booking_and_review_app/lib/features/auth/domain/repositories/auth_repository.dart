
import 'package:dartz/dartz.dart';
import 'package:hotel_booking_and_review_app/features/auth/domain/entitities/auth_entitiy.dart';

abstract class AuthRepository {
  Future<Either<String, UserEntity>> signUp({
    required String email,
    required String password,
    required String username,
  });

  Future<Either<String, UserEntity>> signIn({
    required String email,
    required String password,
  });

  Future<void> signOut();

  Future<Either<String, UserEntity>> getUserProfile();

  Future<void> verifyEmail();
}
