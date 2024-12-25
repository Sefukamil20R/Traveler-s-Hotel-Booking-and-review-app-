// presentation/bloc/admin_hotel_bloc.dart
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hotel_booking_app/features/admin/domain/usecase/admin_add_hotel.dart';
import 'package:hotel_booking_app/features/admin/domain/usecase/admin_delete_hotel.dart';
import 'package:hotel_booking_app/features/admin/domain/usecase/admin_edit_hotel.dart';
import 'package:hotel_booking_app/features/admin/domain/usecase/assign_admin_role.dart';

import 'admin_hotel_event.dart';
import 'admin_hotel_state.dart';

class AdminHotelBloc extends Bloc<AdminHotelEvent, AdminHotelState> {
  final AdminAddHotel addHotel;
  final AdminEditHotel editHotel;
  final AdminDeleteHotel deleteHotel;
  final AssignRole assignRole;  

  AdminHotelBloc({
    required this.addHotel,
    required this.editHotel,
    required this.deleteHotel,
    required this.assignRole,  // Inject the new use case
  }) : super(AdminHotelInitial()) {
    on<AddHotelEvent>((event, emit) async {
      emit(AdminHotelLoading());
      try {
        await addHotel(event.hotel);
        emit(AdminHotelSuccess());
      } catch (e) {
        emit(AdminHotelError(e.toString()));
      }
    });

    on<EditHotelEvent>((event, emit) async {
      emit(AdminHotelLoading());
      try {
        await editHotel(event.hotel);
        emit(AdminHotelSuccess());
      } catch (e) {
        emit(AdminHotelError(e.toString()));
      }
    });

    on<DeleteHotelEvent>((event, emit) async {
      emit(AdminHotelLoading());
      try {
        await deleteHotel(event.hotelId);
        emit(AdminHotelSuccess());
      } catch (e) {
        emit(AdminHotelError(e.toString()));
      }
    });

    // Add the new event handler for assigning roles
    on<AssignRoleEvent>((event, emit) async {
      emit(AdminRoleAssigning()); // Emit a loading state for role assignment
      try {
        // Call the use case to assign the role
        await assignRole.call(event.userId, event.role);
        emit(AdminRoleAssigned()); // Emit a success state
      } catch (e) {
        // Emit an error state with a message
        emit(AdminRoleAssignError('Error assigning role: ${e.toString()}'));
      }
    });
  }
}
