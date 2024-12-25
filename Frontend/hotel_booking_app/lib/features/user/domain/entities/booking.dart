import 'package:equatable/equatable.dart';

class Booking extends Equatable {
  final String bookingId;
  final String userId;
  final String hotelId;
  final DateTime checkInDate;
  final DateTime checkOutDate;
  final String roomType;

  Booking({
    required this.bookingId,
    required this.userId,
    required this.hotelId,
    required this.checkInDate,
    required this.checkOutDate,
    required this.roomType,
  });

  @override
  List<Object?> get props =>
      [bookingId, userId, hotelId, checkInDate, checkOutDate, roomType];
}
