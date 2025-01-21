import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hotel_booking_and_review_app/features/auth/presentation/pages/login_page.dart';
import 'package:hotel_booking_and_review_app/features/auth/presentation/pages/profile_page.dart';
import 'package:hotel_booking_and_review_app/features/hotel/domain/entitiy/hotel_entitiy.dart';
import 'package:hotel_booking_and_review_app/features/hotel/presentation/bloc/hotel_bloc.dart';
import 'package:hotel_booking_and_review_app/features/hotel/presentation/bloc/hotel_event.dart';
import 'package:hotel_booking_and_review_app/features/hotel/presentation/bloc/hotel_state.dart';
import 'package:hotel_booking_and_review_app/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:hotel_booking_and_review_app/features/auth/presentation/bloc/auth_state.dart';
import 'package:hotel_booking_and_review_app/features/user/presentation/pages/Bookings.dart';
import 'package:hotel_booking_and_review_app/features/user/presentation/pages/Bookingsummury.dart';
import 'package:hotel_booking_and_review_app/features/user/presentation/pages/favouritepage.dart';
import 'package:hotel_booking_and_review_app/features/user/presentation/pages/homepage.dart';

class HotelDetailsPage extends StatefulWidget {
  final String hotelId;

  HotelDetailsPage({required this.hotelId});

  @override
  _HotelDetailsPageState createState() => _HotelDetailsPageState();
}

class _HotelDetailsPageState extends State<HotelDetailsPage> {
  bool isAboutSelected = true;

  // Add a list to store favorite hotels
  List<Map<String, String>> favoriteHotels = [];

  DateTime? _checkInDate;
  DateTime? _checkOutDate;
  int _numGuests = 1;
  int _numRooms = 1;
  int _numAdults = 2;
  int _numChildren = 0;

  Hotel? _hotel;

  @override
  void initState() {
    super.initState();
    context.read<HotelBloc>().add(FetchHotelDetails(widget.hotelId));
  }

  Future<void> _selectDate(BuildContext context, bool isCheckIn) async {
    DateTime initialDate = isCheckIn
        ? (_checkInDate ?? DateTime.now())
        : (_checkOutDate ?? DateTime.now().add(Duration(days: 1)));

    DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: initialDate,
      firstDate: DateTime.now(),
      lastDate: DateTime(2101),
    );

