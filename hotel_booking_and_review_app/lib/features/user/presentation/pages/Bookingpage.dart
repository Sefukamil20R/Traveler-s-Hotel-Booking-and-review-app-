// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:hotel_booking_and_review_app/features/hotel/presentation/bloc/hotel_bloc.dart';
// import 'package:hotel_booking_and_review_app/features/hotel/presentation/bloc/hotel_event.dart';
// import 'package:hotel_booking_and_review_app/features/hotel/presentation/bloc/hotel_state.dart';
// import 'package:hotel_booking_and_review_app/features/user/presentation/pages/Bookingsummury.dart';

// class BookingPage extends StatefulWidget {
//   final String hotelId;

//   BookingPage({required this.hotelId});

//   @override
//   _BookingPageState createState() => _BookingPageState();
// }

// class _BookingPageState extends State<BookingPage> {
//   final _formKey = GlobalKey<FormState>();
//   final TextEditingController _usernameController = TextEditingController();
//   final TextEditingController _checkInController = TextEditingController();
//   final TextEditingController _checkOutController = TextEditingController();

//   @override
//   void initState() {
//     super.initState();
//     context.read<HotelBloc>().add(FetchHotelDetails(widget.hotelId));
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Booking'),
//         backgroundColor: Color(0xFF1E3E62),
//       ),
//       body: BlocBuilder<HotelBloc, HotelState>(
//         builder: (context, state) {
//           if (state is HotelLoading) {
//             return Center(child: CircularProgressIndicator());
//           } else if (state is HotelDetailLoaded) {
//             final hotel = state.hotel;
//             return Padding(
//               padding: const EdgeInsets.all(16.0),
//               child: Form(
//                 key: _formKey,
//                 child: ListView(
//                   children: [
//                     TextFormField(
//                       controller: _usernameController,
//                       decoration: InputDecoration(
//                         labelText: 'Username',
//                         border: OutlineInputBorder(),
//                       ),
//                       validator: (value) {
//                         if (value == null || value.isEmpty) {
//                           return 'Please enter your username';
//                         }
//                         return null;
//                       },
//                     ),
//                     SizedBox(height: 16),
//                     TextFormField(
//                       controller: _checkInController,
//                       decoration: InputDecoration(
//                         labelText: 'Check-In Date',
//                         border: OutlineInputBorder(),
//                       ),
//                       validator: (value) {
//                         if (value == null || value.isEmpty) {
//                           return 'Please enter check-in date';
//                         }
//                         return null;
//                       },
//                       onTap: () async {
//                         DateTime? date = await showDatePicker(
//                           context: context,
//                           initialDate: DateTime.now(),
//                           firstDate: DateTime.now(),
//                           lastDate: DateTime(2100),
//                         );
//                         if (date != null) {
//                           _checkInController.text = date.toLocal().toString().split(' ')[0];
//                         }
//                       },
//                     ),
//                     SizedBox(height: 16),
//                     TextFormField(
//                       controller: _checkOutController,
//                       decoration: InputDecoration(
//                         labelText: 'Check-Out Date',
//                         border: OutlineInputBorder(),
//                       ),
//                       validator: (value) {
//                         if (value == null || value.isEmpty) {
//                           return 'Please enter check-out date';
//                         }
//                         return null;
//                       },
//                       onTap: () async {
//                         DateTime? date = await showDatePicker(
//                           context: context,
//                           initialDate: DateTime.now().add(Duration(days: 1)),
//                           firstDate: DateTime.now(),
//                           lastDate: DateTime(2100),
//                         );
//                         if (date != null) {
//                           _checkOutController.text = date.toLocal().toString().split(' ')[0];
//                         }
//                       },
//                     ),
//                     SizedBox(height: 16),
//                     ElevatedButton(
//                       onPressed: () {
//                         if (_formKey.currentState!.validate()) {
//                           final checkInDate = DateTime.parse(_checkInController.text);
//                           final checkOutDate = DateTime.parse(_checkOutController.text);
//                           final totalDays = checkOutDate.difference(checkInDate).inDays;
//                           final totalPrice = totalDays * hotel.price;

//                           Navigator.push(
//                             context,
//                             MaterialPageRoute(
//                               builder: (context) => BookingSummaryPage(
//                                 username: _usernameController.text,
//                                 checkInDate: _checkInController.text,
//                                 checkOutDate: _checkOutController.text,
//                                 totalPrice: totalPrice,
//                                 hotel: hotel,
//                               ),
//                             ),
//                           );
//                         }
//                       },
//                       style: ElevatedButton.styleFrom(
//                         backgroundColor: Color(0xFF1E3E62),
//                       ),
//                       child: Text('Proceed to Summary'),
//                     ),
//                   ],
//                 ),
//               ),
//             );
//           } else if (state is HotelError) {
//             return Center(child: Text(state.message));
//           } else {
//             return Center(child: Text('No data available.'));
//           }
//         },
//       ),
//     );
//   }
// }