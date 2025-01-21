import 'package:equatable/equatable.dart';

// Base class for all events
abstract class UserEvent extends Equatable {
  const UserEvent();

  @override
  List<Object> get props => [];
}

// Event to book a hotel
class BookHotelEvent extends UserEvent {
  final String userId;
  final String hotelId;
  final DateTime checkIn;
  final DateTime checkOut;
  final String roomType;

  const BookHotelEvent({
    required this.userId,
    required this.hotelId,
    required this.checkIn,
    required this.checkOut,
    required this.roomType,
  });

  @override
  List<Object> get props => [userId, hotelId, checkIn, checkOut, roomType];
}

// Event to add a hotel to favorites
class AddToFavoritesEvent extends UserEvent {
  final String userId;
  final String hotelId;

  const AddToFavoritesEvent({required this.userId,  required this.hotelId});

  @override
  List<Object> get props => [ hotelId];
}

// Event to process payment
class ProcessPaymentEvent extends UserEvent {
  final String userId;
  final String bookingId;
  final double amount;

  const ProcessPaymentEvent({
    required this.userId,
    required this.bookingId,
    required this.amount,
  });

  @override
  List<Object> get props => [userId, bookingId, amount];
}

// Event to get booking summary
class GetBookingSummaryEvent extends UserEvent {
  final String bookingId;

  const GetBookingSummaryEvent({required this.bookingId});

  @override
  List<Object> get props => [bookingId];
}

// Event to get user bookings
class GetUserBookingsEvent extends UserEvent {
  final String userId;

  const GetUserBookingsEvent({required this.userId});

  @override
  List<Object> get props => [userId];
}
