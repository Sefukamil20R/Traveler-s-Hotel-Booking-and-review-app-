// domain/usecases/get_user_favorites.dart

import 'package:hotel_booking_app/features/user/domain/entities/favorites.dart';
import 'package:hotel_booking_app/features/user/domain/repository/user_repository.dart';

class GetUserFavorites {
  final UserRepository repository;

  GetUserFavorites(this.repository);

  Future<Favorites> call(String userId) {
    return repository.getUserFavorites(userId);
  }
}
