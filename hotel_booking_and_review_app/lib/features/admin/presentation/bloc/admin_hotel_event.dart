// presentation/bloc/admin_hotel_event.dart
import 'package:equatable/equatable.dart';
import 'package:hotel_booking_and_review_app/features/admin/domain/entities/admin_hotel.dart';

abstract class AdminHotelEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class AddHotelEvent extends AdminHotelEvent {
  final AdminHotel hotel;

  AddHotelEvent(this.hotel);

  @override
  List<Object?> get props => [hotel];
}

class EditHotelEvent extends AdminHotelEvent {
  final AdminHotel hotel;

  EditHotelEvent(this.hotel);

  @override
  List<Object?> get props => [hotel];
}

class DeleteHotelEvent extends AdminHotelEvent {
  final String hotelId;

  DeleteHotelEvent(this.hotelId);

  @override
  List<Object?> get props => [hotelId];
}
class AssignRoleEvent extends AdminHotelEvent {
  final String userId;
  final String role;

   AssignRoleEvent({required this.userId, required this.role});

  @override
  List<Object?> get props => [userId, role];
}