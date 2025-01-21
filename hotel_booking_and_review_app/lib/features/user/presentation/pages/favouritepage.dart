import 'dart:io';
import 'package:flutter/material.dart';

class FavoritesPage extends StatelessWidget {
  final List<Map<String, String>> favorites;

  // Constructor accepts the favorite hotels passed from HotelDetailsPage
  FavoritesPage({required this.favorites});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Favorites'),
        centerTitle: true,
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: CircleAvatar(
              backgroundImage: AssetImage('assets/images/verify_email.png'), // User profile picture
            ),
          ),
        ],
      ),
      body: Column(
        children: [
          // Search Bar
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              decoration: InputDecoration(
                hintText: 'Search',
                prefixIcon: Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide.none,
                ),
                filled: true,
                fillColor: Colors.grey[200],
              ),
            ),
          ),
          // List of Favorites
          Expanded(
            child: ListView.builder(
              itemCount: favorites.length,
              itemBuilder: (context, index) {
                final hotel = favorites[index];
                return Card(
                  margin: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
                  child: ListTile(
                    leading: ClipRRect(
                      borderRadius: BorderRadius.circular(8.0),
                      child: Image.file(
                        File(hotel['image']!),
                        width: 50,
                        height: 50,
                        fit: BoxFit.cover,
                      ),
                    ),
                    title: Text(hotel['name']!),
                    subtitle: Text(hotel['location']!),
                    trailing: IconButton(
                      icon: Icon(
                        Icons.favorite,
                        color: Colors.red,
                      ),
                      onPressed: () {
                        // Handle favorite/unfavorite action
                      },
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.explore), label: 'Explore'),
          BottomNavigationBarItem(icon: Icon(Icons.favorite_border), label: 'Saved'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'My account'),
        ],
        backgroundColor: Colors.white,
        elevation: 4,
        selectedItemColor: Color(0xFF1E3E62),
        unselectedItemColor: Colors.grey,
      ),
    );
  }
}