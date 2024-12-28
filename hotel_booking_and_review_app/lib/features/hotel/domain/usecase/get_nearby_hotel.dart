import 'package:hotel_booking_and_review_app/features/hotel/domain/entitiy/hotel_entitiy.dart';
import 'package:geolocator/geolocator.dart';
import 'package:hotel_booking_and_review_app/features/hotel/domain/repository/hotel_repository.dart';

class GetNearbyHotels {
  final HotelRepository repository;

  GetNearbyHotels(this.repository);

  Future<List<Hotel>> call(Position userLocation) async {
    return await repository.getNearbyHotels(userLocation);
  }
}
