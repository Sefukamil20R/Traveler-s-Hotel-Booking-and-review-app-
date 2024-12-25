// presentation/bloc/hotel_bloc.dart
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hotel_booking_and_review_app/features/hotel/domain/usecase/get_hotel_details.dart';
import 'package:hotel_booking_and_review_app/features/hotel/domain/usecase/get_hotel_listings.dart';

import 'hotel_event.dart';
import 'hotel_state.dart';

class HotelBloc extends Bloc<HotelEvent, HotelState> {
  final GetHotelListings getHotelListings;
  final GetHotelDetails getHotelDetails;

  HotelBloc({
    required this.getHotelListings,
    required this.getHotelDetails,
  }) : super(HotelInitial()) {
    on<FetchHotelListings>((event, emit) async {
      emit(HotelLoading());
      try {
        final hotels = await getHotelListings();
        emit(HotelLoaded(hotels));
      } catch (e) {
        emit(HotelError(e.toString()));
      }
    });

    on<FetchHotelDetails>((event, emit) async {
      emit(HotelLoading());
      try {
        final hotel = await getHotelDetails(event.hotelId);
        emit(HotelDetailLoaded(hotel));
      } catch (e) {
        emit(HotelError(e.toString()));
      }
    });
  }
}
