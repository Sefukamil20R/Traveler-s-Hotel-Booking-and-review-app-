import 'dart:io';
import 'package:flutter/material.dart';
import 'package:hotel_booking_and_review_app/features/hotel/domain/entitiy/hotel_entitiy.dart';

class BookingSummaryPage extends StatelessWidget {
  final Hotel hotel;
  final DateTime? checkInDate;
  final DateTime? checkOutDate;
  final int numRooms;
  final int numAdults;
  final int numChildren;

  BookingSummaryPage({
    required this.hotel,
    required this.checkInDate,
    required this.checkOutDate,
    required this.numRooms,
    required this.numAdults,
    required this.numChildren,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Booking Summary', style: TextStyle(color: Colors.white)),
        backgroundColor: Color(0xFF002B5C), // Navy Blue
        iconTheme: IconThemeData(color: Colors.white),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: Image.file(
                  File(hotel.gallery[0]),
                  width: double.infinity,
                  height: 250,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    hotel.name,
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Color(0xFF002B5C)), // Navy Blue
                  ),
                  SizedBox(height: 8),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Check-in', style: TextStyle(fontWeight: FontWeight.bold, color: Color(0xFF2C3E50))), // Dark Gray
                          Text(checkInDate != null
                              ? '${checkInDate!.day}/${checkInDate!.month}/${checkInDate!.year}'
                              : 'Not set', style: TextStyle(color: Color(0xFF2C3E50))), // Dark Gray
                        ],
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Check-out', style: TextStyle(fontWeight: FontWeight.bold, color: Color(0xFF2C3E50))), // Dark Gray
                          Text(checkOutDate != null
                              ? '${checkOutDate!.day}/${checkOutDate!.month}/${checkOutDate!.year}'
                              : 'Not set', style: TextStyle(color: Color(0xFF2C3E50))), // Dark Gray
                        ],
                      ),
                    ],
                  ),
                  SizedBox(height: 16),
                  Text(
                    'Rooms & Guests',
                    style: TextStyle(fontWeight: FontWeight.bold, color: Color(0xFF2C3E50)), // Dark Gray
                  ),
                  Text('$numRooms Rooms, $numAdults Adults, $numChildren Children', style: TextStyle(color: Color(0xFF2C3E50))), // Dark Gray
                  SizedBox(height: 16),
                  Text(
                    'Total Price',
                    style: TextStyle(fontWeight: FontWeight.bold, color: Color(0xFF2C3E50)), // Dark Gray
                  ),
                  Text('\$${hotel.price * numRooms}/Day', style: TextStyle(color: Color(0xFF2C3E50))), // Dark Gray
                  SizedBox(height: 16),
                  Container(
                    padding: const EdgeInsets.all(16.0),
                    decoration: BoxDecoration(
                      color: Color(0xFFF5F5F5), // Light Gray
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Text(
                      'We hope you enjoy your stay at ${hotel.name}. Our team is dedicated to making your experience unforgettable. Relax and unwind in our luxurious accommodations, and take advantage of all the amenities we have to offer.',
                      style: TextStyle(fontSize: 16, color: Color(0xFF2C3E50)), // Dark Gray
                      textAlign: TextAlign.center,
                    ),
                  ),
                  SizedBox(height: 16),
                  Center(
                    child: ElevatedButton(
                      onPressed: () {
                        // Navigate to payment page or handle payment
                      },
                      style: ElevatedButton.styleFrom(
                        minimumSize: Size(double.infinity, 50),
                        backgroundColor: Color(0xFF002B5C), // Navy Blue
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      child: Text('Proceed to Payment', style: TextStyle(color: Colors.white)), // White
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}