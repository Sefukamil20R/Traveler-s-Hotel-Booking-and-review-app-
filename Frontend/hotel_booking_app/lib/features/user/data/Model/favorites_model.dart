// data/models/favorites_model.dart
import 'package:hotel_booking_app/features/user/domain/entities/favorites.dart';

class FavoritesModel extends Favorites {
  FavoritesModel({required String userId, required List<String> hotelIds})
      : super(userId: userId, hotelIds: hotelIds);

  factory FavoritesModel.fromMap(String userId, Map<String, dynamic> map) {
    return FavoritesModel(
      userId: userId,
      hotelIds: List<String>.from(map['hotels'] ?? []),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'hotels': hotelIds,
    };
  }
}
