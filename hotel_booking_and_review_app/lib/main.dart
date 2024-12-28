import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:hotel_booking_and_review_app/app.dart';
import 'package:hotel_booking_and_review_app/service_locator.dart';
import 'firebase_options.dart';  // If you're using the generated file for Firebase options

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  // Setup service locator
  await setupLocator();

  // Run the application
  runApp(HotelBookingApp());
}
