
// import 'package:dartz/dartz.dart';
// import 'package:hotel_booking_app/features/auth/domain/entitities/auth_entitiy.dart';

// import 'package:hotel_booking_app/features/auth/domain/repositories/auth_repository.dart';

// class SignupUseCase {
//   final AuthRepository repository;

//   SignupUseCase(this.repository);

//   Future<Either<String, UserEntity>> call(UserEntity user) async {
//     try {
//       return await repository.signUp(
//         email: user.email,
//         password: user.password,
//         username: user.username,
//       );
//     } catch (e) {
//       return Left(e.toString());
//     }
//   }
// }
import 'package:dartz/dartz.dart';
import 'package:hotel_booking_app/features/auth/domain/entitities/auth_entitiy.dart';
import 'package:hotel_booking_app/features/auth/domain/repositories/auth_repository.dart';
import 'package:hotel_booking_app/features/role/domain/repository/role_repository.dart';
import 'package:hotel_booking_app/features/role/domain/Entiity/role_enitity.dart';
import 'package:hotel_booking_app/features/role/domain/usecase/assign_role.dart';
class SignupUseCase {
  final AuthRepository authRepository;
  final AssignRoleUseCase assignRoleUseCase; // Inject AssignRoleUseCase

  SignupUseCase(this.authRepository, this.assignRoleUseCase);

  Future<Either<String, UserEntity>> call(UserEntity user) async {
    try {
      final result = await authRepository.signUp(
        email: user.email,
        password: user.password,
        username: user.username,
      );

      return result.fold(
        (failure) => Left(failure),
        (user) async {
          // Assign default role (e.g., "user") after successful signup
          await assignRoleUseCase(
            RoleEntity(uid: user.uid, role: "user"),
          );
          return Right(user);
        },
      );
    } catch (e) {
      return Left(e.toString());
    }
  }
}
