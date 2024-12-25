// domain/usecases/admin_edit_hotel.dart

import 'package:hotel_booking_app/features/admin/domain/entities/admin_hotel.dart';
import 'package:hotel_booking_app/features/admin/domain/repository/admin_hotel_repository.dart';

class AdminEditHotel {
  final AdminHotelRepository repository;

  AdminEditHotel(this.repository);

  Future<void> call(AdminHotel hotel) async {
    return await repository.editHotel(hotel);
  }
}
