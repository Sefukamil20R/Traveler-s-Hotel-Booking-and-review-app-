// data/remotedatasource/user_remote_datasource.dart
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:hotel_booking_app/features/user/data/Model/booking_model.dart';
import 'package:hotel_booking_app/features/user/data/Model/favorites_model.dart';

 abstract class UserRemoteDataSource {
  Future <void>bookHotel(String userId, String hotelId, DateTime checkIn, DateTime checkOut, String roomType);
  Future <void>addToFavorites(String userId, String hotelId);
  Future <FavoritesModel>getUserFavorites(String userId);
  Future <void>processPayment(String userId, String bookingId, double amount);
  Future <BookingModel>getBookingSummary(String bookingId);
  Future <List<BookingModel>>getUserBookings(String userId);
  
 }
 class UserRemoteDataSourceImpl implements UserRemoteDataSource {
  final FirebaseFirestore firestore;
  final FirebaseAuth auth;
  UserRemoteDataSourceImpl({required this.firestore,required this.auth});

  // Book a hotel
  Future<void> bookHotel(String userId, String hotelId, DateTime checkIn, DateTime checkOut, String roomType) async {
    await firestore.collection('bookings').add({
      'userId': userId,
      'hotelId': hotelId,
      'checkIn': checkIn.toIso8601String(),
      'checkOut': checkOut.toIso8601String(),
      'roomType': roomType,
    });
  }

  // Add hotel to user's favorites
  Future<void> addToFavorites(String userId, String hotelId) async {
    await firestore.collection('favorites').doc(userId).set({
      'hotels': FieldValue.arrayUnion([hotelId]),
    });
  }

  // Get user favorites
  Future<FavoritesModel> getUserFavorites(String userId) async {
    final snapshot = await firestore.collection('favorites').doc(userId).get();
    final data = snapshot.data();
    if (data == null || data['hotels'] == null) {
      return FavoritesModel(userId: userId, hotelIds: []);
    }
    return FavoritesModel.fromMap(userId, data);
  }

  // Process payment
  Future<void> processPayment(String userId, String bookingId, double amount) async {
    await firestore.collection('payments').add({
      'userId': userId,
      'bookingId': bookingId,
      'amount': amount,
      'timestamp': FieldValue.serverTimestamp(),
    });
  }

  // Get booking summary
  Future<BookingModel> getBookingSummary(String bookingId) async {
    final snapshot = await firestore.collection('bookings').doc(bookingId).get();
    final data = snapshot.data();
    if (data == null) {
      throw Exception("Booking not found");
    }
    return BookingModel.fromMap(data);
  }

  // Get user bookings
  Future<List<BookingModel>> getUserBookings(String userId) async {
    final snapshot = await firestore
        .collection('bookings')
        .where('userId', isEqualTo: userId)
        .get();

    if (snapshot.docs.isEmpty) {
      return [];
    }

    return snapshot.docs.map((doc) {
      return BookingModel.fromMap(doc.data());
    }).toList();
  }
  
 
  }
  
 

