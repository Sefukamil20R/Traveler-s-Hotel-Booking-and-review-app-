// data/repository_impl/user_repository_impl.dart


import 'package:hotel_booking_and_review_app/features/user/data/datasource/user_remote_datasource.dart';
import 'package:hotel_booking_and_review_app/features/user/domain/entities/booking.dart';
import 'package:hotel_booking_and_review_app/features/user/domain/entities/favorites.dart';
import 'package:hotel_booking_and_review_app/features/user/domain/repository/user_repository.dart';

class UserRepositoryImpl implements UserRepository {
  final UserRemoteDataSource remoteDataSource;

  UserRepositoryImpl({required this.remoteDataSource});

  @override
  Future<void> bookHotel(String userId, String hotelId, DateTime checkIn, DateTime checkOut, String roomType) async {
    return await remoteDataSource.bookHotel(userId, hotelId, checkIn, checkOut, roomType);
  }

  @override
  Future<void> addToFavorites(String userId, String hotelId) async {
    return await remoteDataSource.addToFavorites(userId, hotelId);
  }

  @override
  Future<Favorites> getUserFavorites(String userId) async {
    // Convert model to entity
    final favoritesModel = await remoteDataSource.getUserFavorites(userId);
    return Favorites(userId: favoritesModel.userId, hotelIds: favoritesModel.hotelIds);
  }

  @override
  Future<Booking> getBookingSummary(String bookingId) async {
    final bookingModel = await remoteDataSource.getBookingSummary(bookingId);
    return Booking(
      bookingId: bookingModel.bookingId,
      userId: bookingModel.userId,
      hotelId: bookingModel.hotelId,
      checkInDate: bookingModel.checkInDate,
      checkOutDate: bookingModel.checkOutDate,
      roomType: bookingModel.roomType,
    );
  }

  @override
  Future<void> processPayment(String userId, String bookingId, double amount) async {
    return await remoteDataSource.processPayment(userId, bookingId, amount);
  }

  @override
  Future<List<Booking>> getUserBookings(String userId) async {
    // Fetch booking models from remote data source
    final bookingModels = await remoteDataSource.getUserBookings(userId);

    // Map booking models to the domain entity
    return bookingModels.map((bookingModel) {
      return Booking(
        bookingId: bookingModel.bookingId, // bookingModel is an instance of BookingModel
        userId: bookingModel.userId,
        hotelId: bookingModel.hotelId,
        checkInDate: bookingModel.checkInDate,
        checkOutDate: bookingModel.checkOutDate,
        roomType: bookingModel.roomType,
      );
    }).toList();
  }
}
