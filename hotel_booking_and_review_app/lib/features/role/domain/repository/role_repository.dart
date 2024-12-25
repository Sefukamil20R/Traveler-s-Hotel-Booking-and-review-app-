
import 'package:hotel_booking_and_review_app/features/role/domain/Entiity/role_enitity.dart';

abstract class RoleRepository {
  Future<void> assignRole(RoleEntity roleEntity);
  Future<String> getUserRole(String uid);
}
