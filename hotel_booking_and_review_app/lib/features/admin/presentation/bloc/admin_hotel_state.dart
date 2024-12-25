// presentation/bloc/admin_hotel_state.dart
import 'package:equatable/equatable.dart';

abstract class AdminHotelState extends Equatable {
  @override
  List<Object?> get props => [];
}

class AdminHotelInitial extends AdminHotelState {}

class AdminHotelLoading extends AdminHotelState {}

class AdminHotelSuccess extends AdminHotelState {}

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