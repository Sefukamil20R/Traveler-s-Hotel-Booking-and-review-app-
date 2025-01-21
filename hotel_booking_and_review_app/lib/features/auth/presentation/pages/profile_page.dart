import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hotel_booking_and_review_app/features/auth/domain/entitities/auth_entitiy.dart';
import 'package:hotel_booking_and_review_app/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:hotel_booking_and_review_app/features/auth/presentation/bloc/auth_state.dart';
import 'package:hotel_booking_and_review_app/features/auth/presentation/bloc/auth_event.dart';
import 'package:hotel_booking_and_review_app/features/auth/presentation/pages/login_page.dart';
import 'package:hotel_booking_and_review_app/features/user/presentation/pages/saving.dart';

class ProfilePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Trigger the event to fetch the user profile
    context.read<AuthBloc>().add(FetchUserProfileEvent());

    return Scaffold(
      appBar: AppBar(
        title: Text('Profile' , style: TextStyle(color: Colors.white),),
        backgroundColor: Color(0xFF1E3E62),
      ),
      body: BlocListener<AuthBloc, AuthState>(
        listener: (context, state) {
          if (state is SignedOutState) {
            Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(builder: (context) => LoginPage()),
              (route) => false,
            );
          }
        },
        child: BlocBuilder<AuthBloc, AuthState>(
          builder: (context, state) {
            if (state is AuthLoadingState) {
              return Center(child: CircularProgressIndicator());
            } else if (state is AuthErrorState) {
              return Center(child: Text(state.errorMessage));
            } else if (state is UserProfileFetchedState) {
              return _buildProfile(context, state.user);
            } else {
              return Center(child: Text('Unknown state'));
            }
          },
        ),
      ),
    );
  }

  Widget _buildProfile(BuildContext context, UserEntity user) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(height: 16),
            CircleAvatar(
              radius: 50,
              backgroundImage: AssetImage('assets/images/pro.png'), // Replace with user's profile image if available
            ),
            SizedBox(height: 16),
            Text(
              user.username,
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),
            Text(
              user.email,
              style: TextStyle(fontSize: 16, color: Colors.grey),
            ),
            SizedBox(height: 16),
            Divider(),
            ListTile(
              leading: Icon(Icons.person),
              title: Text('Account Information'),
              onTap: () {
                // Navigate to account information page
              },
            ),
            ListTile(
              leading: Icon(Icons.favorite_outline_sharp),
              title: Text('Your Favorite'),
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => SavedPage()));
              },
            ),
            ListTile(
              leading: Icon(Icons.history),
              title: Text('Booking History'),
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => SavedPage()));
              },
            ),
            ListTile(
              leading: Icon(Icons.logout),
              title: Text('Logout'),
              onTap: () {
                // Trigger logout event
                context.read<AuthBloc>().add(SignOutEvent());
              },
            ),
          ],
        ),
      ),
    );
  }
}