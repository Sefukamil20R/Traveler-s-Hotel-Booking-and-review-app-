// data/models/booking_model.dart
import 'package:hotel_booking_and_review_app/features/user/domain/entities/booking.dart';

class BookingModel extends Booking {
  BookingModel({
    required String bookingId,
    required String userId,
    required String hotelId,
    required DateTime checkInDate,
    required DateTime checkOutDate,
    required String roomType,
  }) : super(
          bookingId: bookingId,
          userId: userId,
          hotelId: hotelId,
          checkInDate: checkInDate,
          checkOutDate: checkOutDate,
          roomType: roomType,
        );

  factory BookingModel.fromMap(Map<String, dynamic> map) {
    return BookingModel(
      bookingId: map['bookingId'],
      userId: map['userId'],
      hotelId: map['hotelId'],
      checkInDate: DateTime.parse(map['checkIn']),
      checkOutDate: DateTime.parse(map['checkOut']),
      roomType: map['roomType'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'bookingId': bookingId,
      'userId': userId,
      'hotelId': hotelId,
      'checkIn': checkInDate.toIso8601String(),
      'checkOut': checkOutDate.toIso8601String(),
      'roomType': roomType,
    };
  }
}
