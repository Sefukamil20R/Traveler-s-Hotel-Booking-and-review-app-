
import 'package:equatable/equatable.dart';
import 'package:geolocator/geolocator.dart';

abstract class HotelEvent extends Equatable {
  const HotelEvent();
  
  @override
  List<Object> get props => [];
}

class FetchHotelsEvent extends HotelEvent {
  // If needed, you can add parameters like filters, location, etc.
  @override
  List<Object> get props => [];
}

class FetchNearbyHotelsEvent extends HotelEvent {
  final Position currentPosition;

  // Remove the 'locations' parameter and just use 'currentPosition'
  const FetchNearbyHotelsEvent(this.currentPosition);

  @override
  List<Object> get props => [currentPosition];
}

class FetchHotelDetails extends HotelEvent {
  final String hotelId;

  FetchHotelDetails(this.hotelId);

  @override
  List<Object> get props => [hotelId];
}
