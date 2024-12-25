// data/models/hotel_model.dart

import 'package:hotel_booking_app/features/hotel/domain/entitiy/hotel_entitiy.dart';

class HotelModel extends Hotel {
  HotelModel({
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

  factory HotelModel.fromMap(Map<String, dynamic> map) {
    return HotelModel(
      id: map['id'],
      name: map['name'],
      imageUrl: map['imageUrl'],
      price: map['price'],
      rating: map['rating'],
      location: map['location'],
      description: map['description'],
      amenities: List<String>.from(map['amenities']),
      gallery: List<String>.from(map['gallery']),
      latitude: map['latitude'],
      longitude: map['longitude'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'imageUrl': imageUrl,
      'price': price,
      'rating': rating,
      'location': location,
      'description': description,
      'amenities': amenities,
      'gallery': gallery,
      'latitude': latitude,
      'longitude': longitude,
    };
  }
}
