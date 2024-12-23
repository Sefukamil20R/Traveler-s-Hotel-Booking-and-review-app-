import 'package:equatable/equatable.dart';
import 'package:hotel_booking_app/features/role/domain/Entiity/role_enitity.dart';

abstract class RoleEvent extends Equatable {
  const RoleEvent();

  @override
  List<Object?> get props => [];
}

class AssignRoleEvent extends RoleEvent {
  final RoleEntity roleEntity;

  AssignRoleEvent({required this.roleEntity});

  @override
  List<Object?> get props => [roleEntity];
}

class FetchUserRoleEvent extends RoleEvent {
  final String uid;

  FetchUserRoleEvent({required this.uid});

  @override
  List<Object?> get props => [uid];
}
