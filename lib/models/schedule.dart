class Schedule {
  final String id;
  final String course;
  final String room;
  final DateTime date;
  final String startTime; // format "06:30"
  final String endTime;
  final int week;
  final List<String> asprak; // asprak awal sebelum ada jual/beli shift
  bool attended;

  Schedule({
    required this.id,
    required this.course,
    required this.room,
    required this.date,
    required this.startTime,
    required this.endTime,
    required this.week,
    required this.asprak,
    this.attended = false,
  });

  DateTime _toDateTime(String time) {
    final parts = time.split(':');
    return DateTime(
      date.year,
      date.month,
      date.day,
      int.parse(parts[0]),
      int.parse(parts[1]),
    );
  }

  DateTime get start => _toDateTime(startTime);
  DateTime get end => _toDateTime(endTime);

  // Apakah jadwal ini sedang berlangsung
  bool isActive(DateTime now) => !now.isBefore(start) && now.isBefore(end);

  String get timeRange =>
      '${startTime.replaceAll(':', '.')} - ${endTime.replaceAll(':', '.')}';
}
