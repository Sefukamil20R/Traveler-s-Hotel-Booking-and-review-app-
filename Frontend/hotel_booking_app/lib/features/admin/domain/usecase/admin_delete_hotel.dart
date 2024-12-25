// domain/usecases/admin_delete_hotel.dart

import 'package:hotel_booking_app/features/admin/domain/repository/admin_hotel_repository.dart';

class AdminDeleteHotel {
  final AdminHotelRepository repository;

  AdminDeleteHotel(this.repository);

  Future<void> call(String hotelId) async {
    return await repository.deleteHotel(hotelId);
  }
}
