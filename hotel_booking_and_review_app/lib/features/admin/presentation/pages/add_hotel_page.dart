import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hotel_booking_and_review_app/features/admin/presentation/bloc/admin_hotel_event.dart';
import 'package:hotel_booking_and_review_app/features/admin/domain/entities/admin_hotel.dart';
import 'package:hotel_booking_and_review_app/features/admin/presentation/bloc/admin_hotel_bloc.dart';
import 'package:hotel_booking_and_review_app/features/admin/data/repository/admin_hotel_repository_impl.dart';
import 'package:hotel_booking_and_review_app/utils/file_utils.dart';  // Import ImageStorage

class AddHotelPage extends StatefulWidget {
  @override
  _AddHotelPageState createState() => _AddHotelPageState();
}

class _AddHotelPageState extends State<AddHotelPage> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _locationController = TextEditingController();
  final TextEditingController _priceController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _amenitiesController = TextEditingController();
  final TextEditingController _latitudeController = TextEditingController();
  final TextEditingController _longitudeController = TextEditingController();

  String? _imagePath;
  List<String> _amenities = [];
  List<String> _gallery = [];
  
  final _formKey = GlobalKey<FormState>();
  final ImageStorage _imageStorage = ImageStorage();  // Create an instance of ImageStorage

  void _submitForm() {
    if (_formKey.currentState?.validate() ?? false) {
      final hotel = AdminHotel(
        id: DateTime.now().toString(),
        name: _nameController.text,
        imageUrl: _imagePath ?? '',
        price: double.parse(_priceController.text),
        rating: 4.0,  // Default rating
        location: _locationController.text,
        description: _descriptionController.text,
        amenities: _amenities,
        gallery: _gallery,
        latitude: double.parse(_latitudeController.text),
        longitude: double.parse(_longitudeController.text),
      );

      // Call the BLoC to add the hotel
context.read<AdminHotelBloc>().add(AddHotelEvent(hotel));

      // Show confirmation message
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Hotel Added Successfully!"))
      );
    }
  }

  Future<void> _pickImage() async {
    final imagePath = await _imageStorage.pickImage();
    if (imagePath != null) {
      setState(() {
        _imagePath = imagePath;
      });
    }
  }

  void _addAmenity() {
    if (_amenitiesController.text.isNotEmpty) {
      setState(() {
        _amenities.add(_amenitiesController.text);
        _amenitiesController.clear();
      });
    }
  }

  void _addGalleryImage() {
    if (_imagePath != null) {
      setState(() {
        _gallery.add(_imagePath!);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Add Hotel",style: TextStyle(color: Color(0xFF1E3E62)),),
        backgroundColor: Colors.white, // Use your color
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                _buildTextField(_nameController, 'Hotel Name', 'Please enter a hotel name'),
                _buildTextField(_locationController, 'Location', 'Please enter a location'),
                _buildTextField(_priceController, 'Price', 'Please enter a price', isNumber: true),
                _buildTextField(_descriptionController, 'Description', 'Please enter a description'),
                _buildTextField(_latitudeController, 'Latitude', 'Please enter latitude', isNumber: true),
                _buildTextField(_longitudeController, 'Longitude', 'Please enter longitude', isNumber: true),
                
                // Amenities Section
                _buildTextField(_amenitiesController, 'Add Amenities', null),
                
                // 2x2 Grid for buttons
                GridView.count(
                  crossAxisCount: 2,
                  childAspectRatio: 3,
                  crossAxisSpacing: 16,
                  mainAxisSpacing: 16,
                  shrinkWrap: true,
                  children: [
                    ElevatedButton(
                      onPressed: _addAmenity,
                      child: Text("Add Amenity",style: TextStyle(color: Colors.white,)),
                      style: ElevatedButton.styleFrom(iconColor: Colors.white ,
                        backgroundColor: Color(0xFF1E3E62),),  // Button color
                    ),
                    ElevatedButton(
                      onPressed: _pickImage,
                      child: Text("Pick Image for Gallery",style: TextStyle(color: Colors.white,)),
                      style: ElevatedButton.styleFrom(iconColor: Colors.white ,
                        backgroundColor: Color(0xFF1E3E62),),  // Button color
                    ),
                    ElevatedButton(
                      onPressed: _addGalleryImage,
                      child: Text("Add Image to Gallery",style: TextStyle(color: Colors.white,)),
                      style: ElevatedButton.styleFrom(iconColor: Colors.white ,
                        backgroundColor: Color(0xFF1E3E62),),  // Button color
                    ),
                    ElevatedButton(
                      onPressed: _submitForm,
                      child: Text("Add Hotel",style: TextStyle(color: Colors.white,),),
                      style: ElevatedButton.styleFrom(
                        iconColor: Colors.white ,
                        backgroundColor: Color(0xFF1E3E62), // Button color
                      ),
                    ),
                  ],
                ),
                
                // Spacing for showing added amenities and gallery images
                SizedBox(height: 16.0),
                
                // Amenities List
                Wrap(
                  children: _amenities
                      .map((amenity) => Chip(label: Text(amenity)))
                      .toList(),
                ),
                
                // Gallery Images Display
                Wrap(
                  children: _gallery
                      .map((image) => Padding(
                            padding: const EdgeInsets.all(4.0),
                            child: Image.file(File(image), width: 50, height: 50),
                          ))
                      .toList(),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // Helper method to build text fields
  Widget _buildTextField(TextEditingController controller, String label, String? validationMessage, {bool isNumber = false}) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16.0),
      child: TextFormField(
        controller: controller,
        decoration: InputDecoration(
          labelText: label,
          filled: true,
          fillColor: Color(0xFFF5F5F5),  // Light gray background
          border: OutlineInputBorder(),
        ),
        keyboardType: isNumber ? TextInputType.number : TextInputType.text,
        validator: validationMessage == null
            ? null
            : (value) {
                if (value?.isEmpty ?? true) {
                  return validationMessage;
                }
                return null;
              },
      ),
    );
  }
}
