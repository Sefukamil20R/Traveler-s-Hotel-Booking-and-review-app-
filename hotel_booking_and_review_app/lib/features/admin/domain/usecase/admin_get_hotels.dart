// domain/usecases/admin_get_hotels.dart

import 'package:hotel_booking_and_review_app/features/admin/domain/entities/admin_hotel.dart';
import 'package:hotel_booking_and_review_app/features/admin/domain/repository/admin_hotel_repository.dart';

class AdminGetHotels {
  final AdminHotelRepository repository;

  AdminGetHotels(this.repository);

  Future<List<AdminHotel>> call() async {
    return await repository.getHotels();
  }
}
