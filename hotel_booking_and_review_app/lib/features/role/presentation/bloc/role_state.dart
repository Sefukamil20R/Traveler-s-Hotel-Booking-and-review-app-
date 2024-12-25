import 'package:equatable/equatable.dart';

abstract class RoleState extends Equatable {
  const RoleState();

  @override
  List<Object?> get props => [];
}

class RoleInitialState extends RoleState {}

class RoleLoadingState extends RoleState {}

class RoleAssignedState extends RoleState {}

class RoleFetchedState extends RoleState {
  final String role;

  RoleFetchedState({required this.role});

  @override
  List<Object?> get props => [role];
}

class RoleErrorState extends RoleState {
  final String errorMessage;

  RoleErrorState({required this.errorMessage});

  @override
  List<Object?> get props => [errorMessage];
}
