import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hotel_booking_and_review_app/features/admin/presentation/bloc/admin_hotel_bloc.dart';
import 'package:hotel_booking_and_review_app/features/admin/presentation/bloc/admin_hotel_event.dart';
import 'package:hotel_booking_and_review_app/features/admin/presentation/bloc/admin_hotel_state.dart';

class AssignRolePage extends StatefulWidget {
  @override
  _AssignRolePageState createState() => _AssignRolePageState();
}

class _AssignRolePageState extends State<AssignRolePage> {
  final TextEditingController usernameController = TextEditingController();
  String selectedRole = 'user'; // Default role is 'user'

  @override
  void dispose() {
    usernameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Assign Role", style: TextStyle(color: Colors.white)),
        backgroundColor: Color(0xFF1E3E62),
      ),
      body: BlocConsumer<AdminHotelBloc, AdminHotelState>(
        listener: (context, state) {
  if (state is AdminRoleAssigned) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text("Role assigned successfully")),
    );
    Navigator.pop(context);
  } else if (state is AdminRoleAssignError) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text("Error: ${state.message}")),
    );
  }
},

        builder: (context, state) {
          if (state is AdminRoleAssigning) {
            return Center(child: CircularProgressIndicator());
          }

          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextField(
                  controller: usernameController,
                  decoration: InputDecoration(
                    labelText: "Enter Username",
                    border: OutlineInputBorder(),
                  ),
                ),
                SizedBox(height: 20),
                DropdownButtonFormField<String>(
                  value: selectedRole,
                  onChanged: (String? newValue) {
                    if (newValue != null) {
                      setState(() {
                        selectedRole = newValue;
                      });
                    }
                  },
                  items: <String>['user', 'admin']
                      .map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                  decoration: InputDecoration(
                    labelText: "Select Role",
                    border: OutlineInputBorder(),
                  ),
                ),
                SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () {
                    final username = usernameController.text.trim();
                    if (username.isEmpty) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text("Username cannot be empty")),
                      );
                      return;
                    }
                    context
                        .read<AdminHotelBloc>()
                        .add(AssignRoleEvent(userId: username, role: selectedRole));
                  },
                  child: Text("Assign Role"),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
