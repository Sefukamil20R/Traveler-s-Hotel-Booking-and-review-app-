// domain/usecases/get_hotel_listings.dart

import 'package:hotel_booking_app/features/hotel/domain/entitiy/hotel_entitiy.dart';
import 'package:hotel_booking_app/features/hotel/domain/repository/hotel_repository.dart';

class GetHotelListings {
  final HotelRepository repository;

  GetHotelListings(this.repository);

  Future<List<Hotel>> call() async {
    return await repository.getHotels();
  }
}
