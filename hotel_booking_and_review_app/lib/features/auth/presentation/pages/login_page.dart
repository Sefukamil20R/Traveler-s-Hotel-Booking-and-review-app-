// import 'package:flutter/material.dart';

// class LoginPage extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Padding(
//         padding: const EdgeInsets.all(24.0), // Increased padding for margin
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             SizedBox(height: 100),
//             Center( // Center the header
//               child: Column(
//                 children: [
//                   Text(
//                     'Sign In',
//                     style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold,color: Color(0xFF1E3E62)),
//                   ),
//                   SizedBox(height: 10),
//                   Text(
//                     'Hi Welcome! Continue to login',
//                     style: TextStyle(fontSize: 16, color: Colors.grey),
//                   ),
//                 ],
//               ),
//             ),
//             SizedBox(height: 32),
//             TextField(
//               decoration: InputDecoration(
//                 labelText: 'Email',
//                 border: OutlineInputBorder(),
//               ),
//             ),
//             SizedBox(height: 16),
//             TextField(
//               obscureText: true,
//               decoration: InputDecoration(
//                 labelText: 'Password',
//                 border: OutlineInputBorder(),
//               ),
//             ),
//             SizedBox(height: 8),
//             Align(
//               alignment: Alignment.centerRight,
//               child: TextButton(
//                 onPressed: () {
//                   // Handle forgot password
//                 },
//                 child: Text('Forgot Password?',style: TextStyle(color: Color(0xFF1E3E62)),),
//               ),
//             ),
//             SizedBox(height: 16),
//             SizedBox(
//               width: double.infinity,
//               child: ElevatedButton(
//                 //background color
//               style: ElevatedButton.styleFrom(
//               backgroundColor: Color(0xFF1E3E62), // Set the background color
//               foregroundColor: Colors.white, // Set the text color
//             ),
                
                
//                 onPressed: () {
//                   // Handle sign in
//                 },
//                 child: Text('Sign In'),
//               ),
//             ),
//             SizedBox(height: 16),
//             Center(
//               child: Column(
//                 children: [
//                   Text('_________________or sign in with_________________'),
//                 ],
//               ),
//             ),
//             SizedBox(height: 16),
//             Row(
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: [
//                 IconButton(
//                   icon: Icon(Icons.g_translate),
//                   onPressed: () {
//                     // Handle Google sign in
//                   },
//                 ),
//                 SizedBox(width: 10),
//                 IconButton(
//                   icon: Icon(Icons.facebook),
//                   onPressed: () {
//                     // Handle Facebook sign in
//                   },
//                 ),
//                 SizedBox(width: 10),
//                 IconButton(
//                   icon: Icon(Icons.alternate_email),
//                   onPressed: () {
//                     // Handle Twitter sign in
//                   },
//                 ),
//               ],
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

// class LoginPage extends StatelessWidget {
//   final TextEditingController emailController = TextEditingController();
//   final TextEditingController passwordController = TextEditingController();

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Padding(
//         padding: const EdgeInsets.all(24.0),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             SizedBox(height: 100),
//             Text('Login to your account', style: TextStyle(fontSize: 32)),
//             SizedBox(height: 40),
//             TextField(
//               controller: emailController,
//               decoration: InputDecoration(labelText: 'Email'),
//             ),
//             SizedBox(height: 16),
//             TextField(
//               controller: passwordController,
//               obscureText: true,
//               decoration: InputDecoration(labelText: 'Password'),
//             ),
//             SizedBox(height: 24),
//             ElevatedButton(
//               onPressed: () {
//                 final email = emailController.text;
//                 final password = passwordController.text;
//                 context.read<AuthBloc>().add(SignInEvent(email: email, password: password));
//               },
//               child: Text('Login'),
//             ),
//             BlocBuilder<AuthBloc, AuthState>(
//               builder: (context, state) {
//                 if (state is AuthLoadingState) {
//                   return CircularProgressIndicator();
//                 } else if (state is SignedInState) {
//                   return Text('Logged in as: ${state.user.username}');
//                 } else if (state is AuthErrorState) {
//                   return Text(state.errorMessage, style: TextStyle(color: Colors.red));
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
// import 'package:hotel_booking_app/features/auth/presenation/pages/SignUp_page.dart';


// class LoginPage extends StatelessWidget {
//   final TextEditingController emailController = TextEditingController();
//   final TextEditingController passwordController = TextEditingController();

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Padding(
//         padding: const EdgeInsets.all(24.0),
//         child: SingleChildScrollView(
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               SizedBox(height: 100),
//               Center(
//                 child: Column(
//                   children: [
//                     Text(
//                       'Sign In',
//                       style: TextStyle(
//                         fontSize: 32,
//                         fontWeight: FontWeight.bold,
//                         color: Color(0xFF1E3E62),
//                       ),
//                     ),
//                     SizedBox(height: 10),
//                     Text(
//                       'Hi Welcome! Continue to login',
//                       style: TextStyle(fontSize: 16, color: Colors.grey),
//                     ),
//                   ],
//                 ),
//               ),
//               SizedBox(height: 32),
//               TextField(
//                 controller: emailController,
//                 decoration: InputDecoration(
//                   labelText: 'Email',
//                   border: OutlineInputBorder(),
//                 ),
//               ),
//               SizedBox(height: 16),
//               TextField(
//                 controller: passwordController,
//                 obscureText: true,
//                 decoration: InputDecoration(
//                   labelText: 'Password',
//                   border: OutlineInputBorder(),
//                 ),
//               ),
//               SizedBox(height: 8),
//               Align(
//                 alignment: Alignment.centerRight,
//                 child: TextButton(
//                   onPressed: () {
//                     // Handle forgot password
//                   },
//                   child: Text(
//                     'Forgot Password?',
//                     style: TextStyle(color: Color(0xFF1E3E62)),
//                   ),
//                 ),
//               ),
//               SizedBox(height: 16),
//               SizedBox(
//                 width: double.infinity,
//                 child: ElevatedButton(
//                   style: ElevatedButton.styleFrom(
//                     backgroundColor: Color(0xFF1E3E62),
//                     foregroundColor: Colors.white,
//                   ),
//                   onPressed: () {
//                     final email = emailController.text;
//                     final password = passwordController.text;
//                     context
//                         .read<AuthBloc>()
//                         .add(SignInEvent(email: email, password: password));
//                   },
//                   child: Text('Sign In'),
//                 ),
//               ),
//               SizedBox(height: 16),
//               BlocBuilder<AuthBloc, AuthState>(
//                 builder: (context, state) {
//                   if (state is AuthLoadingState) {
//                     return Center(child: CircularProgressIndicator());
//                   }
//                   else if (state is SignedInState) {
//                    return Text('Logged in as: ${state.user.username}');}
//                 else if (state is AuthErrorState) {
//                     return Center(
//                       child: Text(
//                         state.errorMessage,
//                         style: TextStyle(color: Colors.red),
//                       ),
//                     );
//                   }
//                   return SizedBox.shrink();
//                 },
//               ),
//               SizedBox(height: 24),
//               Center(
//                 child: Column(
//                   children: [
//                     Text(
//                       '_________________or sign in with_________________',
//                       style: TextStyle(color: Colors.grey),
//                     ),
//                   ],
//                 ),
//               ),
//               SizedBox(height: 16),
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: [
//                   IconButton(
//                     icon: Icon(Icons.g_translate),
//                     onPressed: () {
//                       // Handle Google sign in
//                     },
//                   ),
//                   SizedBox(width: 10),
//                   IconButton(
//                     icon: Icon(Icons.facebook),
//                     onPressed: () {
//                       // Handle Facebook sign in
//                     },
//                   ),
//                   SizedBox(width: 10),
//                   IconButton(
//                     icon: Icon(Icons.alternate_email),
//                     onPressed: () {
//                       // Handle Twitter sign in
//                     },
//                   ),
//                 ],
//               ),
//               SizedBox(height: 24),
//               Center(
//                 child: Row(
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   children: [
//                     Text("Don't have an account? "),
//                     TextButton(
//                       onPressed: () {
//                         Navigator.push(
//                           context,
//                           MaterialPageRoute(builder: (context) => SignUpPage()),
//                         );
//                       },
//                       child: Text(
//                         'Sign Up',
//                         style: TextStyle(
//                           color: Color(0xFF1E3E62),
//                           fontWeight: FontWeight.bold,
//                         ),
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hotel_booking_and_review_app/features/admin/presentation/pages/admin_dashboard.dart';
import 'package:hotel_booking_and_review_app/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:hotel_booking_and_review_app/features/auth/presentation/bloc/auth_event.dart';
import 'package:hotel_booking_and_review_app/features/auth/presentation/bloc/auth_state.dart';
import 'package:hotel_booking_and_review_app/features/auth/presentation/pages/SignUp_page.dart';
import 'package:hotel_booking_and_review_app/features/role/presentation/bloc/role_bloc.dart';
import 'package:hotel_booking_and_review_app/features/role/presentation/bloc/role_event.dart';
import 'package:hotel_booking_and_review_app/features/role/presentation/bloc/role_state.dart';


class LoginPage extends StatelessWidget {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: SingleChildScrollView(
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
              TextField(
                controller: emailController,
                decoration: InputDecoration(
                  labelText: 'Email',
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(height: 16),
              TextField(
                controller: passwordController,
                obscureText: true,
                decoration: InputDecoration(
                  labelText: 'Password',
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(height: 8),
              Align(
                alignment: Alignment.centerRight,
                child: TextButton(
                  onPressed: () {
                    // Handle forgot password
                  },
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
                    final email = emailController.text;
                    final password = passwordController.text;
                    context
                        .read<AuthBloc>()
                        .add(SignInEvent(email: email, password: password));
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
        } else if(roleState.role == 'user') {
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
    );
  }
}
