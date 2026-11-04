import 'schedule.dart';

class Shift {
  final String id;
  final Schedule schedule;
  final String sellerName;
  final bool isTaken;

  const Shift({
    required this.id,
    required this.schedule,
    required this.sellerName,
    required this.isTaken,
  });
}
