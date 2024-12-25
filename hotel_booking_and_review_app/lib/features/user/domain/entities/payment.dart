import 'package:equatable/equatable.dart';

class Payment extends Equatable {
  final String paymentId;
  final String userId;
  final String bookingId;
  final double amount;
  final String status; // e.g., "completed", "pending", "failed"

  Payment({
    required this.paymentId,
    required this.userId,
    required this.bookingId,
    required this.amount,
    required this.status,
  });

  @override
  List<Object?> get props => [paymentId, userId, bookingId, amount, status];
}
