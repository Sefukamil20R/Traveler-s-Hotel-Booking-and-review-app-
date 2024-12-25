// data/remotedatasource/hotel_remote_datasource.dart
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hotel_booking_app/features/hotel/data/model/hotel_model.dart';

abstract class HotelRemoteDataSource {
  Future<List<HotelModel>> fetchHotels();
  Future<HotelModel> fetchHotelDetails(String hotelId);
}

class HotelRemoteDataSourceImpl implements HotelRemoteDataSource {
  final FirebaseFirestore firestore;

  HotelRemoteDataSourceImpl({required this.firestore});

  @override
  Future<List<HotelModel>> fetchHotels() async {
    final querySnapshot = await firestore.collection('hotels').get();
    return querySnapshot.docs
        .map((doc) => HotelModel.fromMap(doc.data()))
        .toList();
  }

  @override
  Future<HotelModel> fetchHotelDetails(String hotelId) async {
    final doc = await firestore.collection('hotels').doc(hotelId).get();
    return HotelModel.fromMap(doc.data()!);
  }
}
