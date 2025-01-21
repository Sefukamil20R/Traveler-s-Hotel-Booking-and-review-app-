import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:hotel_booking_and_review_app/app.dart';
import 'package:hotel_booking_and_review_app/service_locator.dart';
import 'firebase_options.dart';  // If you're using the generated file for Firebase options
// import 'package:flutter_stripe/flutter_stripe.dart'; // Import Stripe package

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  // Stripe.publishableKey = 'pk_test_51PL1wLRpW5uwDL2GrSobZDQY6bKh5J88WHuR6KVDnqJTMRGo4tKSAECMbBDTlnnZTgkx2d6CDUbGhCT1gLI6kbyw00HgRObcSv'; // Replace with your test publishable key

  // Setup service locator
  await setupLocator();

  // Run the application
  runApp(HotelBookingApp());
}
