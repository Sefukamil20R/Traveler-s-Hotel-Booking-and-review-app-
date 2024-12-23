import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hotel_booking_app/features/role/domain/usecase/assign_role.dart';
import 'package:hotel_booking_app/features/role/domain/usecase/fetch_role.dart';
import 'package:hotel_booking_app/features/role/presentaion/bloc/role_event.dart';
import 'package:hotel_booking_app/features/role/presentaion/bloc/role_state.dart';

class RoleBloc extends Bloc<RoleEvent, RoleState> {
  final AssignRoleUseCase assignRoleUseCase;
  final GetUserRoleUseCase getUserRoleUseCase;

  RoleBloc({required this.assignRoleUseCase, required this.getUserRoleUseCase})
      : super(RoleInitialState()) {
    on<AssignRoleEvent>(_onAssignRoleEvent);
    on<FetchUserRoleEvent>(_onFetchUserRoleEvent);
  }

  Future<void> _onAssignRoleEvent(
      AssignRoleEvent event, Emitter<RoleState> emit) async {
    emit(RoleLoadingState());
    try {
      await assignRoleUseCase.call(event.roleEntity);
      emit(RoleAssignedState());
    } catch (e) {
      emit(RoleErrorState(errorMessage: e.toString()));
    }
  }

  Future<void> _onFetchUserRoleEvent(
      FetchUserRoleEvent event, Emitter<RoleState> emit) async {
    emit(RoleLoadingState());
    try {
      final role = await getUserRoleUseCase.call(event.uid);
      emit(RoleFetchedState(role: role));
    } catch (e) {
      emit(RoleErrorState(errorMessage: e.toString()));
    }
  }
}
