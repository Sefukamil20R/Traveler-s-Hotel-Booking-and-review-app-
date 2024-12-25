import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hotel_booking_and_review_app/features/admin/presentation/pages/admin_dashboard.dart';
import 'package:hotel_booking_and_review_app/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:hotel_booking_and_review_app/features/auth/presentation/pages/login_page.dart';
import 'package:hotel_booking_and_review_app/features/role/presentation/bloc/role_bloc.dart';
import 'package:hotel_booking_and_review_app/features/user/presentation/pages/homepage.dart';
import 'package:hotel_booking_and_review_app/splashscreen1.dart';

import 'service_locator.dart';

class HotelBookingApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<AuthBloc>(
          create: (context) => locator<AuthBloc>(),
        ),
         BlocProvider<RoleBloc>(
          create: (context) => locator<RoleBloc>(),
        ),

      ],
      child:MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Hotel Booking App',
        theme: ThemeData(primarySwatch: Colors.blue),
        initialRoute: '/', // SplashScreen is the initial route
        routes: {
          '/': (context) => SplashScreen(),
          '/admin_dashboard': (context) => AdminDashboard(), // Add AdminDashboard here
          '/login': (context) => LoginPage(),
          '/home': (context) => HomePage()
        },
      ),
    );
  }
}
