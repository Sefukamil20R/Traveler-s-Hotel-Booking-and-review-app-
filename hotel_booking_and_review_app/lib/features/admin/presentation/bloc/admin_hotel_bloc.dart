import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hotel_booking_and_review_app/features/admin/domain/usecase/admin_add_hotel.dart';
import 'package:hotel_booking_and_review_app/features/admin/domain/usecase/admin_delete_hotel.dart';
import 'package:hotel_booking_and_review_app/features/admin/domain/usecase/admin_edit_hotel.dart';
import 'package:hotel_booking_and_review_app/features/admin/domain/usecase/admin_get_hotels.dart';
import 'package:hotel_booking_and_review_app/features/admin/domain/usecase/assign_admin_role.dart';

import 'admin_hotel_event.dart';
import 'admin_hotel_state.dart';

class AdminHotelBloc extends Bloc<AdminHotelEvent, AdminHotelState> {
  final AdminAddHotel addHotel;
  final AdminEditHotel editHotel;
  final AdminDeleteHotel deleteHotel;
  final AssignRole assignRole;  
  final AdminGetHotels getHotels; // New use case

  AdminHotelBloc({
    required this.getHotels,
    required this.addHotel,
    required this.editHotel,
    required this.deleteHotel,
    required this.assignRole,  // Inject the new use case
  }) : super(AdminHotelInitial()) {
    print('AdminHotelBloc initialized with deleteHotel use case: $deleteHotel');

    // Register event handlers inside the constructor
    on<AddHotelEvent>(_onAddHotel);
    on<DeleteHotelEvent>(_onDeleteHotel);
    on<FetchHotelsEvent>(_onFetchHotels);
    on<EditHotelEvent>(_onEditHotel);
    on<AssignRoleEvent>(_onAssignRole);
  } // <-- Closing brace for the constructor

  // Define event handlers
  Future<void> _onAddHotel(AddHotelEvent event, Emitter<AdminHotelState> emit) async {
    emit(AdminHotelLoading());
    try {
      await addHotel.call(event.hotel);
      emit(AdminHotelSuccess("Hotel added successfully"));
      // Fetch the updated list of hotels after adding
      add(FetchHotelsEvent()); // <-- Here, dispatch the FetchHotelsEvent
    } catch (e) {
      emit(AdminHotelError("Failed to add hotel: ${e.toString()}"));
    }
  }

  Future<void> _onDeleteHotel(DeleteHotelEvent event, Emitter<AdminHotelState> emit) async {
    emit(AdminHotelLoading());
    try {
      await deleteHotel.call(event.hotelId);
      emit(AdminHotelSuccess("Hotel deleted successfully"));
      // Fetch the updated list of hotels after deletion
      add(FetchHotelsEvent()); // <-- Here, dispatch the FetchHotelsEvent
    } catch (e) {
      emit(AdminHotelError("Failed to delete hotel: ${e.toString()}"));
    }
  }

  Future<void> _onFetchHotels(FetchHotelsEvent event, Emitter<AdminHotelState> emit) async {
    emit(AdminHotelLoading());
    try {
      final hotels = await getHotels.call();
      emit(AdminHotelsLoaded(hotels));
    } catch (e) {
      emit(AdminHotelError("Failed to fetch hotels: ${e.toString()}"));
    }
  }

  Future<void> _onEditHotel(EditHotelEvent event, Emitter<AdminHotelState> emit) async {
    emit(AdminHotelLoading());
    try {
      await editHotel.call(event.hotel);  // Update the hotel in the repository
      emit(AdminHotelSuccess("Hotel updated successfully"));
    } catch (e) {
      emit(AdminHotelError("Failed to update hotel: ${e.toString()}"));
    }
  }

  // Handle assigning a role
  Future<void> _onAssignRole(AssignRoleEvent event, Emitter<AdminHotelState> emit) async {
    emit(AdminRoleAssigning());  // Emit loading state for role assignment
    try {
      await assignRole.call(event.userId, event.role);
      emit(AdminRoleAssigned());
    } catch (e) {
      emit(AdminRoleAssignError("Error assigning role: ${e.toString()}"));
    }
  }
} // <-- Closing brace for the class