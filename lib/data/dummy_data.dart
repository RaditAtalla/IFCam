import 'package:ifcam/models/attendance.dart';
import 'package:ifcam/models/schedule.dart';
import 'package:ifcam/models/shift.dart';

final List<Attendance> dummyAttendances = [
  Attendance(
    id: 'A1',
    address: 'Telkom University, Bandung',
    latitude: -6.9733,
    longitude: 107.6303,
    takenAt: DateTime(2026, 10, 12, 7, 15),
    note: 'Captured by IFCam',
    photoPath: 'assets/img/dummy_1.jpg',
  ),
  Attendance(
    id: 'A2',
    address: 'Telkom University, Bandung',
    latitude: -6.9734,
    longitude: 107.6304,
    takenAt: DateTime(2026, 10, 14, 9, 5),
    note: 'Praktikum PPB',
    photoPath: 'assets/img/dummy_2.jpg',
  ),
];

final List<Schedule> dummySchedules = [
  Schedule(
    id: 'S1',
    course: 'Pemrograman Perangkat Bergerak',
    room: 'Lab IFLAB',
    date: DateTime(2026, 11, 9),
    startTime: '07:00',
    endTime: '09:00',
    attended: true,
  ),
  Schedule(
    id: 'S2',
    course: 'Pemrograman Perangkat Bergerak',
    room: 'Lab IFLAB',
    date: DateTime(2026, 11, 11),
    startTime: '09:30',
    endTime: '11:30',
    attended: false,
  ),
  Schedule(
    id: 'S3',
    course: 'Basis Data',
    room: 'Lab IFLAB',
    date: DateTime(2026, 11, 13),
    startTime: '13:00',
    endTime: '15:00',
    attended: false,
  ),
];

final List<Shift> dummyShifts = [
  Shift(
    id: 'SH1',
    schedule: dummySchedules[1],
    sellerName: 'Asprak A',
    isTaken: false,
  ),
  Shift(
    id: 'SH2',
    schedule: dummySchedules[2],
    sellerName: 'Asprak B',
    isTaken: true,
  ),
];
