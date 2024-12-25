// data/repository_impl/hotel_repository_impl.dart


import 'package:hotel_booking_app/features/hotel/data/datasource/hotel_remote_datasource.dart';
import 'package:hotel_booking_app/features/hotel/domain/entitiy/hotel_entitiy.dart';
import 'package:hotel_booking_app/features/hotel/domain/repository/hotel_repository.dart';

class HotelRepositoryImpl implements HotelRepository {
  final HotelRemoteDataSource remoteDataSource;

  HotelRepositoryImpl({required this.remoteDataSource});

  @override
  Future<List<Hotel>> getHotels() async {
    return await remoteDataSource.fetchHotels();
  }

  @override
  Future<Hotel> getHotelDetails(String hotelId) async {
    return await remoteDataSource.fetchHotelDetails(hotelId);
  }
}
