// import 'package:flutter/material.dart';

// class VerifyCodePage extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         leading: IconButton(
//           icon: Icon(Icons.arrow_back),
//           onPressed: () {
//             Navigator.of(context).pop();
//           },
//         ),
//         title: Text('Verify Code',style: TextStyle(color: Color(0xFF1E3E62)),),
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Text(
//               'Verify Code',
//               style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
//             ),
//             SizedBox(height: 8),
//             Text(
//               'Please enter the code we just sent to email name@example.com',
//               style: TextStyle(fontSize: 16),
//             ),
//             SizedBox(height: 16),
//             Row(
//               mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//               children: List.generate(4, (index) {
//                 return Container(
//                   width: 50,
//                   child: TextField(
//                     textAlign: TextAlign.center,
//                     keyboardType: TextInputType.number,
//                     maxLength: 1,
//                     decoration: InputDecoration(
//                       counterText: '',
//                       border: OutlineInputBorder(),
//                     ),
//                   ),
//                 );
//               }),
//             ),
//             SizedBox(height: 16),
//             Text(
//               'Didn’t receive OTP?',
//               style: TextStyle(fontSize: 14),
//             ),
//             GestureDetector(
//               onTap: () {
//                 // Handle resend code
//               },
//               child: Text(
//                 'Resend Code',
//                 style: TextStyle(
//                   fontSize: 14,
//                   color: Color(0xFF1E3E62),
//                   decoration: TextDecoration.underline,
//                 ),
//               ),
//             ),
//             SizedBox(height: 24),
//             Center(
//               child: ElevatedButton(
//                 onPressed: () {
//                   // Handle verify code
//                 },
//                 child: Text('Verify'),
//                 style: ElevatedButton.styleFrom(
//                   backgroundColor: Color(0xFF1E3E62))
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hotel_booking_app/features/auth/presenation/bloc/auth_bloc.dart';
import 'package:hotel_booking_app/features/auth/presenation/bloc/auth_event.dart';
import 'package:hotel_booking_app/features/auth/presenation/bloc/auth_state.dart';


class VerifyCodePage extends StatelessWidget {
  final TextEditingController codeController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          children: [
            TextField(
              controller: codeController,
              decoration: InputDecoration(labelText: 'Verification Code'),
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                context.read<AuthBloc>().add(VerifyEmailEvent());
              },
              child: Text('Verify Email'),
            ),
            BlocBuilder<AuthBloc, AuthState>(
              builder: (context, state) {
                if (state is AuthLoadingState) {
                  return CircularProgressIndicator();
                } else if (state is EmailVerifiedState) {
                  return Text('Email verified successfully!');
                } else if (state is AuthErrorState) {
                  return Text(state.errorMessage, style: TextStyle(color: Colors.red));
                }
                return SizedBox.shrink();
              },
            ),
          ],
        ),
      ),
    );
  }
}
