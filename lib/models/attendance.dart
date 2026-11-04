class Attendance {
  final String id;
  final String scheduleId;
  final String address;
  final double latitude;
  final double longitude;
  final DateTime takenAt;
  final String note;
  final String photoPath;
  final List<String> presentAsprak;

  const Attendance({
    required this.id,
    required this.scheduleId,
    required this.address,
    required this.latitude,
    required this.longitude,
    required this.takenAt,
    required this.note,
    required this.photoPath,
    required this.presentAsprak,
  });
}
