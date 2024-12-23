import 'package:hotel_booking_app/features/role/data/datasource/remotedatasource.dart';
import 'package:hotel_booking_app/features/role/domain/Entiity/role_enitity.dart';
import 'package:hotel_booking_app/features/role/domain/repository/role_repository.dart';

class RoleRepositoryImpl implements RoleRepository {
  final RoleRemoteDataSource remoteDataSource;

  RoleRepositoryImpl({required this.remoteDataSource});

  @override
  @override
Future<void> assignRole(RoleEntity roleEntity) async {
  await remoteDataSource.assignRole(roleEntity);
}


  @override
  Future<String> getUserRole(String uid) async {
    return await remoteDataSource.getUserRole(uid);
  }
}
