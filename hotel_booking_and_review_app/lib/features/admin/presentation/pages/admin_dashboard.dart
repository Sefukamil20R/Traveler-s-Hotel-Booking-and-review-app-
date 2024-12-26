import 'package:flutter/material.dart';
import 'package:hotel_booking_and_review_app/features/auth/presentation/pages/login_page.dart';

class AdminDashboard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(
          child: Text('Admin Dashboard'),
        ),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
      Navigator.pushNamed(context, '/home');
          },
        ),
        backgroundColor: Color(0xFF1E3E62),
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFF1E3E62), Color(0xFF4B79A1)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: GridView.count(
            crossAxisCount: 2,
            crossAxisSpacing: 16,
            mainAxisSpacing: 16,
            children: [
              AdminOptionCard(
                title: 'Add Hotel',
                icon: Icons.add,
                onTap: () {
      Navigator.pushNamed(context, '/addhotel');
                },
              ),
              AdminOptionCard(
                title: 'Edit Hotel',
                icon: Icons.edit,
                onTap: () {
      Navigator.pushNamed(context, '/edithotel');
                },
              ),
              AdminOptionCard(
                title: 'Delete Hotel',
                icon: Icons.delete,
                onTap: () {
      Navigator.pushNamed(context, '/deletehotel');
                },
              ),
              AdminOptionCard(
                title: 'Assign Role',
                icon: Icons.person_add,
                onTap: () {
              Navigator.pushNamed(context, '/assignrole');
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class AdminOptionCard extends StatelessWidget {
  final String title;
  final IconData icon;
  final VoidCallback onTap;

  const AdminOptionCard({
    required this.title,
    required this.icon,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Card(
        color: Colors.white,
        elevation: 6,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              icon,
              size: 48,
              color: Color(0xFF1E3E62),
            ),
            SizedBox(height: 16),
            Text(
              title,
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Color(0xFF1E3E62),
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
