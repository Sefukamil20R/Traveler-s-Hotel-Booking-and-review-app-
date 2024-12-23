
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get_it/get_it.dart';
import 'package:hotel_booking_app/features/auth/data/datasources/remote_datasource.dart';
import 'package:hotel_booking_app/features/auth/data/repositories/auth_repositoryimpl.dart';
import 'package:hotel_booking_app/features/auth/domain/repositories/auth_repository.dart';
import 'package:hotel_booking_app/features/auth/domain/usecase/Signinusecase.dart';
import 'package:hotel_booking_app/features/auth/domain/usecase/Signupusecase.dart';
import 'package:hotel_booking_app/features/auth/domain/usecase/get_user_profile.dart';
import 'package:hotel_booking_app/features/auth/domain/usecase/sign_out_usecase.dart';
import 'package:hotel_booking_app/features/auth/domain/usecase/verify_email_usecase.dart';
import 'package:hotel_booking_app/features/auth/presenation/bloc/auth_bloc.dart';
import 'package:hotel_booking_app/features/role/data/datasource/remotedatasource.dart';
import 'package:hotel_booking_app/features/role/data/repositories/role_repositoryimpl.dart';
import 'package:hotel_booking_app/features/role/domain/repository/role_repository.dart';
import 'package:hotel_booking_app/features/role/domain/usecase/assign_role.dart';
import 'package:hotel_booking_app/features/role/domain/usecase/fetch_role.dart';
import 'package:hotel_booking_app/features/role/presentaion/bloc/role_bloc.dart';

final locator = GetIt.instance;
Future <void> setupLocator() async {
  //users_bloc
  locator.registerFactory( () => AuthBloc(
    
     signupUseCase: locator(), 
     signInUseCase: locator(), 
     signOutUseCase: locator(), 
     getUserProfileUseCase: locator(), 
     verifyEmailUseCase: locator()
    
  ));
  // role _ bloc
  locator.registerFactory( () => RoleBloc(assignRoleUseCase: locator(), getUserRoleUseCase: locator()));

  //usecases_auth
  locator.registerFactory( () => SignupUseCase(locator(), locator()));
  locator.registerFactory( () => SignIn(locator()));
  locator.registerFactory( () => SignOut(locator()));
  locator.registerFactory( () => GetUserProfile(locator()));
  locator.registerFactory( () => VerifyEmail(locator())); 
  //usecases_role
  locator.registerFactory( () => AssignRoleUseCase(locator()));
  locator.registerFactory( () => GetUserRoleUseCase(locator()));
  //repositories_auth
    locator.registerLazySingleton<AuthRepository>(() => AuthRepositoryImpl(
    remoteDataSource: locator(),
  ));
  //repositories_role
  locator.registerLazySingleton<RoleRepository>(() => RoleRepositoryImpl(
    remoteDataSource: locator(),
  ));
  //datasources_auth
   locator.registerLazySingleton<RemoteDataSource>(() => RemoteDataSourceImpl(firebaseAuth: locator(), firestore: locator()
   
  ));
  // Register FirebaseAuth
  locator.registerLazySingleton<FirebaseAuth>(() => FirebaseAuth.instance);
   //datasources_role
      locator.registerLazySingleton<RoleRemoteDataSource>(() => RoleRemoteDataSource(
        firestore: locator(),
      ));
  // Register FirebaseFirestore
locator.registerLazySingleton<FirebaseFirestore>(() => FirebaseFirestore.instance);
  
 

}