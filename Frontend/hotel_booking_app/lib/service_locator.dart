
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
  //usecases
  locator.registerFactory( () => SignupUseCase(locator()));
  locator.registerFactory( () => SignIn(locator()));
  locator.registerFactory( () => SignOut(locator()));
  locator.registerFactory( () => GetUserProfile(locator()));
  locator.registerFactory( () => VerifyEmail(locator())); 
  //repositories
    locator.registerLazySingleton<AuthRepository>(() => AuthRepositoryImpl(
    remoteDataSource: locator(),
  ));
  //datasources
  // Register FirebaseAuth
  locator.registerLazySingleton<FirebaseAuth>(() => FirebaseAuth.instance);

  // Register FirebaseFirestore
  locator.registerLazySingleton<FirebaseFirestore>(() => FirebaseFirestore.instance);
  //user_datasource
  locator.registerLazySingleton<RemoteDataSource>(() => RemoteDataSourceImpl(firebaseAuth: locator(), firestore: locator()
   
  ));

}