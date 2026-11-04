import 'schedule.dart';

class Shift {
  final String id;
  final Schedule schedule;
  final String sellerName;
  bool isTaken;
  String? buyerName;

  Shift({
    required this.id,
    required this.schedule,
    required this.sellerName,
    this.isTaken = false,
    this.buyerName,
  });
}
