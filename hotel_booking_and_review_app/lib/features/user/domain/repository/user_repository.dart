
import 'package:hotel_booking_and_review_app/features/user/domain/entities/booking.dart';
import 'package:hotel_booking_and_review_app/features/user/domain/entities/favorites.dart';

abstract class UserRepository {
  Future<List<Booking>> getUserBookings(String userId);
  Future<void> bookHotel(String userId, String hotelId, DateTime checkIn, DateTime checkOut, String roomType);
  Future<void> addToFavorites(String userId, String hotelId);
  Future<Favorites> getUserFavorites(String userId);
  Future<void> processPayment(String userId, String bookingId, double amount);
  Future<Booking> getBookingSummary(String bookingId);
}
