import 'package:equatable/equatable.dart';
import 'package:hotel_booking_app/features/user/domain/entities/booking.dart';

// Base class for all states
abstract class UserState extends Equatable {
  const UserState();

  @override
  List<Object> get props => [];
}

// Initial state
class UserInitial extends UserState {}

// Loading state
class UserLoading extends UserState {}

// Success state with a message
class UserSuccess extends UserState {
  final String message;

  const UserSuccess({required this.message});

  @override
  List<Object> get props => [message];
}

// Failure state with an error message
class UserFailure extends UserState {
  final String message;

  const UserFailure({required this.message});

  @override
  List<Object> get props => [message];
}

// State when booking summary is loaded
class BookingSummaryLoaded extends UserState {
  final Booking bookingSummary;

  const BookingSummaryLoaded({required this.bookingSummary});

  @override
  List<Object> get props => [bookingSummary];
}

// State when user bookings are loaded
class UserBookingsLoaded extends UserState {
  final List<Booking> bookings;

  const UserBookingsLoaded({required this.bookings});

  @override
  List<Object> get props => [bookings];
}
