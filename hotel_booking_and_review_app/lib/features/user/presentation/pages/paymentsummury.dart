import 'package:flutter/material.dart';
import 'package:flutter_stripe/flutter_stripe.dart';



class PaymentPage extends StatefulWidget {
  @override
  _PaymentPageState createState() => _PaymentPageState();
}

class _PaymentPageState extends State<PaymentPage> {
  bool _isProcessing = false;

  @override
  void initState() {
    super.initState();
    Stripe.publishableKey =
        'pk_test_51PL1wLRpW5uwDL2GrSobZDQY6bKh5J88WHuR6KVDnqJTMRGo4tKSAECMbBDTlnnZTgkx2d6CDUbGhCT1gLI6kbyw00HgRObcSv';
    _initPaymentSheet();
  }

  Future<void> _initPaymentSheet() async {
    try {
      final paymentIntent = await _createMockPaymentIntent();

      await Stripe.instance.initPaymentSheet(
        paymentSheetParameters: SetupPaymentSheetParameters(
          paymentIntentClientSecret: paymentIntent['client_secret'],
          merchantDisplayName: 'Mock Merchant',
          style: ThemeMode.light,
        ),
      );
    } catch (e) {
      print('Error initializing payment sheet: $e');
    }
  }

  Future<Map<String, dynamic>> _createMockPaymentIntent() async {
    // Mock PaymentIntent data
    return {
      'client_secret': 'pi_mock_12345_secret_67890',
    };
  }

  Future<void> _handlePayment() async {
    setState(() {
      _isProcessing = true;
    });

    try {
      await Stripe.instance.presentPaymentSheet();

      setState(() {
        _isProcessing = false;
      });

      // Show success dialog
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text('Payment Successful'),
          content: Text('Thank you for your payment!'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
                Navigator.pushNamedAndRemoveUntil(context, '/home', (route) => false);
              },
              child: Text('Go to Home'),
            ),
          ],
        ),
      );
    } catch (e) {
      setState(() {
        _isProcessing = false;
      });

      // Handle StripeException errors
      if (e is StripeException) {
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: Text('Payment Failed'),
            content: Text(e.error.localizedMessage ?? 'Unknown error'),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: Text('OK'),
              ),
            ],
          ),
        );
      } else {
        print('Error: $e');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Payment'),
        backgroundColor: Colors.blue,
      ),
      body: Center(
        child: _isProcessing
            ? CircularProgressIndicator()
            : ElevatedButton(
                onPressed: _handlePayment,
                style: ElevatedButton.styleFrom(backgroundColor: Colors.blue),
                child: Text('Pay Now'),
              ),
      ),
    );
  }
}

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home'),
      ),
      body: Center(
        child: Text('Welcome to Home Page'),
      ),
    );
  }
}
