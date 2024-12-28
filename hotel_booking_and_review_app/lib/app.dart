// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:hotel_booking_and_review_app/features/admin/domain/entities/admin_hotel.dart';
// import 'package:hotel_booking_and_review_app/features/admin/presentation/bloc/admin_hotel_bloc.dart';
// import 'package:hotel_booking_and_review_app/features/admin/presentation/pages/add_hotel_page.dart';
// import 'package:hotel_booking_and_review_app/features/admin/presentation/pages/admin_dashboard.dart';
// import 'package:hotel_booking_and_review_app/features/admin/presentation/pages/assign_role_page.dart';
// import 'package:hotel_booking_and_review_app/features/admin/presentation/pages/delete_hotel_page.dart';
// import 'package:hotel_booking_and_review_app/features/admin/presentation/pages/edit_hotel_page.dart';
// import 'package:hotel_booking_and_review_app/features/auth/presentation/bloc/auth_bloc.dart';
// import 'package:hotel_booking_and_review_app/features/auth/presentation/pages/login_page.dart';
// import 'package:hotel_booking_and_review_app/features/hotel/presentation/bloc/hotel_bloc.dart';
// import 'package:hotel_booking_and_review_app/features/role/presentation/bloc/role_bloc.dart';
// import 'package:hotel_booking_and_review_app/features/user/presentation/pages/homepage.dart';
// import 'package:hotel_booking_and_review_app/features/user/presentation/pages/hotel_details.dart';
// import 'package:hotel_booking_and_review_app/splashscreen1.dart';

// import 'service_locator.dart';

// class HotelBookingApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MultiBlocProvider(
//       providers: [
//         BlocProvider<AuthBloc>(
//           create: (context) => locator<AuthBloc>(),
//         ),
//          BlocProvider<RoleBloc>(
//           create: (context) => locator<RoleBloc>(),
//         ),
//         BlocProvider<AdminHotelBloc>(
//           create: (context) => locator<AdminHotelBloc>(),
//         ),
//         BlocProvider<HotelBloc>(
//           create: (context) => locator<HotelBloc>(),
          
//         ),
       
//       ],
//       child:MaterialApp(
//         debugShowCheckedModeBanner: false,
//         title: 'Hotel Booking App',
//         theme: ThemeData(primarySwatch: Colors.blue),
//         initialRoute: '/', // SplashScreen is the initial route
//         routes: {
//           '/': (context) => SplashScreen(),
//           '/admin_dashboard': (context) => AdminDashboard(), // Add AdminDashboard here
//           '/login': (context) => LoginPage(),
//           '/home': (context) => HomePage(),
//           '/addhotel': (context) => AddHotelPage(),
//           '/deletehotel': (context) => DeleteHotelPage(),
//           '/edithotel': (context) => EditHotelPage( ),
//           '/assignrole': (context) => AssignRolePage(),
//           'hotelDetails':(context)=>HotelDetailsPage(hotelId: '',),
//         },
//       ),
//     );  
//   }
// }
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hotel_booking_and_review_app/features/admin/domain/entities/admin_hotel.dart';
import 'package:hotel_booking_and_review_app/features/admin/presentation/bloc/admin_hotel_bloc.dart';
import 'package:hotel_booking_and_review_app/features/admin/presentation/pages/add_hotel_page.dart';
import 'package:hotel_booking_and_review_app/features/admin/presentation/pages/admin_dashboard.dart';
import 'package:hotel_booking_and_review_app/features/admin/presentation/pages/assign_role_page.dart';
import 'package:hotel_booking_and_review_app/features/admin/presentation/pages/delete_hotel_page.dart';
import 'package:hotel_booking_and_review_app/features/admin/presentation/pages/edit_hotel_page.dart';
import 'package:hotel_booking_and_review_app/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:hotel_booking_and_review_app/features/auth/presentation/pages/login_page.dart';
import 'package:hotel_booking_and_review_app/features/hotel/presentation/bloc/hotel_bloc.dart';
import 'package:hotel_booking_and_review_app/features/role/presentation/bloc/role_bloc.dart';
import 'package:hotel_booking_and_review_app/features/user/presentation/pages/Bookingpage.dart';
import 'package:hotel_booking_and_review_app/features/user/presentation/pages/homepage.dart';
import 'package:hotel_booking_and_review_app/features/user/presentation/pages/hotel_details.dart';
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
        BlocProvider<AdminHotelBloc>(
          create: (context) => locator<AdminHotelBloc>(),
        ),
        BlocProvider<HotelBloc>(
          create: (context) => locator<HotelBloc>(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Hotel Booking App',
        theme: ThemeData(primarySwatch: Colors.blue),
        initialRoute: '/', // SplashScreen is the initial route
        onGenerateRoute: (settings) {
          if (settings.name == '/hotelDetails') {
            final hotelId = settings.arguments as String;
            return MaterialPageRoute(
              builder: (context) {
                return HotelDetailsPage(hotelId: hotelId);
              },
            );
          }
          // Define other routes here
          switch (settings.name) {
            case '/':
              return MaterialPageRoute(builder: (context) => SplashScreen());
            case '/admin_dashboard':
              return MaterialPageRoute(builder: (context) => AdminDashboard());
            case '/login':
              return MaterialPageRoute(builder: (context) => LoginPage());
            case '/home':
              return MaterialPageRoute(builder: (context) => HomePage());
            case '/addhotel':
              return MaterialPageRoute(builder: (context) => AddHotelPage());
            case '/deletehotel':
              return MaterialPageRoute(builder: (context) => DeleteHotelPage());
            case '/edithotel':
              return MaterialPageRoute(builder: (context) => EditHotelPage());
            case '/assignrole':
              return MaterialPageRoute(builder: (context) => AssignRolePage());
            
            default:
              return null;
          }
        },
      ),
    );
  }
}