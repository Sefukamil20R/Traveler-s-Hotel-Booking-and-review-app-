import 'package:hotel_booking_app/features/user/domain/entities/booking.dart';
import 'package:hotel_booking_app/features/user/domain/repository/user_repository.dart';

class GetUserBookings {
  final UserRepository repository;

  GetUserBookings(this.repository);

  Future<List<Booking>> call(String userId) {
    return repository.getUserBookings(userId);
  }
}
