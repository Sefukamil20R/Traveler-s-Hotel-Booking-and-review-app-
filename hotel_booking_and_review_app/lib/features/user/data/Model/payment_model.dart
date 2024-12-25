// data/models/payment_model.dart
class PaymentModel {
  final String userId;
  final String bookingId;
  final double amount;
  final String paymentStatus;

  PaymentModel({
    required this.userId,
    required this.bookingId,
    required this.amount,
    required this.paymentStatus,
  });

  factory PaymentModel.fromMap(Map<String, dynamic> map) {
    return PaymentModel(
      userId: map['userId'],
      bookingId: map['bookingId'],
      amount: map['amount'],
      paymentStatus: map['paymentStatus'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'userId': userId,
      'bookingId': bookingId,
      'amount': amount,
      'paymentStatus': paymentStatus,
    };
  }
}
