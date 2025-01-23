
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hotel_booking_and_review_app/features/admin/presentation/pages/admin_dashboard.dart';
import 'package:hotel_booking_and_review_app/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:hotel_booking_and_review_app/features/auth/presentation/bloc/auth_event.dart';
import 'package:hotel_booking_and_review_app/features/auth/presentation/bloc/auth_state.dart';
import 'package:hotel_booking_and_review_app/features/auth/presentation/pages/SignUp_page.dart';
import 'package:hotel_booking_and_review_app/features/auth/presentation/pages/forgotpasswordpage.dart';
import 'package:hotel_booking_and_review_app/features/role/presentation/bloc/role_bloc.dart';
import 'package:hotel_booking_and_review_app/features/role/presentation/bloc/role_event.dart';
import 'package:hotel_booking_and_review_app/features/role/presentation/bloc/role_state.dart';

class LoginPage extends StatelessWidget {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 100),
                Center(
                  child: Column(
                    children: [
                      Text(
                        'Sign In',
                        style: TextStyle(
                          fontSize: 32,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF1E3E62),
                        ),
                      ),
                      SizedBox(height: 10),
                      Text(
                        'Hi Welcome! Continue to login',
                        style: TextStyle(fontSize: 16, color: Colors.grey),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 32),
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
                    }
                    return null;
                  },
                ),
                SizedBox(height: 8),
                Align(
                  alignment: Alignment.centerRight,
                  child: TextButton(
                    onPressed: () {
 Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => ForgotPasswordPage()),
                      );                    },
                    child: Text(
                      'Forgot Password?',
                      style: TextStyle(color: Color(0xFF1E3E62)),
                    ),
                  ),
                ),
                SizedBox(height: 16),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Color(0xFF1E3E62),
                      foregroundColor: Colors.white,
                    ),
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        final email = emailController.text;
                        final password = passwordController.text;
                        context
                            .read<AuthBloc>()
                            .add(SignInEvent(email: email, password: password));
                      }
                    },
                    child: Text('Sign In'),
                  ),
                ),
                SizedBox(height: 16),
                BlocListener<AuthBloc, AuthState>(
                  listener: (context, state) {
                    if (state is SignedInState) {
                      // Fetch user role after successful sign-in
                      context.read<RoleBloc>().add(FetchUserRoleEvent(uid: state.user.uid));
                    } else if (state is SignedOutState) {
                      context.read<AuthBloc>().add(ResetAuthStateEvent());
                    }
                  },
                  child: BlocBuilder<RoleBloc, RoleState>(
                    builder: (context, roleState) {
                      if (roleState is RoleFetchedState) {
                        if (roleState.role == 'admin') {
                          // Add a delay before navigation
                          Future.microtask(() {
                            Navigator.pushNamed(context, '/admin_dashboard');
                          });
                        } else if (roleState.role == 'user') {
                          Future.microtask(() {
                            Navigator.pushNamed(context, '/home');
                          });
                        }
                      }
                      return SizedBox.shrink(); // Return a widget when no role state is found
                    },
                  ),
                ),
                SizedBox(height: 24),
                Center(
                  child: Column(
                    children: [
                      Text(
                        '_________________or sign in with_________________',
                        style: TextStyle(color: Colors.grey),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 16),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    IconButton(
                      icon: Icon(Icons.g_translate),
                      onPressed: () {
                        // Handle Google sign in
                      },
                    ),
                    SizedBox(width: 10),
                    IconButton(
                      icon: Icon(Icons.facebook),
                      onPressed: () {
                        // Handle Facebook sign in
                      },
                    ),
                    SizedBox(width: 10),
                    IconButton(
                      icon: Icon(Icons.alternate_email),
                      onPressed: () {
                        // Handle Twitter sign in
                      },
                    ),
                  ],
                ),
                SizedBox(height: 24),
                Center(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("Don't have an account? "),
                      TextButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => SignUpPage()),
                          );
                        },
                        child: Text(
                          'Sign Up',
                          style: TextStyle(
                            color: Color(0xFF1E3E62),
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}