import 'package:flutter/material.dart';
import 'package:hotel_booking_and_review_app/features/auth/presentation/pages/profile_page.dart';
import 'package:hotel_booking_and_review_app/features/user/presentation/pages/homepage.dart';
import 'package:hotel_booking_and_review_app/features/user/presentation/pages/saving.dart';



 

class TripsPage extends StatefulWidget {
  @override
  _TripsPageState createState() => _TripsPageState();
}

class _TripsPageState extends State<TripsPage> {
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
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          title: Text('Trips' , style: TextStyle(color: Colors.white),),
          backgroundColor: Color(0xFF1E3E62),
          bottom: TabBar(
            indicator: BoxDecoration(
              border: Border.all(color: Colors.blue),
              borderRadius: BorderRadius.circular(25),
              color: Colors.white,
            ),
            labelColor: Colors.blue,
            unselectedLabelColor: Colors.black,
            tabs: [
              Tab(text: 'Active'),
              Tab(text: 'Past'),
              Tab(text: 'Cancelled'),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            _buildTabContent(
              imagePath: 'assets/images/Active.png', 
              title: "Where to next?",
              description: "You haven’t started any trips yet. When you’ve made a booking, it will appear here.",
            ),
            _buildTabContent(
              imagePath: 'assets/images/Past.png',
              title: "Revisit past trips",
              description: "Here you can refer to all past trips and get inspired for your next ones.",
            ),
            _buildTabContent(
              imagePath: 'assets/images/Cancel.png',
              title: "Sometimes plans change",
              description: "Here you can refer to all the trips you’ve cancelled. Maybe next time!",
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

  Widget _buildTabContent({required String imagePath, required String title, required String description}) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Image.asset(imagePath, width: 200, height: 200),
        SizedBox(height: 20),
        Text(title, style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Text(description, textAlign: TextAlign.center, style: TextStyle(fontSize: 16)),
        ),
      ],
    );
  }
}
