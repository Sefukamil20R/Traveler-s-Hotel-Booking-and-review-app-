// lib/features/auth/domain/usecases/get_user_profile.dart

import 'package:dartz/dartz.dart';
import 'package:hotel_booking_and_review_app/features/auth/domain/repositories/auth_repository.dart';
import 'package:hotel_booking_and_review_app/features/auth/domain/entitities/auth_entitiy.dart';

class GetUserProfile {
  final AuthRepository repository;

  GetUserProfile(this.repository);

  Future<Either<String, UserEntity>> call() async {
    return await repository.getUserProfile();
  }
}
