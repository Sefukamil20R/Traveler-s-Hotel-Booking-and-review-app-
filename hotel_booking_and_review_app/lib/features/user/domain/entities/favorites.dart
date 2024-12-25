// domain/entities/favorites.dart
import 'package:equatable/equatable.dart';

class Favorites extends Equatable {
  final String userId;
  final List<String> hotelIds;

  Favorites({required this.userId, required this.hotelIds});

  @override
  List<Object?> get props => [userId, hotelIds];
}
