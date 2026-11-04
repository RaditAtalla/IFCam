import '../models/attendance.dart';
import '../models/schedule.dart';
import '../models/shift.dart';

const String currentUserName = 'Asprak IFLAB';
const int currentWeek = 2;

const bool dummyInsideArea = true;
const int dummyDistanceMeter = 12;

DateTime getNow() => DateTime(2026, 11, 5, 7, 30);

final List<Schedule> dummySchedules = [
  Schedule(
    id: 'S0',
    course: 'ADPL',
    room: 'SE-48-02',
    date: DateTime(2026, 10, 29),
    startTime: '06:30',
    endTime: '09:30',
    week: 1,
    asprak: ['Radit', 'Abe', 'Petrus', 'Zulfan', 'Sofia', 'Anugerah'],
    attended: true,
  ),
  Schedule(
    id: 'S1',
    course: 'ADPL',
    room: 'SE-48-02',
    date: DateTime(2026, 11, 5),
    startTime: '06:30',
    endTime: '09:30',
    week: 2,
    asprak: ['Radit', 'Abe', 'Petrus', 'Zulfan', 'Sofia', 'Anugerah'],
  ),
  Schedule(
    id: 'S2',
    course: 'STD',
    room: 'SE-48-03',
    date: DateTime(2026, 11, 6),
    startTime: '07:00',
    endTime: '09:30',
    week: 2,
    asprak: ['Radit', 'Petrus', 'Sofia', 'Zulfan'],
  ),
  Schedule(
    id: 'S3',
    course: 'Alpro',
    room: 'SE-48-01',
    date: DateTime(2026, 11, 7),
    startTime: '09:30',
    endTime: '12:30',
    week: 2,
    asprak: ['Radit', 'Abe', 'Sofia', 'Anugerah'],
  ),
];

final List<Shift> dummyShifts = [
  Shift(
    id: 'SH1',
    schedule: dummySchedules[2],
    sellerName: 'Petrus',
    isTaken: true,
    buyerName: 'Dimas',
  ),
  Shift(id: 'SH2', schedule: dummySchedules[3], sellerName: 'Sofia'),
];

final List<Attendance> dummyAttendances = [
  Attendance(
    id: 'A1',
    scheduleId: 'S0',
    address: 'Telkom University, Bandung',
    latitude: -6.9733,
    longitude: 107.6303,
    takenAt: DateTime(2026, 10, 29, 6, 40),
    note: 'Captured by IFCam',
    photoPath: '',
    presentAsprak: ['Radit', 'Abe', 'Petrus', 'Zulfan'],
  ),
];

Schedule? getActiveSchedule() {
  final now = getNow();
  for (final s in dummySchedules) {
    if (s.isActive(now)) return s;
  }
  return null;
}

Schedule getScheduleById(String id) {
  return dummySchedules.firstWhere((s) => s.id == id);
}

Attendance? findAttendanceBySchedule(String scheduleId) {
  for (final a in dummyAttendances) {
    if (a.scheduleId == scheduleId) return a;
  }
  return null;
}

List<String> getAsprakForSchedule(Schedule schedule) {
  final result = List<String>.from(schedule.asprak);
  for (final shift in dummyShifts) {
    if (shift.schedule.id == schedule.id &&
        shift.isTaken &&
        shift.buyerName != null) {
      final i = result.indexOf(shift.sellerName);
      if (i != -1) result[i] = shift.buyerName!;
    }
  }
  return result;
}
