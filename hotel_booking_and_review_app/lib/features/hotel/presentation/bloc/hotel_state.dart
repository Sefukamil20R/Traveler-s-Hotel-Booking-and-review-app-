// presentation/bloc/hotel_state.dart
import 'package:equatable/equatable.dart';
import 'package:hotel_booking_and_review_app/features/hotel/domain/entitiy/hotel_entitiy.dart';

abstract class HotelState extends Equatable {
  @override
  List<Object?> get props => [];
}

class HotelInitial extends HotelState {}

class HotelLoading extends HotelState {}

class HotelLoaded extends HotelState {
  final List<Hotel> hotels;

  HotelLoaded(this.hotels);

  @override
  List<Object?> get props => [hotels];
}

class HotelDetailLoaded extends HotelState {
  final Hotel hotel;

  HotelDetailLoaded(this.hotel);

  @override
  List<Object?> get props => [hotel];
}

class HotelError extends HotelState {
  final String message;

  HotelError(this.message);

  @override
  List<Object?> get props => [message];
}
