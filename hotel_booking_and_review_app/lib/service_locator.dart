
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get_it/get_it.dart';
import 'package:hotel_booking_and_review_app/features/admin/data/datasource/admin_hotel_remote_datasource.dart';
import 'package:hotel_booking_and_review_app/features/admin/data/repository/admin_hotel_repository_impl.dart';
import 'package:hotel_booking_and_review_app/features/admin/domain/repository/admin_hotel_repository.dart';
import 'package:hotel_booking_and_review_app/features/admin/domain/usecase/admin_add_hotel.dart';
import 'package:hotel_booking_and_review_app/features/admin/domain/usecase/admin_delete_hotel.dart';
import 'package:hotel_booking_and_review_app/features/admin/domain/usecase/admin_edit_hotel.dart';
import 'package:hotel_booking_and_review_app/features/admin/domain/usecase/assign_admin_role.dart';
import 'package:hotel_booking_and_review_app/features/admin/presentation/bloc/admin_hotel_bloc.dart';
import 'package:hotel_booking_and_review_app/features/auth/data/datasources/remote_datasource.dart';
import 'package:hotel_booking_and_review_app/features/auth/data/repositories/auth_repositoryimpl.dart';
import 'package:hotel_booking_and_review_app/features/auth/domain/repositories/auth_repository.dart';
import 'package:hotel_booking_and_review_app/features/auth/domain/usecase/Signinusecase.dart';
import 'package:hotel_booking_and_review_app/features/auth/domain/usecase/Signupusecase.dart';
import 'package:hotel_booking_and_review_app/features/auth/domain/usecase/get_user_profile.dart';
import 'package:hotel_booking_and_review_app/features/auth/domain/usecase/sign_out_usecase.dart';
import 'package:hotel_booking_and_review_app/features/auth/domain/usecase/verify_email_usecase.dart';
import 'package:hotel_booking_and_review_app/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:hotel_booking_and_review_app/features/hotel/data/datasource/hotel_remote_datasource.dart';
import 'package:hotel_booking_and_review_app/features/hotel/data/repository/hotel_repository_impl.dart';
import 'package:hotel_booking_and_review_app/features/hotel/domain/repository/hotel_repository.dart';
import 'package:hotel_booking_and_review_app/features/hotel/domain/usecase/get_hotel_details.dart';
import 'package:hotel_booking_and_review_app/features/hotel/domain/usecase/get_hotel_listings.dart';
import 'package:hotel_booking_and_review_app/features/hotel/presentation/bloc/hotel_bloc.dart';
import 'package:hotel_booking_and_review_app/features/role/data/datasource/remotedatasource.dart';
import 'package:hotel_booking_and_review_app/features/role/data/repositories/role_repositoryimpl.dart';
import 'package:hotel_booking_and_review_app/features/role/domain/repository/role_repository.dart';
import 'package:hotel_booking_and_review_app/features/role/domain/usecase/assign_role.dart';
import 'package:hotel_booking_and_review_app/features/role/domain/usecase/fetch_role.dart';
import 'package:hotel_booking_and_review_app/features/role/presentation/bloc/role_bloc.dart';
import 'package:hotel_booking_and_review_app/features/user/data/datasource/user_remote_datasource.dart';
import 'package:hotel_booking_and_review_app/features/user/data/repository/user_repository_impl.dart';
import 'package:hotel_booking_and_review_app/features/user/domain/entities/processpayment.dart';
import 'package:hotel_booking_and_review_app/features/user/domain/repository/user_repository.dart';
import 'package:hotel_booking_and_review_app/features/user/domain/usecase/add_to_favorites.dart';
import 'package:hotel_booking_and_review_app/features/user/domain/usecase/book_hotel.dart';
import 'package:hotel_booking_and_review_app/features/user/domain/usecase/get_booking_summury.dart';
import 'package:hotel_booking_and_review_app/features/user/domain/usecase/get_user_bookings.dart';
import 'package:hotel_booking_and_review_app/features/user/presentation/bloc/user_bloc.dart';

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
  //hotel_bloc

  locator.registerFactory( () => HotelBloc(getHotelListings: locator(), getHotelDetails: locator()));
  //user_bloc
  locator.registerFactory( () => UserBloc(bookHotelUseCase: locator(), addToFavoritesUseCase: locator(), processPaymentUseCase: locator(), getBookingSummaryUseCase: locator(), getUserBookingsUseCase: locator()));
   //admin_bloc
  locator.registerFactory( () => AdminHotelBloc(addHotel: locator(), editHotel: locator(), deleteHotel: locator(), assignRole: locator()));
  //  usecases_auth
  locator.registerFactory( () => SignupUseCase(locator(), locator()));
  locator.registerFactory( () => SignIn(locator()));
  locator.registerFactory( () => SignOut(locator()));
  locator.registerFactory( () => GetUserProfile(locator()));
  locator.registerFactory( () => VerifyEmail(locator())); 
  //usecases_role
  locator.registerFactory( () => AssignRoleUseCase(locator()));
  locator.registerFactory( () => GetUserRoleUseCase(locator()));
  //usecases_hotel
  locator.registerFactory( () => GetHotelListings(locator()));
  locator.registerFactory( () => GetHotelDetails(locator()));
  // usecases_user
  locator.registerFactory( () => BookHotel(locator()));
  locator.registerFactory( () => AddToFavorites(locator()));
  locator.registerFactory( () => ProcessPayment(locator()));
  locator.registerFactory( () => GetBookingSummary(locator()));
  locator.registerFactory( () => GetUserBookings(locator()));
  // usecases_admin
  locator.registerFactory( () => AdminAddHotel(locator()));
  locator.registerFactory( () => AdminEditHotel(locator()));
  locator.registerFactory( () => AdminDeleteHotel(locator()));
  locator.registerFactory( () => AssignRole(locator()));  
  // repositories_hotel
  locator.registerLazySingleton<HotelRepository>(() => HotelRepositoryImpl(
    remoteDataSource: locator(),
  ));
  // repositories_user
  locator.registerLazySingleton<UserRepository>(() => UserRepositoryImpl(
    remoteDataSource: locator(),
  ));  
  // repositories_admin
  locator.registerLazySingleton<AdminHotelRepository>(() => AdminHotelRepositoryImpl(
    remoteDataSource: locator(), firestore: locator(),
  ));  
  
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
  // datasources_hotel
  locator.registerLazySingleton<HotelRemoteDataSource>(() => HotelRemoteDataSourceImpl( firestore: locator()));
  //datasources_user
  locator.registerLazySingleton<UserRemoteDataSource>(() => UserRemoteDataSourceImpl( firestore: locator(), auth: locator())); 
  //datasources_admin
  locator.registerLazySingleton<AdminHotelRemoteDataSource>(() => AdminHotelRemoteDataSourceImpl( firestore: locator()));
}