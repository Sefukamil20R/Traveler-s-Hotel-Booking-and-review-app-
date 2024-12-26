import 'package:hotel_booking_and_review_app/features/admin/domain/entities/admin_hotel.dart';

class AdminHotelModel extends AdminHotel {
  AdminHotelModel({
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

  // Method to convert model to Map for SQLite insertion
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'imageUrl': imageUrl,
      'price': price,
      'rating': rating,
      'location': location,
      'description': description,
      'amenities': amenities.join(','),
      'gallery': gallery.join(','),
      'latitude': latitude,
      'longitude': longitude,
    };
  }

  // Method to convert Map to model (for SQLite retrieval)
  factory AdminHotelModel.fromMap(Map<String, dynamic> map) {
    return AdminHotelModel(
      id: map['id'],
      name: map['name'],
      imageUrl: map['imageUrl'],
      price: map['price'],
      rating: map['rating'],
      location: map['location'],
      description: map['description'],
      amenities: map['amenities'].split(','),
      gallery: map['gallery'].split(','),
      latitude: map['latitude'],
      longitude: map['longitude'],
    );
  }
  AdminHotel toEntity() {
    return AdminHotel(
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
  factory AdminHotelModel.fromEntity(AdminHotel hotel) {
    return AdminHotelModel(
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
}
