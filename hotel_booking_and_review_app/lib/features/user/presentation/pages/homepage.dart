import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hotel_booking_and_review_app/features/auth/presentation/pages/login_page.dart';
import 'package:hotel_booking_and_review_app/features/auth/presentation/pages/profile_page.dart';
import 'package:hotel_booking_and_review_app/features/hotel/domain/entitiy/hotel_entitiy.dart';
import 'package:hotel_booking_and_review_app/features/hotel/presentation/bloc/hotel_bloc.dart';
import 'package:hotel_booking_and_review_app/features/hotel/presentation/bloc/hotel_event.dart';
import 'package:hotel_booking_and_review_app/features/hotel/presentation/bloc/hotel_state.dart';
import 'package:geolocator/geolocator.dart';
import 'package:hotel_booking_and_review_app/features/user/presentation/pages/Bookings.dart';
import 'package:hotel_booking_and_review_app/features/user/presentation/pages/saving.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with WidgetsBindingObserver {
  List<Hotel> allHotels = [];
  List<Hotel> filteredHotels = [];

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    _fetchInitialData();
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) {
      // Refetch data when the app resumes
      _fetchInitialData();
    }
  }

  void _fetchInitialData() {
    // Fetch Recommended Hotels
    context.read<HotelBloc>().add(FetchHotelsEvent());
    // Fetch Nearby Hotels
    _fetchNearbyHotels();
  }

  Future<void> _fetchNearbyHotels() async {
    try {
      Position currentPosition = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.high);
      context.read<HotelBloc>().add(FetchNearbyHotelsEvent(currentPosition));
    } catch (e) {
      print("Error getting location: $e");
    }
  }

  void _filterHotels(String query) {
    setState(() {
      filteredHotels = allHotels
          .where((hotel) => hotel.name.toLowerCase().contains(query.toLowerCase()))
          .toList();
    });
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
          MaterialPageRoute(builder: (context) => SavedPage()),
        );
        break;
      case 2:
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => TripsPage()),
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
      appBar: AppBar(
        automaticallyImplyLeading: false, // Remove the back icon
        backgroundColor: Color(0xFF1E3E62),
        elevation: 0,
        title: Row(
          children: [
            ClipOval(
              child: Image.asset('assets/images/logo.png', height: 40, width: 40, fit: BoxFit.cover), // Replace with your logo
            ),
            SizedBox(width: 8),
            Text('StaySphere', style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold)),
            Spacer(),
            IconButton(
              icon: Icon(Icons.login, color: Colors.white),
              onPressed: () {
                Navigator.pushNamed(context, '/login');
              },
            ),
          ],
        ),
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(60.0),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
            child: Container(
              height: 40,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
              ),
              child: TextField(
                onChanged: _filterHotels,
                decoration: InputDecoration(
                  hintText: 'Search',
                  border: InputBorder.none,
                  prefixIcon: Icon(Icons.search, color: Color(0xFF1E3E62)),
                ),
              ),
            ),
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0), // Add margin to all sides
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Recommended Hotels', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Color(0xFF1E3E62))),
            SizedBox(height: 8),
            BlocBuilder<HotelBloc, HotelState>(
              builder: (context, state) {
                if (state is HotelLoading) {
                  return Center(child: CircularProgressIndicator());
                } else if (state is HotelLoaded) {
                  allHotels = state.hotels;
                  filteredHotels = filteredHotels.isEmpty ? allHotels : filteredHotels;
                  if (filteredHotels.isEmpty) {
                    return Center(child: Text('No recommended hotels available.'));
                  }
                  return SizedBox(
                    height: 240, // Adjusted height for cards
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: filteredHotels.length,
                      itemBuilder: (context, index) {
                        final hotel = filteredHotels[index];
                        return GestureDetector(
                          onTap: () {
                            Navigator.pushNamed(
                              context,
                              '/hotelDetails',
                              arguments: hotel.id,
                            );
                          },
                          child: RecommendedHotelCard(
                            name: hotel.name,
                            location: hotel.location,
                            price: hotel.price.toString(),
                            imageUrl: hotel.gallery.isNotEmpty ? hotel.gallery[0] : '',
                            rating: hotel.rating,
                            onTap: () {
                              Navigator.pushNamed(
                                context,
                                '/hotelDetails',
                                arguments: hotel.id,
                              );
                            },
                          ),
                        );
                      },
                    ),
                  );
                } else if (state is HotelError) {
                  return Center(child: Text(state.message));
                } else {
                  return Center(child: Text('No data available.'));
                }
              },
            ),
            SizedBox(height: 16),
            Text('Nearby Hotels', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Color(0xFF1E3E62))),
            SizedBox(height: 8),
            Expanded(
              child: BlocBuilder<HotelBloc, HotelState>(
                builder: (context, state) {
                  if (state is HotelLoading) {
                    return Center(child: CircularProgressIndicator());
                  } else if (state is HotelLoaded) {
                    allHotels = state.hotels;
                    filteredHotels = filteredHotels.isEmpty ? allHotels : filteredHotels;
                    if (filteredHotels.isEmpty) {
                      return Center(child: Text('No nearby hotels available.'));
                    }
                    return ListView.builder(
                      itemCount: filteredHotels.length,
                      itemBuilder: (context, index) {
                        final hotel = filteredHotels[index];
                        return GestureDetector(
                          onTap: () {
                            Navigator.pushNamed(
                              context,
                              '/hotelDetails',
                              arguments: hotel.id,
                            );
                          },
                          child: NearbyHotelCard(
                            name: hotel.name,
                            location: hotel.location,
                            price: hotel.price.toString(),
                            imageUrl: hotel.gallery.isNotEmpty ? hotel.gallery[0] : '',
                            rating: hotel.rating,
                            onTap: () {
                              Navigator.pushNamed(
                                context,
                                '/hotelDetails',
                                arguments: hotel.id,
                              );
                            },
                          ),
                        );
                      },
                    );
                  } else if (state is HotelError) {
                    return Center(child: Text(state.message));
                  } else {
                    return Center(child: Text('No data available.'));
                  }
                },
              ),
            ),
          ],
        ),
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
          ),
        ],
        backgroundColor: Colors.white,
        elevation: 4,
        selectedItemColor: Color(0xFF1E3E62),
        unselectedItemColor: Colors.grey,
      ),
    );
  }
}

