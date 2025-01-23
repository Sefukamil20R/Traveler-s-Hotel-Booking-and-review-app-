import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hotel_booking_and_review_app/features/admin/domain/entities/admin_hotel.dart';
import 'package:hotel_booking_and_review_app/features/admin/presentation/bloc/admin_hotel_bloc.dart';
import 'package:hotel_booking_and_review_app/features/admin/presentation/bloc/admin_hotel_event.dart';
import 'package:hotel_booking_and_review_app/features/admin/presentation/bloc/admin_hotel_state.dart';
import 'package:hotel_booking_and_review_app/features/admin/presentation/pages/HotelEditFormPage.dart';

class EditHotelPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Edit Hotel", style: TextStyle(color: Colors.white)),
        backgroundColor:  Color(0xFF1E3E62),
      ),
      body: BlocBuilder<AdminHotelBloc, AdminHotelState>(
        builder: (context, state) {
          if (state is AdminHotelLoading) {
            return Center(child: CircularProgressIndicator());
          } else if (state is AdminHotelsLoaded) {
            if (state.hotels.isEmpty) {
              return Center(child: Text("No hotels available to edit."));
            }
            return ListView.builder(
              itemCount: state.hotels.length,
              itemBuilder: (context, index) {
                final hotel = state.hotels[index];
                return Card(
                  margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  child: ListTile(
                    title: Text(hotel.name , style: TextStyle(color: Color(0xFF1E3E62))),
                    subtitle: Text(hotel.location),
                    onTap: () {
                      print('Selected Hotel: ${hotel.toString()}');
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => HotelEditFormPage(hotel: hotel),
                        ),
                      );
                    },
                  ),
                );
              },
            );
          } else if (state is AdminHotelError) {
            return Center(child: Text(state.message));
          }
          return SizedBox.shrink();
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          context.read<AdminHotelBloc>().add(FetchHotelsEvent());
        },
        child: Icon(Icons.refresh),
      ),
    );
  }
}
  
  

