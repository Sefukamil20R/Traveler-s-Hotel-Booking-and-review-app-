// import 'dart:io';

// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:hotel_booking_and_review_app/features/hotel/presentation/bloc/hotel_bloc.dart';
// import 'package:hotel_booking_and_review_app/features/hotel/presentation/bloc/hotel_event.dart';
// import 'package:hotel_booking_and_review_app/features/hotel/presentation/bloc/hotel_state.dart';
// import 'package:hotel_booking_and_review_app/features/auth/presentation/bloc/auth_bloc.dart';
// import 'package:hotel_booking_and_review_app/features/auth/presentation/bloc/auth_state.dart';

// class HotelDetailsPage extends StatefulWidget {
//   final String hotelId;

//   HotelDetailsPage({required this.hotelId});

//   @override
//   _HotelDetailsPageState createState() => _HotelDetailsPageState();
// }

// class _HotelDetailsPageState extends State<HotelDetailsPage> {
//   bool isAboutSelected = true;
  
   
//   @override
//   void initState() {
//     super.initState();
//     context.read<HotelBloc>().add(FetchHotelDetails(widget.hotelId));
//   }

//   void _handleBookNow() {
//     final authState = context.read<AuthBloc>().state;
//     if (authState is SignedInState) {
//       // Navigate to the booking page
//       Navigator.pushNamed(context, '/booking', arguments: widget.hotelId);
//     } else {
//       // Show login dialog
//       _showLoginDialog();
//     }
//   }

//   void _handleFavorite() {
//     final authState = context.read<AuthBloc>().state;
//     if (authState is SignedInState) {
//       // Handle adding to favorite
//     } else {
//       // Show login dialog
//       _showLoginDialog();
//     }
//   }

