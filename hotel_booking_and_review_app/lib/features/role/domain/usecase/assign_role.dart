
import 'package:hotel_booking_and_review_app/features/role/domain/Entiity/role_enitity.dart';
import 'package:hotel_booking_and_review_app/features/role/domain/repository/role_repository.dart';

class AssignRoleUseCase {
  final RoleRepository repository;

  AssignRoleUseCase(this.repository);

  Future<void> call(RoleEntity roleEntity) async {
    await repository.assignRole(roleEntity);
  }
}
