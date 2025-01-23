
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
