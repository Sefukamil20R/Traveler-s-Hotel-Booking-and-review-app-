import 'package:flutter/material.dart';
import 'package:hotel_booking_app/features/auth/presenation/pages/login_page.dart';
import 'package:hotel_booking_app/features/admin/presentation/bloc/admin_hotel_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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
            // Ensure navigation happens after the current frame is done
            WidgetsBinding.instance.addPostFrameCallback((_) {
              // Close the current screen and navigate to LoginPage
              Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(builder: (context) => LoginPage()),
                (route) => false, // Remove all previous routes
              );
            });
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
                  // Implement the onTap action
                },
              ),
              AdminOptionCard(
                title: 'Edit Hotel',
                icon: Icons.edit,
                onTap: () {
                  // Implement the onTap action
                },
              ),
              AdminOptionCard(
                title: 'Delete Hotel',
                icon: Icons.delete,
                onTap: () {
                  // Implement the onTap action
                },
              ),
              AdminOptionCard(
                title: 'Assign Role',
                icon: Icons.person_add,
                onTap: () {
                  // Implement the onTap action
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
