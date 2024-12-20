import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hotel_booking_app/Splashscreen1.dart';
import 'package:hotel_booking_app/features/auth/presenation/bloc/auth_bloc.dart';
import 'package:hotel_booking_app/Splashscreen2.dart'; // Initial screen for the app
import 'service_locator.dart';

class HotelBookingApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<AuthBloc>(
          create: (context) => locator<AuthBloc>(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Hotel Booking App',
        theme: ThemeData(primarySwatch: Colors.blue),
        home: SplashScreen2(), // Set the initial screen
      ),
    );
  }
}
