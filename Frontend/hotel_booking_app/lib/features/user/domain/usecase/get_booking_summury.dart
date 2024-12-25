import '../entities/booking.dart';
import '../repository/user_repository.dart';

class GetBookingSummary {
  final UserRepository repository;

  GetBookingSummary(this.repository);

  Future<Booking> call(String bookingId) {
    return repository.getBookingSummary(bookingId);
  }
}
