// domain/repository/hotel_repository.dart

import 'package:geolocator/geolocator.dart';
import 'package:hotel_booking_and_review_app/features/hotel/domain/entitiy/hotel_entitiy.dart';

abstract class HotelRepository {
  Future<List<Hotel>> getHotels();
  Future<Hotel> getHotelDetails(String hotelId);
    Future<List<Hotel>> getNearbyHotels(Position userLocation);

}
