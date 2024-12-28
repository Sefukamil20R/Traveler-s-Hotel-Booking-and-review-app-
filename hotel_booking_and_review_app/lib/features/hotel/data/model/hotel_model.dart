
import 'package:hotel_booking_and_review_app/features/hotel/domain/entitiy/hotel_entitiy.dart';

class HotelModel {
  final String id;
  final String name;
  final String imageUrl;
  final double price;
  final double rating;
  final String location;
  final String description;
  final List<String> amenities;
  final List<String> gallery;
  final double latitude;
  final double longitude;

  HotelModel({
    required this.id,
    required this.name,
    required this.imageUrl,
    required this.price,
    required this.rating,
    required this.location,
    required this.description,
    required this.amenities,
    required this.gallery,
    required this.latitude,
    required this.longitude,
  });

  factory HotelModel.fromEntity(Hotel hotel) {
    return HotelModel(
      id: hotel.id,
      name: hotel.name,
      imageUrl: hotel.imageUrl,
      price: hotel.price,
      rating: hotel.rating,
      location: hotel.location,
      description: hotel.description,
      amenities: hotel.amenities,
      gallery: hotel.gallery,
      latitude: hotel.latitude,
      longitude: hotel.longitude,
    );
  }

  Hotel toEntity() {
    return Hotel(
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

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'imageUrl': imageUrl,
      'price': price,
      'rating': rating,
      'location': location,
      'description': description,
      'amenities': amenities.join(','), // Store as a comma-separated string
      'gallery': gallery.join(','), // Store as a comma-separated string
      'latitude': latitude,
      'longitude': longitude,
    };
  }

  factory HotelModel.fromMap(Map<String, dynamic> map) {
    return HotelModel(
      id: map['id'],
      name: map['name'],
      imageUrl: map['imageUrl'],
      price: map['price'],
      rating: map['rating'],
      location: map['location'],
      description: map['description'],
      amenities: (map['amenities'] as String).split(','),
      gallery: (map['gallery'] as String).split(','),
      latitude: map['latitude'],
      longitude: map['longitude'],
    );
  }
}
