// lib/features/auth/domain/usecases/signout.dart

import 'package:hotel_booking_app/features/auth/domain/repositories/auth_repository.dart';

class SignOut {
  final AuthRepository repository;

  SignOut(this.repository);

  Future<void> call() async {
    return await repository.signOut();
  }
}
