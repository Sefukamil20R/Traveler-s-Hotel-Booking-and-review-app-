// import 'package:flutter/material.dart';

// class SignUpPage extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Center(
//           child: SingleChildScrollView(
//             child: Column(
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: <Widget>[
//                 Text(
//                   'SIGNUP',
//                   style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold , color: Color(0xFF1E3E62)),
//                 ),
//                 SizedBox(height: 8),
//                 Text(
//                   'Fill your details below, or register with social account',
//                   textAlign: TextAlign.center,
//                   style: TextStyle(fontSize: 16, color: Colors.grey),
//                 ),
//                 SizedBox(height: 24),
//                 TextField(
//                   decoration: InputDecoration(
//                     labelText: 'Username',
//                     border: OutlineInputBorder(),
//                   ),
//                 ),
//                 SizedBox(height: 16),
//                 TextField(
//                   decoration: InputDecoration(
//                     labelText: 'Email',
//                     border: OutlineInputBorder(),
//                   ),
//                 ),
//                 SizedBox(height: 16),
//                 TextField(
//                   decoration: InputDecoration(
//                     labelText: 'Password',
//                     border: OutlineInputBorder(),
//                   ),
//                   obscureText: true,
//                 ),
//                 SizedBox(height: 16),
//                 TextField(
//                   decoration: InputDecoration(
//                     labelText: 'Confirm Password',
//                     border: OutlineInputBorder(),
//                   ),
//                   obscureText: true,
//                 ),
//                 SizedBox(height: 16),
//                 Row(
//                   children: <Widget>[
//                     Checkbox(value: false, onChanged: (bool? value) {}),
//                     Text('Agree with terms and conditions'),
//                   ],
//                 ),
//                 SizedBox(height: 16),
//                 ElevatedButton(
//                   onPressed: () {},
//                   child: Text('SIGN UP'),
//                   style: ElevatedButton.styleFrom(
//                    backgroundColor: Color(0xFF1E3E62)
//                   ),
//                 ),
//                 SizedBox(height: 16),
//                 Text('or sign up with'),
//                 SizedBox(height: 16),
//                 Row(
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   children: <Widget>[
//                     IconButton(
//                       icon: Icon(Icons.account_circle),
//                       onPressed: () {},
//                     ),
//                     IconButton(
//                       icon: Icon(Icons.account_circle),
//                       onPressed: () {},
//                     ),
//                     IconButton(
//                       icon: Icon(Icons.account_circle),
//                       onPressed: () {},
//                     ),
//                   ],
//                 ),
//                 SizedBox(height: 16),
//                 Row(
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   children: <Widget>[
//                     Text('Already have an account?'),
//                     TextButton(
//                       onPressed: () {},
//                       child: Text('Sign In',style: TextStyle(color: Color(0xFF1E3E62)),),
//                     ),
//                   ],
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }

// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:hotel_booking_app/features/auth/domain/entitities/auth_entitiy.dart';
// import 'package:hotel_booking_app/features/auth/presenation/bloc/auth_bloc.dart';
// import 'package:hotel_booking_app/features/auth/presenation/bloc/auth_event.dart';
// import 'package:hotel_booking_app/features/auth/presenation/bloc/auth_state.dart';
// import 'package:hotel_booking_app/features/auth/presenation/pages/login_page.dart';

// class SignUpPage extends StatelessWidget {
//   final TextEditingController usernameController = TextEditingController();
//   final TextEditingController emailController = TextEditingController();
//   final TextEditingController passwordController = TextEditingController();
//   final TextEditingController confirmPasswordController = TextEditingController();

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: BlocListener<AuthBloc, AuthState>(
//         listener: (context, state) {
//           if (state is SignedUpState) {
//             // Navigate to LoginPage on successful signup
//             Navigator.pushReplacement(
//               context,
//               MaterialPageRoute(builder: (context) => LoginPage()),
//             );
//           } else if (state is AuthErrorState) {
//             // Show error message as a SnackBar
//             ScaffoldMessenger.of(context).showSnackBar(
//               SnackBar(content: Text(state.errorMessage)),
//             );
//           }
//         },
//         child: Padding(
//           padding: const EdgeInsets.all(16.0),
//           child: Center(
//             child: SingleChildScrollView(
//               child: Column(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: <Widget>[
//                   Text(
//                     'SIGNUP',
//                     style: TextStyle(
//                         fontSize: 32, fontWeight: FontWeight.bold, color: Color(0xFF1E3E62)),
//                   ),
//                   SizedBox(height: 8),
//                   Text(
//                     'Fill your details below, or register with a social account',
//                     textAlign: TextAlign.center,
//                     style: TextStyle(fontSize: 16, color: Colors.grey),
//                   ),
//                   SizedBox(height: 24),
//                   TextField(
//                     controller: usernameController,
//                     decoration: InputDecoration(
//                       labelText: 'Username',
//                       border: OutlineInputBorder(),
//                     ),
//                   ),
//                   SizedBox(height: 16),
//                   TextField(
//                     controller: emailController,
//                     decoration: InputDecoration(
//                       labelText: 'Email',
//                       border: OutlineInputBorder(),
//                     ),
//                   ),
//                   SizedBox(height: 16),
//                   TextField(
//                     controller: passwordController,
//                     obscureText: true,
//                     decoration: InputDecoration(
//                       labelText: 'Password',
//                       border: OutlineInputBorder(),
//                     ),
//                   ),
//                   SizedBox(height: 16),
//                   TextField(
//                     controller: confirmPasswordController,
//                     obscureText: true,
//                     decoration: InputDecoration(
//                       labelText: 'Confirm Password',
//                       border: OutlineInputBorder(),
//                     ),
//                   ),
//                   SizedBox(height: 16),
//                   ElevatedButton(
//                     onPressed: () {
//                       final user = UserEntity(
//                         uid: '', // Auto-generated by Firebase
//                         email: emailController.text,
//                         emailVerified: false,
//                         username: usernameController.text,
//                         password: passwordController.text,
//                       );
//                       context.read<AuthBloc>().add(SignUpEvent(user: user));
//                     },
//                     child: Text('SIGN UP'),
//                     style: ElevatedButton.styleFrom(backgroundColor: Color(0xFF1E3E62)),
//                   ),
//                   SizedBox(height: 16),
//                   BlocBuilder<AuthBloc, AuthState>(
//                     builder: (context, state) {
//                       if (state is AuthLoadingState) {
//                         return CircularProgressIndicator();
//                       } else if (state is SignedUpState) {
//                         return Text('User signed up: ${state.user.username}');
//                       } else if (state is AuthErrorState) {
//                         return Text(
//                           state.errorMessage,
//                           style: TextStyle(color: Colors.red),
//                         );
//                       }
//                       return SizedBox.shrink();
//                     },
//                   ),
//                 ],
//               ),
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hotel_booking_app/features/auth/domain/entitities/auth_entitiy.dart';
import 'package:hotel_booking_app/features/auth/presenation/bloc/auth_bloc.dart';
import 'package:hotel_booking_app/features/auth/presenation/bloc/auth_event.dart';
import 'package:hotel_booking_app/features/auth/presenation/bloc/auth_state.dart';
import 'package:hotel_booking_app/features/auth/presenation/pages/login_page.dart';
import 'package:hotel_booking_app/features/auth/presenation/pages/verify_code.dart';

class SignUpPage extends StatelessWidget {
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController = TextEditingController();

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
                  TextField(
                    controller: usernameController,
                    decoration: InputDecoration(
                      labelText: 'Username',
                      border: OutlineInputBorder(),
                    ),
                  ),
                  SizedBox(height: 16),
                  // Email Input
                  TextField(
                    controller: emailController,
                    decoration: InputDecoration(
                      labelText: 'Email',
                      border: OutlineInputBorder(),
                    ),
                  ),
                  SizedBox(height: 16),
                  // Password Input
                  TextField(
                    controller: passwordController,
                    obscureText: true,
                    decoration: InputDecoration(
                      labelText: 'Password',
                      border: OutlineInputBorder(),
                    ),
                  ),
                  SizedBox(height: 16),
                  // Confirm Password Input
                  TextField(
                    controller: confirmPasswordController,
                    obscureText: true,
                    decoration: InputDecoration(
                      labelText: 'Confirm Password',
                      border: OutlineInputBorder(),
                    ),
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
                      // Password confirmation check
                      if (passwordController.text != confirmPasswordController.text) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text("Passwords do not match.")),
                        );
                      } else if (agreeToTerms) {
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
    );
  }
}
