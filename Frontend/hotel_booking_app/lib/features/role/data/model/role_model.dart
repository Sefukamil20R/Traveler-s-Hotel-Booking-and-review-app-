import 'package:hotel_booking_app/features/role/domain/Entiity/role_enitity.dart';

class RoleModel extends RoleEntity {
  RoleModel({required String uid, required String role})
      : super(uid: uid, role: role);

  // Convert model to Firestore map
  Map<String, dynamic> toMap() {
    return {
      'uid': uid,
      'role': role,
    };
  }

  // Create model from Firestore map
  factory RoleModel.fromMap(String uid, Map<String, dynamic> map) {
    return RoleModel(
      uid: uid,
      role: map['role'] ?? 'user',
    );
  }
}
