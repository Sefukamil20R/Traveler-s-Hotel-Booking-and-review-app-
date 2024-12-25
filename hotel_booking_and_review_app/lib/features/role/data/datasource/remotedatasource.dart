import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hotel_booking_and_review_app/features/role/domain/Entiity/role_enitity.dart';
class RoleRemoteDataSource {
  final FirebaseFirestore firestore;

  RoleRemoteDataSource({required this.firestore});

  Future<void> assignRole(RoleEntity roleEntity) async {
    await firestore.collection("users").doc(roleEntity.uid).set({
      "role": roleEntity.role,
    }, SetOptions(merge: true));
  }



  Future<String> getUserRole(String uid) async {
    final doc = await firestore.collection('users').doc(uid).get();
    return doc['role'] ?? 'user'; // Default to 'user' if role is missing
  }
}
