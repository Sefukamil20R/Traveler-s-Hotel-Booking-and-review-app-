// lib/features/auth/domain/usecases/verifyemail.dart


import 'package:hotel_booking_and_review_app/features/auth/domain/repositories/auth_repository.dart';

class VerifyEmail {
  final AuthRepository repository;

  VerifyEmail(this.repository);

  Future<void> call() async {
    return await repository.verifyEmail();
  }
}
