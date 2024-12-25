// data/repository_impl/admin_hotel_repository_impl.dart


import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hotel_booking_and_review_app/features/admin/data/datasource/admin_hotel_remote_datasource.dart';
import 'package:hotel_booking_and_review_app/features/admin/data/model/admin_hotel_model.dart';
import 'package:hotel_booking_and_review_app/features/admin/domain/entities/admin_hotel.dart';
import 'package:hotel_booking_and_review_app/features/admin/domain/repository/admin_hotel_repository.dart';

class AdminHotelRepositoryImpl implements AdminHotelRepository {
  final AdminHotelRemoteDataSource remoteDataSource;
    final FirebaseFirestore firestore;


  AdminHotelRepositoryImpl({required this.remoteDataSource,required this.firestore});

  @override
  Future<void> addHotel(AdminHotel hotel) async {
    return await remoteDataSource.addHotel(hotel as AdminHotelModel);
  }

  @override
  Future<void> editHotel(AdminHotel hotel) async {
    return await remoteDataSource.editHotel(hotel as AdminHotelModel);
  }

  @override
  Future<void> deleteHotel(String hotelId) async {
    return await remoteDataSource.deleteHotel(hotelId);
  }
  @override
  Future<void> assignRole(String userId, String role) async {
    try {
      // Reference to the user document
      final userRef = firestore.collection('users').doc(userId);

      // Update the role field
      await userRef.update({'role': role});
    } catch (e) {
      throw Exception('Error assigning role: $e');
    }
}
}