// domain/usecases/get_hotel_details.dart


import 'package:hotel_booking_and_review_app/features/hotel/domain/entitiy/hotel_entitiy.dart';
import 'package:hotel_booking_and_review_app/features/hotel/domain/repository/hotel_repository.dart';

class GetHotelDetails {
  final HotelRepository repository;

  GetHotelDetails(this.repository);

  Future<Hotel> call(String hotelId) async {
    return await repository.getHotelDetails(hotelId);
  }
}
