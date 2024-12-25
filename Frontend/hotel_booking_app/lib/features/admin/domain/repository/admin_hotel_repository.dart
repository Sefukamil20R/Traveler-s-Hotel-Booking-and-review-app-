// domain/repository/admin_hotel_repository.dart
import '../entities/admin_hotel.dart';

abstract class AdminHotelRepository {
  Future<void> addHotel(AdminHotel hotel);
  Future<void> editHotel(AdminHotel hotel);
  Future<void> deleteHotel(String hotelId);
  Future<void> assignRole(String userId, String role);
  
}
