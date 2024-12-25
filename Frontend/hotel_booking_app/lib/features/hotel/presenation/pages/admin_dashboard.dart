import 'package:flutter/material.dart';
import 'package:hotel_booking_app/features/admin/presentation/bloc/admin_hotel_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AdminDashboard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Admin Dashboard'),
        backgroundColor: Color(0xFF1E3E62),
      ),
      body: Padding(
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
                Navigator.pushNamed(context, '/addHotel');
              },
            ),
            AdminOptionCard(
              title: 'Edit Hotel',
              icon: Icons.edit,
              onTap: () {
                Navigator.pushNamed(context, '/editHotel');
              },
            ),
            AdminOptionCard(
              title: 'Delete Hotel',
              icon: Icons.delete,
              onTap: () {
                Navigator.pushNamed(context, '/deleteHotel');
              },
            ),
            AdminOptionCard(
              title: 'Assign Role',
              icon: Icons.person_add,
              onTap: () {
                Navigator.pushNamed(context, '/assignRole');
              },
            ),
          ],
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
        elevation: 4,
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
            ),
          ],
        ),
      ),
    );
  }
}
