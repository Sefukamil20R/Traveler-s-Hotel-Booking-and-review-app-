// domain/usecases/add_to_favorites.dart


import 'package:hotel_booking_and_review_app/features/user/domain/repository/user_repository.dart';

class AddToFavorites {
  final UserRepository repository;

  AddToFavorites(this.repository);

  Future<void> call(String userId, String hotelId) {
    return repository.addToFavorites(userId, hotelId);
  }
}
