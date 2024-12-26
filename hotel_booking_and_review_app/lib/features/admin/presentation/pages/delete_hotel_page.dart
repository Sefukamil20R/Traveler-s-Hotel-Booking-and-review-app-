import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hotel_booking_and_review_app/features/admin/domain/entities/admin_hotel.dart';
import 'package:hotel_booking_and_review_app/features/admin/presentation/bloc/admin_hotel_bloc.dart';
import 'package:hotel_booking_and_review_app/features/admin/presentation/bloc/admin_hotel_event.dart';
import 'package:hotel_booking_and_review_app/features/admin/presentation/bloc/admin_hotel_state.dart';

class DeleteHotelPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Delete Hotel"),
      ),
      body: BlocConsumer<AdminHotelBloc, AdminHotelState>(
  listener: (context, state) {
    if (state is AdminHotelError) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(state.message)),
      );
    }
  },
  builder: (context, state) {
    if (state is AdminHotelInitial) {
      // Fetch hotels when the page is first loaded
      context.read<AdminHotelBloc>().add(FetchHotelsEvent()); // <-- Trigger the fetch here
      return Center(child: CircularProgressIndicator());
    } else if (state is AdminHotelLoading) {
      return Center(child: CircularProgressIndicator());
    } else if (state is AdminHotelsLoaded) {
      if (state.hotels.isEmpty) {
        return Center(child: Text("No hotels available to delete."));
      }
      return ListView.builder(
        itemCount: state.hotels.length,
        itemBuilder: (context, index) {
          final hotel = state.hotels[index];
          return Card(
            margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: ListTile(
              title: Text(hotel.name),
              subtitle: Text(hotel.location),
              trailing: IconButton(
                icon: Icon(Icons.delete, color: Colors.red),
                onPressed: () async {
                  bool confirm = await showDialog(
                    context: context,
                    builder: (ctx) => AlertDialog(
                      title: Text("Delete Hotel"),
                      content: Text("Are you sure you want to delete ${hotel.name}?"),
                      actions: [
                        TextButton(
                          child: Text("Cancel"),
                          onPressed: () => Navigator.pop(ctx, false),
                        ),
                        TextButton(
                          child: Text("Delete"),
                          onPressed: () => Navigator.pop(ctx, true),
                        ),
                      ],
                    ),
                  );

                  if (confirm) {
                    context.read<AdminHotelBloc>().add(DeleteHotelEvent(hotel.id));
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text("${hotel.name} deleted successfully!")),
                    );
                    // Trigger fetch after deletion
                    context.read<AdminHotelBloc>().add(FetchHotelsEvent()); // <-- Trigger fetch after delete
                  }
                },
              ),
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

    );
  }
}
