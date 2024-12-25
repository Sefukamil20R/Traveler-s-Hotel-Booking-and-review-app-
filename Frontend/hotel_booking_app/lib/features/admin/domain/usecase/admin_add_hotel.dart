// domain/usecases/admin_add_hotel.dart

import 'package:hotel_booking_app/features/admin/domain/entities/admin_hotel.dart';
import 'package:hotel_booking_app/features/admin/domain/repository/admin_hotel_repository.dart';

class AdminAddHotel {
  final AdminHotelRepository repository;

  AdminAddHotel(this.repository);

  Future<void> call(AdminHotel hotel) async {
    return await repository.addHotel(hotel);
  }
}
