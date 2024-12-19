import 'package:flutter/material.dart';

class SignUpPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(
                  'SIGNUP',
                  style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold , color: Color(0xFF1E3E62)),
                ),
                SizedBox(height: 8),
                Text(
                  'Fill your details below, or register with social account',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 16, color: Colors.grey),
                ),
                SizedBox(height: 24),
                TextField(
                  decoration: InputDecoration(
                    labelText: 'Username',
                    border: OutlineInputBorder(),
                  ),
                ),
                SizedBox(height: 16),
                TextField(
                  decoration: InputDecoration(
                    labelText: 'Email',
                    border: OutlineInputBorder(),
                  ),
                ),
                SizedBox(height: 16),
                TextField(
                  decoration: InputDecoration(
                    labelText: 'Password',
                    border: OutlineInputBorder(),
                  ),
                  obscureText: true,
                ),
                SizedBox(height: 16),
                TextField(
                  decoration: InputDecoration(
                    labelText: 'Confirm Password',
                    border: OutlineInputBorder(),
                  ),
                  obscureText: true,
                ),
                SizedBox(height: 16),
                Row(
                  children: <Widget>[
                    Checkbox(value: false, onChanged: (bool? value) {}),
                    Text('Agree with terms and conditions'),
                  ],
                ),
                SizedBox(height: 16),
                ElevatedButton(
                  onPressed: () {},
                  child: Text('SIGN UP'),
                  style: ElevatedButton.styleFrom(
                   backgroundColor: Color(0xFF1E3E62)
                  ),
                ),
                SizedBox(height: 16),
                Text('or sign up with'),
                SizedBox(height: 16),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    IconButton(
                      icon: Icon(Icons.account_circle),
                      onPressed: () {},
                    ),
                    IconButton(
                      icon: Icon(Icons.account_circle),
                      onPressed: () {},
                    ),
                    IconButton(
                      icon: Icon(Icons.account_circle),
                      onPressed: () {},
                    ),
                  ],
                ),
                SizedBox(height: 16),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text('Already have an account?'),
                    TextButton(
                      onPressed: () {},
                      child: Text('Sign In',style: TextStyle(color: Color(0xFF1E3E62)),),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}