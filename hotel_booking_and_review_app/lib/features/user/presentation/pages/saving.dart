import 'package:flutter/material.dart';
import 'package:hotel_booking_and_review_app/features/auth/presentation/pages/profile_page.dart';
import 'package:hotel_booking_and_review_app/features/user/presentation/pages/Bookings.dart';
import 'package:hotel_booking_and_review_app/features/user/presentation/pages/homepage.dart';



class SavedPage extends StatefulWidget {
  @override
  _SavedPageState createState() => _SavedPageState();
}

class _SavedPageState extends State<SavedPage> {
  
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
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: Text("Saved" , style: TextStyle(color: Colors.white),),
          
          backgroundColor: Color(0xFF1E3E62),
          actions: [
            IconButton(
              icon: Icon(Icons.help_outline),
              color: Colors.white,
              onPressed: () {},
            ),
            IconButton(
              icon: Icon(Icons.add),
              color: Colors.white,
              onPressed: () {},
            ),
          ],
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Center(
              child: Column(
                children: [
                  Image.asset(
                    'assets/images/fav.png',  // Replace with your own asset image
                    height: 150,
                  ),
                  const SizedBox(height: 20),
                  Text(
                    "Save what you like for later",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 10),
                  Text(
                    "Create lists of your favourite properties\n"
                    "to help you share, compare and book.",
                    style: TextStyle(fontSize: 16, color: Colors.black54),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.push(context, MaterialPageRoute(builder: (context) => HomePage()));
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Color(0xFF1E3E62),
                      padding:
                          EdgeInsets.symmetric(horizontal: 40, vertical: 15),
                    ),
                    child: Text(
                      "Start your search",
                      style: TextStyle(fontSize: 18, color: Colors.white),
                    ),
                  ),
                ],
              ),
            ),
          ],
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
      ),
    );
  }
}
