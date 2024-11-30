import 'package:flutter/material.dart';

class VerifyCodePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        title: Text('Verify Code',style: TextStyle(color: Color(0xFF1E3E62)),),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Verify Code',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),
            Text(
              'Please enter the code we just sent to email name@example.com',
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: List.generate(4, (index) {
                return Container(
                  width: 50,
                  child: TextField(
                    textAlign: TextAlign.center,
                    keyboardType: TextInputType.number,
                    maxLength: 1,
                    decoration: InputDecoration(
                      counterText: '',
                      border: OutlineInputBorder(),
                    ),
                  ),
                );
              }),
            ),
            SizedBox(height: 16),
            Text(
              'Didn’t receive OTP?',
              style: TextStyle(fontSize: 14),
            ),
            GestureDetector(
              onTap: () {
                // Handle resend code
              },
              child: Text(
                'Resend Code',
                style: TextStyle(
                  fontSize: 14,
                  color: Color(0xFF1E3E62),
                  decoration: TextDecoration.underline,
                ),
              ),
            ),
            SizedBox(height: 24),
            Center(
              child: ElevatedButton(
                onPressed: () {
                  // Handle verify code
                },
                child: Text('Verify'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color(0xFF1E3E62))
              ),
            ),
          ],
        ),
      ),
    );
  }
}