import 'package:dartz/dartz.dart';
import 'package:hotel_booking_and_review_app/features/auth/data/datasources/remote_datasource.dart';
import '../../domain/entitities/auth_entitiy.dart';
import '../../domain/repositories/auth_repository.dart';

class AuthRepositoryImpl implements AuthRepository {
  final RemoteDataSource remoteDataSource;

  AuthRepositoryImpl({required this.remoteDataSource});

  @override
  Future<Either<String, UserEntity>> signUp({
    required String email,
    required String password,
    required String username,
  }) async {
    try {
      final user = await remoteDataSource.signUp(email, password, username);
      return Right(user);
    } catch (e) {
      return Left(e.toString());
    }
  }

  @override
  Future<Either<String, UserEntity>> signIn({
    required String email,
    required String password,
  }) async {
    try {
      final user = await remoteDataSource.signIn(email, password);
      return Right(user);
    } catch (e) {
      return Left(e.toString());
    }
  }

  @override
  Future<void> signOut() async {
    await remoteDataSource.signOut();
  }

  @override
  Future<Either<String, UserEntity>> getUserProfile() async {
    try {
      final user = await remoteDataSource.getUserProfile();
      return Right(user);
    } catch (e) {
      return Left(e.toString());
    }
  }

  @override
  Future<void> verifyEmail() async {
    await remoteDataSource.verifyEmail();
  }
}
