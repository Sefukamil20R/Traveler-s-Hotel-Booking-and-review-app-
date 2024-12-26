import 'package:sqflite/sqflite.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hotel_booking_and_review_app/features/admin/data/model/admin_hotel_model.dart';
import 'package:hotel_booking_and_review_app/features/admin/domain/entities/admin_hotel.dart';
import 'package:hotel_booking_and_review_app/features/admin/domain/repository/admin_hotel_repository.dart';

class AdminHotelRepositoryImpl implements AdminHotelRepository {
  final Database database;
  final FirebaseFirestore firestore;

  AdminHotelRepositoryImpl({required this.database, FirebaseFirestore? firestore})
      : firestore = firestore ?? FirebaseFirestore.instance {
    print('AdminHotelRepositoryImpl initialized with database: $database');
  }


 @override
  Future<void> addHotel(AdminHotel hotel) async {
    try {
      final hotelModel = AdminHotelModel.fromEntity(hotel);
      await database.insert(
        'hotels',
        hotelModel.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace,
      );
    } catch (e) {
      throw Exception("Error adding hotel: ${e.toString()}");
    }
  }

  @override
  Future<void> deleteHotel(String hotelId) async {
    try {
      await database.delete('hotels', where: 'id = ?', whereArgs: [hotelId]);
    } catch (e) {
      throw Exception("Error deleting hotel: ${e.toString()}");
    }
  }

  @override
  Future<List<AdminHotel>> getHotels() async {
    try {
      final List<Map<String, dynamic>> hotelMaps = await database.query('hotels');
      return hotelMaps.map((hotelMap) => AdminHotelModel.fromMap(hotelMap).toEntity()).toList();
    } catch (e) {
      throw Exception("Error fetching hotels: ${e.toString()}");
    }
  }
  @override
  Future<void> editHotel(AdminHotel hotel) async {
    final hotelModel = AdminHotelModel.fromEntity(hotel);
    await database.update(
      'hotels',
      hotelModel.toMap(),
      where: 'id = ?',
      whereArgs: [hotel.id],
    );
  }


 
  @override
Future<void> assignRole(String username, String role) async {
  try {
    final userQuery = await firestore
        .collection('users')
        .where('username', isEqualTo: username)
        .get();

    if (userQuery.docs.isEmpty) {
      throw Exception('User with username "$username" does not exist.');
    }

    final userDoc = userQuery.docs.first.reference;
    await userDoc.update({'role': role});
  } catch (e) {
    throw Exception('Error assigning role: $e');
  }
}


}