    if (pickedDate != null) {
      setState(() {
        if (isCheckIn) {
          _checkInDate = pickedDate;
          if (_checkOutDate != null && _checkOutDate!.isBefore(_checkInDate!)) {
            _checkOutDate = _checkInDate!.add(Duration(days: 1));
          }
        } else {
          _checkOutDate = pickedDate;
          if (_checkInDate != null && _checkOutDate!.isBefore(_checkInDate!)) {
            _checkInDate = _checkOutDate!.subtract(Duration(days: 1));
          }
        }
      });
    }
  }

  void _showRoomGuestSelection() {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return RoomGuestSelectionScreen(
          initialRooms: _numRooms,
          initialAdults: _numAdults,
          initialChildren: _numChildren,
          onApply: (rooms, adults, children) {
            setState(() {
              _numRooms = rooms;
              _numAdults = adults;
              _numChildren = children;
              _numGuests = adults + children;
            });
            Navigator.pop(context);
          },
        );
      },
    );
  }

  void _handleBookNow() {
    final authState = context.read<AuthBloc>().state;
    if (authState is SignedInState) {
      if (_hotel != null) {
        // Navigate to the booking summary page
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => BookingSummaryPage(
              hotel: _hotel!,
              checkInDate: _checkInDate,
              checkOutDate: _checkOutDate,
              numRooms: _numRooms,
              numAdults: _numAdults,
              numChildren: _numChildren,
            ),
          ),
        );
      }
    } else {
      // Show login dialog
      _showLoginDialog();
    }
  }

  void _handleFavorite(Map<String, String> hotel) {
    final authState = context.read<AuthBloc>().state;
    if (authState is SignedInState) {
      // Add hotel to the favorites list
      setState(() {
        favoriteHotels.add(hotel);
      });
      // Show a popup indicating the hotel was added to favorites
      _showFavoriteAddedDialog();
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

  void _showFavoriteAddedDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Added to Favorites'),
        content: Text('This hotel has been added to your favorites list.'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text('OK'),
          ),
        ],
      ),
    );
  }

  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });

    switch (index) {
      case 0:
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => HomePage()),
        );
        break;
      case 1:
       Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => FavoritesPage(favorites: favoriteHotels), // Pass the favoriteHotels list here
          ),
        );
        break;
      case 2:
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => TripsPage(), // Pass the favoriteHotels list here
          ),
        );
        break;
      case 3:
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => ProfilePage()),
        );
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<HotelBloc, HotelState>(
        builder: (context, state) {
          if (state is HotelLoading) {
            return Center(child: CircularProgressIndicator());
          } else if (state is HotelDetailLoaded) {
            _hotel = state.hotel;
            return Stack(
              children: [
                SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Stack(
                        children: [
                          Image.file(
                            File(_hotel!.gallery[0]),
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
                                icon: Icon(Icons.favorite, color: Colors.red),
                                onPressed: () => _handleFavorite({
                                  'name': _hotel!.name,
                                  'location': _hotel!.location,
                                  'image': _hotel!.gallery[0],
                                }), // Pass the hotel data when favorite is clicked
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
                              child: Text('About', style: TextStyle(color: isAboutSelected ? Color(0xFF002B5C) : Colors.grey)),
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
                                    itemCount: _hotel!.amenities.length,
                                    itemBuilder: (context, index) {
                                      return Text(_hotel!.amenities[index], style: TextStyle(color: Color(0xFF002B5C)));
                                    },
                                  ),
                                  SizedBox(height: 16),
                                  Text('Description', style: TextStyle(fontWeight: FontWeight.bold )),
                                  Text(_hotel!.description , style: TextStyle(color: Color(0xFF2C3E50)),),
                                  SizedBox(height: 16),

                                  // Check-in and Check-out Section
                                  Text(
                                    'Check-in & Check-out',
                                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                                  ),
                                  SizedBox(height: 8),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      GestureDetector(
                                        onTap: () => _selectDate(context, true),
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Text('Check-in'),
                                            SizedBox(height: 4),
                                            Container(
                                              padding: EdgeInsets.all(8),
                                              decoration: BoxDecoration(
                                                border: Border.all(color: Colors.grey),
                                                borderRadius: BorderRadius.circular(8),
                                              ),
                                              child: Text(
                                                _checkInDate != null
                                                    ? '${_checkInDate!.day}/${_checkInDate!.month}/${_checkInDate!.year}'
                                                    : 'Select Date',
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      GestureDetector(
                                        onTap: () => _selectDate(context, false),
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Text('Check-out'),
                                            SizedBox(height: 4),
                                            Container(
                                              padding: EdgeInsets.all(8),
                                              decoration: BoxDecoration(
                                                border: Border.all(color: Colors.grey),
                                                borderRadius: BorderRadius.circular(8),
                                              ),
                                              child: Text(
                                                _checkOutDate != null
                                                    ? '${_checkOutDate!.day}/${_checkOutDate!.month}/${_checkOutDate!.year}'
                                                    : 'Select Date',
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(height: 16),

                                  // Rooms and Guests Section
                                  Text(
                                    'Rooms & Guests',
                                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                                  ),
                                  SizedBox(height: 8),
                                  GestureDetector(
                                    onTap: _showRoomGuestSelection,
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text('Rooms & Guests'),
                                        SizedBox(height: 4),
                                        Container(
                                          padding: EdgeInsets.all(8),
                                          decoration: BoxDecoration(
                                            border: Border.all(color: Colors.grey),
                                            borderRadius: BorderRadius.circular(8),
                                          ),
                                          child: Text(
                                            '$_numRooms Rooms, $_numAdults Adults, $_numChildren Children',
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
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
                                itemCount: _hotel!.gallery.length - 1,
                                itemBuilder: (context, index) {
                                  return ClipRRect(
                                    borderRadius: BorderRadius.circular(12),
                                    child: Image.file(
                                      File(_hotel!.gallery[index + 1]),
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
                            Text('\$${_hotel!.price}/Day', style: TextStyle(fontWeight: FontWeight.bold)),
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
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex, // To keep track of the current selected tab
        onTap: _onItemTapped,
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.favorite_border),
            label: 'Saved',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.business_center),
            label: 'Bookings',
          ),
          
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'My account',
          )
        ],
        backgroundColor: Colors.white,
        elevation: 4,
        selectedItemColor: Color(0xFF1E3E62),
        unselectedItemColor: Colors.grey,
      ),
    );
  }
}

class RoomGuestSelectionScreen extends StatefulWidget {
  final int initialRooms;
  final int initialAdults;
  final int initialChildren;
  final Function(int rooms, int adults, int children) onApply;

  RoomGuestSelectionScreen({
    required this.initialRooms,
    required this.initialAdults,
    required this.initialChildren,
    required this.onApply,
  });

  @override
  _RoomGuestSelectionScreenState createState() => _RoomGuestSelectionScreenState();
}

class _RoomGuestSelectionScreenState extends State<RoomGuestSelectionScreen> {
  int rooms = 1;
  int adults = 2;
  int children = 0;

  @override
  void initState() {
    super.initState();
    rooms = widget.initialRooms;
    adults = widget.initialAdults;
    children = widget.initialChildren;
  }

  void incrementCounter(String type) {
    setState(() {
      if (type == "rooms") {
        rooms++;
      } else if (type == "adults") {
        adults++;
      } else if (type == "children") {
        children++;
      }
    });
  }

  void decrementCounter(String type) {
    setState(() {
      if (type == "rooms" && rooms > 1) {
        rooms--;
      } else if (type == "adults" && adults > 1) {
        adults--;
      } else if (type == "children" && children > 0) {
        children--;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Select rooms and guests")),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            buildCounterRow("Rooms", rooms, "rooms"),
            buildCounterRow("Adults", adults, "adults"),
            buildCounterRow("Children", children, "children"),
            SizedBox(height: 20),
            Text(
              "Ages 0 - 17",
              style: TextStyle(color: Colors.grey),
            ),
            Spacer(),
            ElevatedButton(
              onPressed: () {
                widget.onApply(rooms, adults, children);
              },
              style: ElevatedButton.styleFrom(
                minimumSize: Size(double.infinity, 50),
              ),
              child: Text("Apply"),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildCounterRow(String title, int count, String type) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 15.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(title, style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          Row(
            children: [
              IconButton(
                onPressed: () => decrementCounter(type),
                icon: Icon(Icons.remove),
              ),
              Text(count.toString(), style: TextStyle(fontSize: 18)),
              IconButton(
                onPressed: () => incrementCounter(type),
                icon: Icon(Icons.add),
              ),
            ],
          ),
        ],
      ),
    );
  }
}