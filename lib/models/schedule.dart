class Schedule {
  final String id;
  final String course;
  final String room;
  final DateTime date;
  final String startTime;
  final String endTime;
  final bool attended;

  const Schedule({
    required this.id,
    required this.course,
    required this.room,
    required this.date,
    required this.startTime,
    required this.endTime,
    required this.attended,
  });
}
