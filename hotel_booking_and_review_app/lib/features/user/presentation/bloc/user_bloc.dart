import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hotel_booking_and_review_app/features/user/domain/entities/processpayment.dart';
import 'package:hotel_booking_and_review_app/features/user/domain/usecase/add_to_favorites.dart';
import 'package:hotel_booking_and_review_app/features/user/domain/usecase/book_hotel.dart';
import 'package:hotel_booking_and_review_app/features/user/domain/usecase/get_booking_summury.dart';
import 'package:hotel_booking_and_review_app/features/user/domain/usecase/get_user_bookings.dart';

import 'user_event.dart';
import 'user_state.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  final BookHotel bookHotelUseCase;
  final AddToFavorites addToFavoritesUseCase;
  final ProcessPayment processPaymentUseCase;
  final GetBookingSummary getBookingSummaryUseCase;
  final GetUserBookings getUserBookingsUseCase;

  UserBloc({
    required this.bookHotelUseCase,
    required this.addToFavoritesUseCase,
    required this.processPaymentUseCase,
    required this.getBookingSummaryUseCase,
    required this.getUserBookingsUseCase,
  }) : super(UserInitial()) {
    on<BookHotelEvent>(_onBookHotelEvent);
    on<AddToFavoritesEvent>(_onAddToFavoritesEvent);
    on<ProcessPaymentEvent>(_onProcessPaymentEvent);
    on<GetBookingSummaryEvent>(_onGetBookingSummaryEvent);
    on<GetUserBookingsEvent>(_onGetUserBookingsEvent);
  }

  Future<void> _onBookHotelEvent(BookHotelEvent event, Emitter<UserState> emit) async {
    emit(UserLoading());
    try {
      await bookHotelUseCase.call(
        event.userId, // userId from event
        event.hotelId, // hotelId from event
        event.checkIn, // checkIn from event
        event.checkOut, // checkOut from event
        event.roomType, // roomType from event
      );
      emit(UserSuccess(message: "Hotel booked successfully!"));
    } catch (e) {
      emit(UserFailure(message: e.toString()));
    }
  }

  Future<void> _onAddToFavoritesEvent(AddToFavoritesEvent event, Emitter<UserState> emit) async {
    emit(UserLoading());
    try {
      await addToFavoritesUseCase.call(event.userId,event.hotelId);
      emit(UserSuccess(message: "Hotel added to favorites!"));
    } catch (e) {
      emit(UserFailure(message: e.toString()));
    }
  }

  Future<void> _onProcessPaymentEvent(ProcessPaymentEvent event, Emitter<UserState> emit) async {
    emit(UserLoading());
    try {
      await processPaymentUseCase.call(event.userId, event.bookingId, event.amount);
      emit(UserSuccess(message: "Payment processed successfully!"));
    } catch (e) {
      emit(UserFailure(message: e.toString()));
    }
  }

  Future<void> _onGetBookingSummaryEvent(GetBookingSummaryEvent event, Emitter<UserState> emit) async {
    emit(UserLoading());
    try {
      final summary = await getBookingSummaryUseCase.call(event.bookingId);
      emit(BookingSummaryLoaded(bookingSummary: summary));
    } catch (e) {
      emit(UserFailure(message: e.toString()));
    }
  }

  Future<void> _onGetUserBookingsEvent(GetUserBookingsEvent event, Emitter<UserState> emit) async {
    emit(UserLoading());
    try {
      final bookings = await getUserBookingsUseCase.call(event.userId);
      emit(UserBookingsLoaded(bookings: bookings));
    } catch (e) {
      emit(UserFailure(message: e.toString()));
    }
  }
}