class RecommendedHotelCard extends StatelessWidget {
  final String name;
  final String location;
  final String price;
  final String imageUrl;
  final double rating;
  final VoidCallback onTap;

  const RecommendedHotelCard({
    required this.name,
    required this.location,
    required this.price,
    required this.imageUrl,
    required this.rating,
    required this.onTap,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        elevation: 5,
        child: Container(
          width: 180, // Width of the card
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Stack(
                children: [
                  Container(
                    height: 120,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      image: DecorationImage(
                        image: imageUrl.isNotEmpty
                            ? FileImage(File(imageUrl))
                            : AssetImage('assets/placeholder.jpg') as ImageProvider,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  Positioned(
                    top: 8,
                    right: 8,
                    child: CircleAvatar(
                      backgroundColor: Colors.white.withOpacity(0.6),
                      child: Icon(Icons.favorite, color: Colors.red),
                    ),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    Text(
                      '10% OFF',
                      style: TextStyle(fontWeight: FontWeight.bold, color: Colors.green),
                    ),
                    Spacer(),
                    Row(
                      children: [
                        Text(
                          rating.toString(),
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        Icon(Icons.star, size: 16, color: Colors.yellow),
                      ],
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: Text(
                  name,
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: Row(
                  children: [
                    Icon(Icons.location_on, size: 16, color: Colors.grey),
                    Text(
                      location,
                      style: TextStyle(color: Colors.grey),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: Text('\$$price/Day'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class NearbyHotelCard extends StatelessWidget {
  final String name;
  final String location;
  final String price;
  final String imageUrl;
  final double rating;
  final VoidCallback onTap;

  const NearbyHotelCard({
    required this.name,
    required this.location,
    required this.price,
    required this.imageUrl,
    required this.rating,
    required this.onTap,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        elevation: 5,
        child: Container(
          padding: const EdgeInsets.all(8),
          child: Row(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: Image.file(
                  File(imageUrl),
                  height: 100, // Increased height
                  width: MediaQuery.of(context).size.width * 0.40, // 55% width for image
                  fit: BoxFit.cover,
                ),
              ),
              SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '10% OFF',
                      style: TextStyle(fontWeight: FontWeight.bold, color: Colors.green),
                    ),
                    SizedBox(height: 4),
                    Text(name, style: TextStyle(fontWeight: FontWeight.bold)),
                    Row(
                      children: [
                        Icon(Icons.location_on, size: 16, color: Colors.grey),
                        Text(location, style: TextStyle(color: Colors.grey)),
                      ],
                    ),
                    SizedBox(height: 4),
                    Text('\$$price/Day'),
                    Row(
                      children: [
                        Text(
                          rating.toString(),
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        Icon(Icons.star, size: 16, color: Colors.yellow),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}