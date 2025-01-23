import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hotel_booking_and_review_app/features/admin/domain/entities/admin_hotel.dart';
import 'package:hotel_booking_and_review_app/features/admin/presentation/bloc/admin_hotel_bloc.dart';
import 'package:hotel_booking_and_review_app/features/admin/presentation/bloc/admin_hotel_event.dart';

class HotelEditFormPage extends StatefulWidget {
  final AdminHotel hotel;

  HotelEditFormPage({required this.hotel});

  @override
  _HotelEditFormPageState createState() => _HotelEditFormPageState();
}

class _HotelEditFormPageState extends State<HotelEditFormPage> {
  late TextEditingController nameController;
  late TextEditingController locationController;
  late TextEditingController descriptionController;
  late TextEditingController priceController;
  late TextEditingController ratingController;
  late TextEditingController latitudeController;
  late TextEditingController longitudeController;
  
  // Initialize your form controllers
  @override
  void initState() {
    super.initState();
    nameController = TextEditingController(text: widget.hotel.name);
    locationController = TextEditingController(text: widget.hotel.location);
    descriptionController = TextEditingController(text: widget.hotel.description);
    priceController = TextEditingController(text: widget.hotel.price.toString());
    ratingController = TextEditingController(text: widget.hotel.rating.toString());
    latitudeController = TextEditingController(text: widget.hotel.latitude.toString());
    longitudeController = TextEditingController(text: widget.hotel.longitude.toString());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Edit Hotel", style: TextStyle(color: Colors.white)),
        backgroundColor: Color(0xFF1E3E62),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: ListView(
          children: <Widget>[
            TextField(
              controller: nameController,
              decoration: InputDecoration(labelText: 'Hotel Name'),
            ),
            TextField(
              controller: locationController,
              decoration: InputDecoration(labelText: 'Location'),
            ),
            TextField(
              controller: descriptionController,
              decoration: InputDecoration(labelText: 'Description'),
            ),
            TextField(
              controller: priceController,
              decoration: InputDecoration(labelText: 'Price'),
              keyboardType: TextInputType.number,
            ),
            TextField(
              controller: ratingController,
              decoration: InputDecoration(labelText: 'Rating'),
              keyboardType: TextInputType.number,
            ),
            TextField(
              controller: latitudeController,
              decoration: InputDecoration(labelText: 'Latitude'),
              keyboardType: TextInputType.number,
            ),
            TextField(
              controller: longitudeController,
              decoration: InputDecoration(labelText: 'Longitude'),
              keyboardType: TextInputType.number,
            ),
            // Add more fields if needed
            ElevatedButton(
              onPressed: () {
               
                final updatedHotel = AdminHotel(
                  id: widget.hotel.id,
                  name: nameController.text,
                  imageUrl: widget.hotel.imageUrl,  // Image URL should not change
                  price: double.parse(priceController.text),
                  rating: double.parse(ratingController.text),
                  location: locationController.text,
                  description: descriptionController.text,
                  amenities: widget.hotel.amenities,  // Assuming amenities and gallery are editable elsewhere
                  gallery: widget.hotel.gallery,
                  latitude: double.parse(latitudeController.text),
                  longitude: double.parse(longitudeController.text),
                );

                // Use Bloc to dispatch the EditHotelEvent
                context.read<AdminHotelBloc>().add(EditHotelEvent(updatedHotel));

                // Show success message or handle error
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('Hotel updated successfully!')),
                );
                Navigator.pop(context);
              },
              child: Text('Save Changes'),
            ),
          ],
        ),
      ),
    );
  }
}
