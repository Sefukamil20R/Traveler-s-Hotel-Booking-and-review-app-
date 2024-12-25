import 'package:hotel_booking_and_review_app/features/user/domain/repository/user_repository.dart';

class BookHotel {
  final UserRepository repository;

  BookHotel(this.repository);

  Future<void> call(String userId, String hotelId, DateTime checkIn, DateTime checkOut, String roomType) {
    return repository.bookHotel(userId, hotelId, checkIn, checkOut, roomType);
  }
}
