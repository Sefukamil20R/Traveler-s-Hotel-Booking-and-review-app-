import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hotel_booking_and_review_app/features/auth/domain/entitities/auth_entitiy.dart';
import 'package:hotel_booking_and_review_app/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:hotel_booking_and_review_app/features/auth/presentation/bloc/auth_event.dart';
import 'package:hotel_booking_and_review_app/features/auth/presentation/bloc/auth_state.dart';
import 'package:hotel_booking_and_review_app/features/auth/presentation/pages/login_page.dart';
import 'package:hotel_booking_and_review_app/features/auth/presentation/pages/verify_code.dart';

class SignUpPage extends StatelessWidget {
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    bool agreeToTerms = false;

    return Scaffold(
      body: BlocListener<AuthBloc, AuthState>(
        listener: (context, state) {
          if (state is SignedUpState) {
            // Navigate to VerifyCodePage on successful signup
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => VerifyCodePage(email: state.user.email),
              ),
            );
          } else if (state is AuthErrorState) {
            // Show error message as a SnackBar
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(state.errorMessage)),
            );
          }
        },
        child: Padding(
          padding: const EdgeInsets.all(28.0),
          child: Center(
            child: SingleChildScrollView(
              child: Form(
                key: _formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    SizedBox(height: 20),
                    // Title
                    Text(
                      'SIGNUP',
                      style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold, color: Color(0xFF1E3E62)),
                    ),
                    SizedBox(height: 8),
                    // Subtitle
                    Text(
                      'Fill your details below, or register with social account',
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 16, color: Colors.grey),
                    ),
                    SizedBox(height: 24),
                    // Username Input
                    TextFormField(
                      controller: usernameController,
                      decoration: InputDecoration(
                        labelText: 'Username',
                        border: OutlineInputBorder(),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your username';
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: 16),
                    // Email Input
                    TextFormField(
                      controller: emailController,
                      decoration: InputDecoration(
                        labelText: 'Email',
                        border: OutlineInputBorder(),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your email';
                        } else if (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(value)) {
                          return 'Please enter a valid email address';
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: 16),
                    // Password Input
                    TextFormField(
                      controller: passwordController,
                      obscureText: true,
                      decoration: InputDecoration(
                        labelText: 'Password',
                        border: OutlineInputBorder(),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your password';
                        } else if (value.length < 6) {
                          return 'Password must be at least 6 characters long';
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: 16),
                    // Confirm Password Input
                    TextFormField(
                      controller: confirmPasswordController,
                      obscureText: true,
                      decoration: InputDecoration(
                        labelText: 'Confirm Password',
                        border: OutlineInputBorder(),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please confirm your password';
                        } else if (value != passwordController.text) {
                          return 'Passwords do not match';
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: 16),
                    // Terms and Conditions Checkbox
                    Row(
                      children: <Widget>[
                        StatefulBuilder(
                          builder: (context, setState) => Checkbox(
                            value: agreeToTerms,
                            onChanged: (bool? value) {
                              setState(() {
                                agreeToTerms = value ?? false;
                              });
                            },
                          ),
                        ),
                        Text('Agree with terms and conditions'),
                      ],
                    ),
                    SizedBox(height: 16),
                    // Sign Up Button
                    ElevatedButton(
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          if (agreeToTerms) {
                            final user = UserEntity(
                              uid: '', // Auto-generated by Firebase
                              email: emailController.text,
                              emailVerified: false,
                              username: usernameController.text,
                              password: passwordController.text,
                            );
                            context.read<AuthBloc>().add(SignUpEvent(user: user));
                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(content: Text("Please agree to the terms and conditions.")),
                            );
                          }
                        }
                      },
                      child: Text('SIGN UP'),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Color(0xFF1E3E62),
                      ),
                    ),
                    SizedBox(height: 16),
                    // Social Sign Up Section
                    Text('or sign up with'),
                    SizedBox(height: 16),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        IconButton(
                          icon: Icon(Icons.facebook, color: Colors.blue),
                          onPressed: () {
                            // Add social signup logic if needed
                          },
                        ),
                        IconButton(
                          icon: Icon(Icons.g_mobiledata, color: Colors.red),
                          onPressed: () {
                            // Add Google signup logic if needed
                          },
                        ),
                        IconButton(
                          icon: Icon(Icons.apple, color: Colors.black),
                          onPressed: () {
                            // Add Apple signup logic if needed
                          },
                        ),
                      ],
                    ),
                    SizedBox(height: 16),
                    // Already Have an Account Section
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text('Already have an account?'),
                        TextButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => LoginPage()),
                            );
                          },
                          child: Text(
                            'Sign In',
                            style: TextStyle(color: Color(0xFF1E3E62)),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 16),
                    // Loading Indicator / Error Handling (BlocBuilder)
                    BlocBuilder<AuthBloc, AuthState>(
                      builder: (context, state) {
                        if (state is AuthLoadingState) {
                          return CircularProgressIndicator();
                        } else if (state is AuthErrorState) {
                          return Text(
                            state.errorMessage,
                            style: TextStyle(color: Colors.red),
                          );
                        } else if (state is SignedUpState) {
                          return Text('User signed up successfully.');
                        }
                        return SizedBox.shrink();
                      },
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}