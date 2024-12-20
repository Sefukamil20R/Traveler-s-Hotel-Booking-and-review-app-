// lib/features/auth/domain/usecases/get_user_profile.dart

import 'package:dartz/dartz.dart';
import 'package:hotel_booking_app/features/auth/domain/entitities/auth_entitiy.dart';
import 'package:hotel_booking_app/features/auth/domain/repositories/auth_repository.dart';


class GetUserProfile {
  final AuthRepository repository;

  GetUserProfile(this.repository);

  Future<Either<String, UserEntity>> call() async {
    return await repository.getUserProfile();
  }
}
