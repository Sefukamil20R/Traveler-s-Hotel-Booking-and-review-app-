import '../repository/user_repository.dart';

class ProcessPayment {
  final UserRepository repository;

  ProcessPayment(this.repository);

  Future<void> call(String userId, String bookingId, double amount) {
    return repository.processPayment(userId, bookingId, amount);
  }
}
