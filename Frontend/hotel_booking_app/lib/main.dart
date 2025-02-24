import 'dart:async';

import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:hotel_booking_app/app.dart';
import 'firebase_options.dart'; // Generated by `flutterfire configure`
import 'service_locator.dart'; // Service locator setu


Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize Firebase
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  // Setup service locator
  await setupLocator();

  // Run the application
  runApp(HotelBookingApp());
}
