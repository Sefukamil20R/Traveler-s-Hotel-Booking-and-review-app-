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
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:hotel_booking_app/features/auth/presenation/bloc/auth_bloc.dart';
// import 'package:hotel_booking_app/features/auth/presenation/bloc/auth_event.dart';
// import 'package:hotel_booking_app/features/auth/presenation/bloc/auth_state.dart';


// class VerifyCodePage extends StatelessWidget {
//   final TextEditingController codeController = TextEditingController();

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Padding(
//         padding: const EdgeInsets.all(24.0),
//         child: Column(
//           children: [
//             TextField(
//               controller: codeController,
//               decoration: InputDecoration(labelText: 'Verification Code'),
//             ),
//             SizedBox(height: 16),
//             ElevatedButton(
//               onPressed: () {
//                 context.read<AuthBloc>().add(VerifyEmailEvent());
//               },
//               child: Text('Verify Email'),
//             ),
//             BlocBuilder<AuthBloc, AuthState>(
//               builder: (context, state) {
//                 if (state is AuthLoadingState) {
//                   return CircularProgressIndicator();
//                 } else if (state is EmailVerifiedState) {
//                   return Text('Email verified successfully!');
//                 } else if (state is AuthErrorState) {
//                  return Text(state.errorMessage, style: TextStyle(color: Colors.red));
//                 }
//                 return SizedBox.shrink();
//               },
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
 
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:hotel_booking_app/features/auth/presenation/bloc/auth_bloc.dart';
// import 'package:hotel_booking_app/features/auth/presenation/bloc/auth_event.dart';
// import 'package:hotel_booking_app/features/auth/presenation/bloc/auth_state.dart';

// class VerifyCodePage extends StatelessWidget {
//   final List<TextEditingController> codeControllers = List.generate(
//     4,
//     (index) => TextEditingController(),
//   );

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
//         title: Text(
//           'Verify Code',
//           style: TextStyle(color: Color(0xFF1E3E62)),
//         ),
//         backgroundColor: Colors.white,
//         elevation: 0,
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
//               'Please enter the 4-digit code we just sent to your email.',
//               style: TextStyle(fontSize: 16),
//             ),
//             SizedBox(height: 16),
//             Row(
//               mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//               children: List.generate(4, (index) {
//                 return Container(
//                   width: 50,
//                   child: TextField(
//                     controller: codeControllers[index],
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
//               'Didn’t receive the OTP?',
//               style: TextStyle(fontSize: 14),
//             ),
//             GestureDetector(
//               onTap: () {
//                 context.read<AuthBloc>().add(ResendCodeEvent());
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
//                   // Combine the code from the controllers
//                   final enteredCode = codeControllers.map((c) => c.text).join();
//                   context
//                       .read<AuthBloc>()
//                       .add(VerifyCodeEvent(verificationCode: enteredCode));
//                 },
//                 child: Text('Verify'),
//                 style: ElevatedButton.styleFrom(
//                   backgroundColor: Color(0xFF1E3E62),
//                 ),
//               ),
//             ),
//             SizedBox(height: 24),
//             BlocBuilder<AuthBloc, AuthState>(
//               builder: (context, state) {
//                 if (state is AuthLoadingState) {
//                   return Center(child: CircularProgressIndicator());
//                 } else if (state is EmailVerifiedState) {
//                   return Center(
//                     child: Text(
//                       'Email verified successfully!',
//                       style: TextStyle(color: Colors.green),
//                     ),
//                   );
//                 } else if (state is AuthErrorState) {
//                   return Center(
//                     child: Text(
//                       state.errorMessage,
//                       style: TextStyle(color: Colors.red),
//                     ),
//                   );
//                 }
//                 return SizedBox.shrink();
//               },
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hotel_booking_and_review_app/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:hotel_booking_and_review_app/features/auth/presentation/bloc/auth_event.dart';
import 'package:hotel_booking_and_review_app/features/auth/presentation/bloc/auth_state.dart';



class VerifyCodePage extends StatelessWidget {
  final String email;

  const VerifyCodePage({Key? key, required this.email}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocListener<AuthBloc, AuthState>(
        listener: (context, state) {
          if (state is EmailVerifiedState) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Email verified successfully!')),
            );
            Navigator.pop(context); // Navigate back after successful verification
          } else if (state is AuthErrorState) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(state.errorMessage)),
            );
          } else if (state is CodeResentState) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Verification code resent.')),
            );
          }
        },
        child: Padding(
          padding: const EdgeInsets.all(28.0),
          child: Center(
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  // Email Verification Image
                  Image.asset(
                    'assets/images/verify_email.png', // Add a relevant image asset
                    height: 180,
                  ),
                  const SizedBox(height: 20),
                  // Title
                  const Text(
                    'Verify Your Email',
                    style: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF1E3E62),
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 10),
                  // Instruction Text
                  const Text(
                    'We have sent a verification email to:',
                    style: TextStyle(fontSize: 16, color: Colors.grey),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 8),
                  Text(
                    email,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF1E3E62),
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 20),
                  // Resend Verification Link
                  const Text(
                    'Didn’t receive the OTP?',
                    style: TextStyle(fontSize: 14),
                  ),
                  GestureDetector(
                    onTap: () {
                      context.read<AuthBloc>().add(ResendCodeEvent());
                    },
                    child: const Text(
                      'Resend Code',
                      style: TextStyle(
                        fontSize: 14,
                        color: Color(0xFF1E3E62),
                        decoration: TextDecoration.underline,
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  // Instruction to Proceed After Verification
                  const Text(
                    'Once you verify your email, press the button below to complete the process.',
                    style: TextStyle(fontSize: 14, color: Colors.grey),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 16),
                  // Verify Button
                  ElevatedButton(
                    onPressed: () {
                      context.read<AuthBloc>().add(VerifyEmailEvent());
                    },
                    child: const Text('I Have Verified My Email'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.green,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 32, vertical: 12),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
