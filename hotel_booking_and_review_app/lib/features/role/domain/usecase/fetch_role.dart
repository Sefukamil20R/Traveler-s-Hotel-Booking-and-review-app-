
import 'package:hotel_booking_and_review_app/features/role/domain/repository/role_repository.dart';

class GetUserRoleUseCase {
  final RoleRepository repository;

  GetUserRoleUseCase(this.repository);

  Future<String> call(String uid) async {
    return await repository.getUserRole(uid);
  }
}