//   void _showLoginDialog() {
//     showDialog(
//       context: context,
//       builder: (context) => AlertDialog(
//         title: Text('Login Required'),
//         content: Text('You need to be logged in to perform this action.'),
//         actions: [
//           TextButton(
//             onPressed: () => Navigator.pop(context),
//             child: Text('Cancel'),
//           ),
//           TextButton(
//             onPressed: () {
//               Navigator.pop(context);
//               Navigator.pushNamed(context, '/login');
//             },
//             child: Text('Login'),
//           ),
//         ],
//       ),
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: BlocBuilder<HotelBloc, HotelState>(
//         builder: (context, state) {
//           if (state is HotelLoading) {
//             return Center(child: CircularProgressIndicator());
//           } else if (state is HotelDetailLoaded) {
//             final hotel = state.hotel;
//             return Stack(
//               children: [
//                 SingleChildScrollView(
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       Stack(
//                         children: [
//                           Image.file(
//                             File(hotel.gallery[0]),
//                             width: double.infinity,
//                             height: 250,
//                             fit: BoxFit.cover,
//                           ),
//                           Positioned(
//                             top: 16,
//                             left: 16,
//                             child: CircleAvatar(
//                               backgroundColor: Colors.grey.withOpacity(0.6),
//                               child: IconButton(
//                                 icon: Icon(Icons.arrow_back, color: Colors.white),
//                                 onPressed: () {
//                                   Navigator.pop(context);
//                                 },
//                               ),
//                             ),
//                           ),
//                           Positioned(
//                             top: 16,
//                             right: 16,
//                             child: CircleAvatar(
//                               backgroundColor: Colors.grey.withOpacity(0.6),
//                               child: IconButton(
//                                 icon: Icon(Icons.favorite_border, color: Colors.red),
//                                 onPressed: _handleFavorite,
//                               ),
//                             ),
//                           ),
//                         ],
//                       ),
//                       Padding(
//                         padding: const EdgeInsets.all(16.0),
//                         child: Row(
//                           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                           children: [
//                             Text('10% OFF', style: TextStyle(fontWeight: FontWeight.bold, color: Colors.green)),
//                             Row(
//                               children: [
//                                 Text('4.6', style: TextStyle(fontWeight: FontWeight.bold)),
//                                 Icon(Icons.star, size: 16, color: Colors.yellow),
//                                 Text('(107 reviews)', style: TextStyle(color: Colors.grey)),
//                               ],
//                             ),
//                           ],
//                         ),
//                       ),
//                       Padding(
//                         padding: const EdgeInsets.symmetric(horizontal: 16.0),
//                         child: Row(
//                           children: [
//                             TextButton(
//                               onPressed: () {
//                                 setState(() {
//                                   isAboutSelected = true;
//                                 });
//                               },
//                               child: Text('About', style: TextStyle(color: isAboutSelected ? Color(0xFF1E3E62) : Colors.grey)),
//                             ),
//                             TextButton(
//                               onPressed: () {
//                                 setState(() {
//                                   isAboutSelected = false;
//                                 });
//                               },
//                               child: Text('Gallery', style: TextStyle(color: !isAboutSelected ? Color(0xFF1E3E62) : Colors.grey)),
//                             ),
//                           ],
//                         ),
//                       ),
//                       Padding(
//                         padding: const EdgeInsets.symmetric(horizontal: 16.0),
//                         child: isAboutSelected
//                             ? Column(
//                                 crossAxisAlignment: CrossAxisAlignment.start,
//                                 children: [
//                                   Text('Amenities', style: TextStyle(fontWeight: FontWeight.bold)),
//                                   GridView.builder(
//                                     shrinkWrap: true,
//                                     physics: NeverScrollableScrollPhysics(),
//                                     gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
//                                       crossAxisCount: 3,
//                                       childAspectRatio: 3,
//                                     ),
//                                     itemCount: hotel.amenities.length,
//                                     itemBuilder: (context, index) {
//                                       return Text(hotel.amenities[index]);
//                                     },
//                                   ),
//                                   SizedBox(height: 16),
//                                   Text('Description', style: TextStyle(fontWeight: FontWeight.bold)),
//                                   Text(hotel.description),
//                                 ],
//                               )
//                             : GridView.builder(
//                                 shrinkWrap: true,
//                                 physics: NeverScrollableScrollPhysics(),
//                                 gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
//                                   crossAxisCount: 3,
//                                   childAspectRatio: 1,
//                                   crossAxisSpacing: 8,
//                                   mainAxisSpacing: 8,
//                                 ),
//                                 itemCount: hotel.gallery.length - 1,
//                                 itemBuilder: (context, index) {
//                                   return ClipRRect(
//                                     borderRadius: BorderRadius.circular(12),
//                                     child: Image.file(
//                                       File(hotel.gallery[index + 1]),
//                                       fit: BoxFit.cover,
//                                     ),
//                                   );
//                                 },
//                               ),
//                       ),
//                       SizedBox(height: 80), // Add space for the bottom bar
//                     ],
//                   ),
//                 ),
//                 Positioned(
//                   bottom: 0,
//                   left: 0,
//                   right: 0,
//                   child: Container(
//                     color: Colors.white,
//                     padding: const EdgeInsets.all(16.0),
//                     child: Row(
//                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                       children: [
//                         Column(
//                           crossAxisAlignment: CrossAxisAlignment.start,
//                           children: [
//                             Text('Total Price', style: TextStyle(color: Colors.grey)),
//                             Text('\$${hotel.price}/Day', style: TextStyle(fontWeight: FontWeight.bold)),
//                           ],
//                         ),
//                         ElevatedButton(
//                           onPressed: _handleBookNow,
//                           style: ElevatedButton.styleFrom(
//                             backgroundColor: Color(0xFF1E3E62),
//                           ),
//                           child: Text('Book Now'),
//                         ),
//                       ],
//                     ),
//                   ),
//                 ),
//               ],
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
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hotel_booking_and_review_app/features/hotel/presentation/bloc/hotel_bloc.dart';
import 'package:hotel_booking_and_review_app/features/hotel/presentation/bloc/hotel_event.dart';
import 'package:hotel_booking_and_review_app/features/hotel/presentation/bloc/hotel_state.dart';
import 'package:hotel_booking_and_review_app/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:hotel_booking_and_review_app/features/auth/presentation/bloc/auth_state.dart';
import 'package:hotel_booking_and_review_app/features/user/presentation/pages/Bookingpage.dart';

class HotelDetailsPage extends StatefulWidget {
  final String hotelId;

  HotelDetailsPage({required this.hotelId});

  @override
  _HotelDetailsPageState createState() => _HotelDetailsPageState();
}

class _HotelDetailsPageState extends State<HotelDetailsPage> {
  bool isAboutSelected = true;

  @override
  void initState() {
    super.initState();
    context.read<HotelBloc>().add(FetchHotelDetails(widget.hotelId));
  }

  void _handleBookNow() {
    final authState = context.read<AuthBloc>().state;
    if (authState is SignedInState) {
      // Navigate to the booking page
Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => BookingPage(hotelId: widget.hotelId),
        ),
      );    } else {
      // Show login dialog
      _showLoginDialog();
    }
  }

  void _handleFavorite() {
    final authState = context.read<AuthBloc>().state;
    if (authState is SignedInState) {
      // Handle adding to favorite
    } else {
      // Show login dialog
      _showLoginDialog();
    }
  }

  void _showLoginDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Login Required'),
        content: Text('You need to be logged in to perform this action.'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              Navigator.pushNamed(context, '/login');
            },
            child: Text('Login'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<HotelBloc, HotelState>(
        builder: (context, state) {
          if (state is HotelLoading) {
            return Center(child: CircularProgressIndicator());
          } else if (state is HotelDetailLoaded) {
            final hotel = state.hotel;
            return Stack(
              children: [
                SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Stack(
                        children: [
                          Image.file(
                            File(hotel.gallery[0]),
                            width: double.infinity,
                            height: 250,
                            fit: BoxFit.cover,
                          ),
                          Positioned(
                            top: 16,
                            left: 16,
                            child: CircleAvatar(
                              backgroundColor: Colors.grey.withOpacity(0.6),
                              child: IconButton(
                                icon: Icon(Icons.arrow_back, color: Colors.white),
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                              ),
                            ),
                          ),
                          Positioned(
                            top: 16,
                            right: 16,
                            child: CircleAvatar(
                              backgroundColor: Colors.grey.withOpacity(0.6),
                              child: IconButton(
                                icon: Icon(Icons.favorite_border, color: Colors.red),
                                onPressed: _handleFavorite,
                              ),
                            ),
                          ),
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text('10% OFF', style: TextStyle(fontWeight: FontWeight.bold, color: Colors.green)),
                            Row(
                              children: [
                                Text('4.6', style: TextStyle(fontWeight: FontWeight.bold)),
                                Icon(Icons.star, size: 16, color: Colors.yellow),
                                Text('(107 reviews)', style: TextStyle(color: Colors.grey)),
                              ],
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16.0),
                        child: Row(
                          children: [
                            TextButton(
                              onPressed: () {
                                setState(() {
                                  isAboutSelected = true;
                                });
                              },
                              child: Text('About', style: TextStyle(color: isAboutSelected ? Color(0xFF1E3E62) : Colors.grey)),
                            ),
                            TextButton(
                              onPressed: () {
                                setState(() {
                                  isAboutSelected = false;
                                });
                              },
                              child: Text('Gallery', style: TextStyle(color: !isAboutSelected ? Color(0xFF1E3E62) : Colors.grey)),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16.0),
                        child: isAboutSelected
                            ? Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text('Amenities', style: TextStyle(fontWeight: FontWeight.bold)),
                                  GridView.builder(
                                    shrinkWrap: true,
                                    physics: NeverScrollableScrollPhysics(),
                                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                                      crossAxisCount: 3,
                                      childAspectRatio: 3,
                                    ),
                                    itemCount: hotel.amenities.length,
                                    itemBuilder: (context, index) {
                                      return Text(hotel.amenities[index]);
                                    },
                                  ),
                                  SizedBox(height: 16),
                                  Text('Description', style: TextStyle(fontWeight: FontWeight.bold)),
                                  Text(hotel.description),
                                ],
                              )
                            : GridView.builder(
                                shrinkWrap: true,
                                physics: NeverScrollableScrollPhysics(),
                                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 3,
                                  childAspectRatio: 1,
                                  crossAxisSpacing: 8,
                                  mainAxisSpacing: 8,
                                ),
                                itemCount: hotel.gallery.length - 1,
                                itemBuilder: (context, index) {
                                  return ClipRRect(
                                    borderRadius: BorderRadius.circular(12),
                                    child: Image.file(
                                      File(hotel.gallery[index + 1]),
                                      fit: BoxFit.cover,
                                    ),
                                  );
                                },
                              ),
                      ),
                      SizedBox(height: 80), // Add space for the bottom bar
                    ],
                  ),
                ),
                Positioned(
                  bottom: 0,
                  left: 0,
                  right: 0,
                  child: Container(
                    color: Colors.white,
                    padding: const EdgeInsets.all(16.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Total Price', style: TextStyle(color: Colors.grey)),
                            Text('\$${hotel.price}/Day', style: TextStyle(fontWeight: FontWeight.bold)),
                          ],
                        ),
                        ElevatedButton(
                          onPressed: _handleBookNow,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Color(0xFF1E3E62),
                          ),
                          child: Text('Book Now'),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            );
          } else if (state is HotelError) {
            return Center(child: Text(state.message));
          } else {
            return Center(child: Text('No data available.'));
          }
        },
      ),
    );
  }
}