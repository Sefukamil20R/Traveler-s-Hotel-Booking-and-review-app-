// data/remotedatasource/admin_hotel_remote_datasource.dart
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hotel_booking_and_review_app/features/admin/data/model/admin_hotel_model.dart';

abstract class AdminHotelRemoteDataSource {
  Future<void> addHotel(AdminHotelModel hotel);
  Future<void> editHotel(AdminHotelModel hotel);
  Future<void> deleteHotel(String hotelId);
}

class AdminHotelRemoteDataSourceImpl implements AdminHotelRemoteDataSource {
  final FirebaseFirestore firestore;
  

  AdminHotelRemoteDataSourceImpl({required this.firestore});

  @override
  Future<void> addHotel(AdminHotelModel hotel) async {
    await firestore.collection('hotels').add(hotel.toMap());
  }
  
  @override
  Future<void> editHotel(AdminHotelModel hotel) async {
    await firestore.collection('hotels').doc(hotel.id).update(hotel.toMap());
  }

  @override
  Future<void> deleteHotel(String hotelId) async {
    await firestore.collection('hotels').doc(hotelId).delete();
  }
}
