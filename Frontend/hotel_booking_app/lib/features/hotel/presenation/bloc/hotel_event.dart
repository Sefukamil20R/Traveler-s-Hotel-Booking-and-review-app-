// presentation/bloc/hotel_event.dart
import 'package:equatable/equatable.dart';

abstract class HotelEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class FetchHotelListings extends HotelEvent {}

class FetchHotelDetails extends HotelEvent {
  final String hotelId;

  FetchHotelDetails(this.hotelId);

  @override
  List<Object?> get props => [hotelId];
}
