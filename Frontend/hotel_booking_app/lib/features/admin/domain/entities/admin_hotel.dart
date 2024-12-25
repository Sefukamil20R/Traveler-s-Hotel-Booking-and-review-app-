// domain/entities/admin_hotel.dart

import 'package:hotel_booking_app/features/hotel/domain/entitiy/hotel_entitiy.dart';

class AdminHotel extends Hotel {
  AdminHotel({
    required String id,
    required String name,
    required String imageUrl,
    required double price,
    required double rating,
    required String location,
    required String description,
    required List<String> amenities,
    required List<String> gallery,
    required double latitude,
    required double longitude,
  }) : super(
          id: id,
          name: name,
          imageUrl: imageUrl,
          price: price,
          rating: rating,
          location: location,
          description: description,
          amenities: amenities,
          gallery: gallery,
          latitude: latitude,
          longitude: longitude,
        );
}
