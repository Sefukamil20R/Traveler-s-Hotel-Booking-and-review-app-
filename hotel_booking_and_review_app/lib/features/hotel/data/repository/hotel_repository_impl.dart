import 'dart:math';
import 'package:hotel_booking_and_review_app/features/hotel/data/model/hotel_model.dart';
import 'package:hotel_booking_and_review_app/features/hotel/domain/entitiy/hotel_entitiy.dart';
import 'package:sqflite/sqflite.dart';
import 'package:hotel_booking_and_review_app/features/hotel/domain/repository/hotel_repository.dart';
import 'package:geolocator/geolocator.dart';

class HotelRepositoryImpl implements HotelRepository {
  final Database database;

  HotelRepositoryImpl({required this.database});

  @override
 Future<List<Hotel>> getHotels() async {
  try {
    final List<Map<String, dynamic>> hotelMaps = await database.query('hotels');
    List<Hotel> allHotels = hotelMaps.map((hotelMap) => HotelModel.fromMap(hotelMap).toEntity()).toList();
    print("Fetched Hotels: $allHotels");  // Debug log
    return allHotels;
  } catch (e) {
    throw Exception("Error fetching hotels: ${e.toString()}");
  }
}



  

  @override
  Future<List<Hotel>> getNearbyHotels(Position userLocation) async {
    try {
      final List<Map<String, dynamic>> hotelMaps = await database.query('hotels');
      List<Hotel> allHotels = hotelMaps.map((hotelMap) => HotelModel.fromMap(hotelMap).toEntity()).toList();
      
      // Filter hotels based on proximity
      List<Hotel> nearbyHotels = allHotels.where((hotel) {
        double distance = _calculateDistance(
          userLocation.latitude,
          userLocation.longitude,
          hotel.latitude,
          hotel.longitude,
        );
        return distance <= 10.0; // Only consider hotels within 10 km
      }).toList();

      return nearbyHotels;
    } catch (e) {
      throw Exception("Error fetching nearby hotels: ${e.toString()}");
    }
  }

  // Calculate the distance between two lat/lng points in kilometers
  double _calculateDistance(double lat1, double lon1, double lat2, double lon2) {
    const radius = 6371; // Earth radius in kilometers
    double dLat = _degToRad(lat2 - lat1);
    double dLon = _degToRad(lon2 - lon1);

    double a = sin(dLat / 2) * sin(dLat / 2) +
        cos(_degToRad(lat1)) * cos(_degToRad(lat2)) *
            sin(dLon / 2) * sin(dLon / 2);
    double c = 2 * atan2(sqrt(a), sqrt(1 - a));

    return radius * c; // Distance in kilometers
  }

  double _degToRad(double deg) {
    return deg * (pi / 180);
  }
  @override
  Future<Hotel> getHotelDetails(String hotelId) async {
    try {
      // Query SQLite database for a specific hotel by ID
      final List<Map<String, dynamic>> hotelMaps =
          await database.query('hotels', where: 'id = ?', whereArgs: [hotelId]);

      if (hotelMaps.isEmpty) {
        throw Exception('Hotel with ID "$hotelId" not found.');
      }

      // Convert the result into a Hotel entity
      return HotelModel.fromMap(hotelMaps.first).toEntity();
    } catch (e) {
      throw Exception("Error fetching hotel details: ${e.toString()}");
    }
  }
}
