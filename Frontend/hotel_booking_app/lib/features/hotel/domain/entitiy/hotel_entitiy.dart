// domain/entities/hotel.dart
class Hotel {
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

  Hotel({
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
}
