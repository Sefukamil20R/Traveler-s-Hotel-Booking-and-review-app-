// presentation/bloc/admin_hotel_state.dart
import 'package:equatable/equatable.dart';
import 'package:hotel_booking_and_review_app/features/admin/domain/entities/admin_hotel.dart';

abstract class AdminHotelState extends Equatable {
  @override
  List<Object?> get props => [];
}

class AdminHotelInitial extends AdminHotelState {}

class AdminHotelLoading extends AdminHotelState {}

class AdminHotelSuccess extends AdminHotelState {
  final String message;

  AdminHotelSuccess(this.message);

  @override
  List<Object?> get props => [message];
}

class AdminHotelError extends AdminHotelState {
  final String message;

  AdminHotelError(this.message);

  @override
  List<Object?> get props => [message];
}

class AdminRoleAssigning extends AdminHotelState {}

class AdminRoleAssigned extends AdminHotelState {}

class AdminRoleAssignError extends AdminHotelState {
  final String message;

  AdminRoleAssignError(this.message);

  @override
  List<Object?> get props => [message];
}
class AdminHotelsLoaded extends AdminHotelState {
  final List<AdminHotel> hotels;

  AdminHotelsLoaded(this.hotels);
}
class AdminHotelEditing extends AdminHotelState {}

class AdminHotelEdited extends AdminHotelState {
  final String message;

  AdminHotelEdited(this.message);

  @override
  List<Object?> get props => [message];
}

class AdminHotelEditError extends AdminHotelState {
  final String message;

  AdminHotelEditError(this.message);

  @override
  List<Object?> get props => [message];
}
