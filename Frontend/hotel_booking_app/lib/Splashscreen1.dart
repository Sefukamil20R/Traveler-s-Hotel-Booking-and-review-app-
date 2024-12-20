import 'dart:async';

import 'package:flutter/material.dart';
import 'package:hotel_booking_app/Splashscreen2.dart';
import 'package:hotel_booking_app/features/auth/presenation/pages/login_page.dart';
import 'package:hotel_booking_app/features/auth/presenation/pages/signup_page.dart';



class SplashScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Timer(Duration(seconds: 10), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => SplashScreen2()),
      );
    });

    return Scaffold(
      backgroundColor: Color(0xFF1E3E62),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Replace with your logo
            Icon(
              Icons.hotel,
              size: 100,
              color: Colors.white,
            ),
            SizedBox(height: 20),
            Text(
              'StaySphere',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            SizedBox(height: 10),
            Text(
              'Explore Book Relax',
              style: TextStyle(
                fontSize: 16,
                color: Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }
}