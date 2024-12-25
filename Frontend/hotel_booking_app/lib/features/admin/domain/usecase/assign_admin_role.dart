// domain/usecases/assign_role.dart


import 'package:hotel_booking_app/features/admin/domain/repository/admin_hotel_repository.dart';

class AssignRole {
  final AdminHotelRepository repository;

  AssignRole(this.repository);

  Future<void> call(String userId, String role) {
    return repository.assignRole(userId, role);
  }
}
