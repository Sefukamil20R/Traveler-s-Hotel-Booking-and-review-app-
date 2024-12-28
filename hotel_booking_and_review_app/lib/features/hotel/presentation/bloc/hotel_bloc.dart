import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hotel_booking_and_review_app/features/hotel/domain/entitiy/hotel_entitiy.dart';
import 'package:hotel_booking_and_review_app/features/hotel/domain/usecase/get_hotel_details.dart';
import 'package:hotel_booking_and_review_app/features/hotel/domain/usecase/get_hotel_listings.dart';
import 'package:hotel_booking_and_review_app/features/hotel/domain/usecase/get_nearby_hotel.dart';

import 'package:hotel_booking_and_review_app/features/hotel/presentation/bloc/hotel_event.dart';
import 'package:hotel_booking_and_review_app/features/hotel/presentation/bloc/hotel_state.dart';
import 'package:geolocator/geolocator.dart';

class HotelBloc extends Bloc<HotelEvent, HotelState> {
  final GetHotelListings getHotels;
  final GetHotelDetails getHotelDetails; // For hotel details page
  final GetNearbyHotels getNearbyHotels; // New use case for nearby hotels
  
  HotelBloc({
    required this.getHotels,
    required this.getHotelDetails,
    required this.getNearbyHotels,
  }) : super(HotelInitial()) {
    on<FetchHotelsEvent>(_onFetchHotels);
    on<FetchNearbyHotelsEvent>(_onFetchNearbyHotels);
  on<FetchHotelDetails>(_onFetchHotelDetails); }

 Future<void> _onFetchHotels(FetchHotelsEvent event, Emitter<HotelState> emit) async {
  try {
    emit(HotelLoading());
    final hotels = await getHotels.call();  // This should fetch recommended hotels
    if (hotels.isNotEmpty) {
      emit(HotelLoaded(hotels));  // Emit the loaded state with hotels
    } else {
      emit(HotelError("No recommended hotels found"));
    }
  } catch (e) {
    emit(HotelError("Failed to load hotels: ${e.toString()}"));
  }
}
_onFetchNearbyHotels(FetchNearbyHotelsEvent event, Emitter<HotelState> emit) async {
  try {
    emit(HotelLoading());

    // Get current position from the event
    Position userLocation = event.currentPosition;

    final nearbyHotels = await getNearbyHotels.call(userLocation);
    if (nearbyHotels.isNotEmpty) {
      emit(HotelLoaded(nearbyHotels));  // Emit nearby hotels
    } else {
      emit(HotelError("No nearby hotels found"));
    }
  } catch (e) {
    emit(HotelError("Failed to load nearby hotels: ${e.toString()}"));
  }
}Future<void> _onFetchHotelDetails(FetchHotelDetails event, Emitter<HotelState> emit) async {
    try {
      emit(HotelLoading());
      final hotel = await getHotelDetails.call(event.hotelId);
      emit(HotelDetailLoaded(hotel));  // Emit the loaded state with hotel details
    } catch (e) {
      emit(HotelError("Failed to load hotel details: ${e.toString()}"));
    }
  }
}
