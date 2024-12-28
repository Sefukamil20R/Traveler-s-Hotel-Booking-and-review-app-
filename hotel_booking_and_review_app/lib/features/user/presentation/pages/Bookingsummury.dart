import 'dart:io';

import 'package:flutter/material.dart';
import 'package:hotel_booking_and_review_app/features/hotel/domain/entitiy/hotel_entitiy.dart';
import 'package:hotel_booking_and_review_app/features/user/presentation/pages/paymentsummury.dart';

class BookingSummaryPage extends StatelessWidget {
  final String username;
  final String checkInDate;
  final String checkOutDate;
  final double totalPrice;
  final Hotel hotel;

  BookingSummaryPage({
    required this.username,
    required this.checkInDate,
    required this.checkOutDate,
    required this.totalPrice,
    required this.hotel,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Booking Summary'),
        backgroundColor: Color(0xFF1E3E62),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Hotel Details', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            SizedBox(height: 8),
            Image.file(
              File(hotel.gallery[0]),
              height: 200,
              fit: BoxFit.cover,
            ),
            SizedBox(height: 8),
            Text(hotel.name, style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
            Text(hotel.location, style: TextStyle(fontSize: 14, color: Colors.grey)),
            SizedBox(height: 16),
            Text('Booking Details', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            SizedBox(height: 8),
            Text('Username: $username'),
            Text('Check-In Date: $checkInDate'),
            Text('Check-Out Date: $checkOutDate'),
            Text('Total Price: \$${totalPrice.toStringAsFixed(2)}'),
            Spacer(),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => PaymentPage(
                      
                    ),
                  ),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Color(0xFF1E3E62),
              ),
              child: Text('Proceed to Payment'),
            ),
          ],
        ),
      ),
    );
  }
}