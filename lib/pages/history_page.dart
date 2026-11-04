import 'package:flutter/material.dart';
import '../data/dummy_data.dart';
import '../models/attendance.dart';
import '../utils/format.dart';
import 'detail_page.dart';

class HistoryPage extends StatelessWidget {
  const HistoryPage({super.key});

  @override
  Widget build(BuildContext context) {
    // urutkan dari yang terbaru
    final list = List<Attendance>.from(dummyAttendances)
      ..sort((a, b) => b.takenAt.compareTo(a.takenAt));

    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Riwayat Presensi',
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            Expanded(
              child: list.isEmpty
                  ? const Center(child: Text('Belum ada riwayat presensi'))
                  : ListView.separated(
                      itemCount: list.length,
                      separatorBuilder: (context, index) =>
                          const SizedBox(height: 12),
                      itemBuilder: (context, index) {
                        final a = list[index];
                        final schedule = getScheduleById(a.scheduleId);

                        return Material(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(16),
                          clipBehavior: Clip.antiAlias,
                          child: ListTile(
                            contentPadding: const EdgeInsets.all(16),
                            leading: const CircleAvatar(
                              backgroundColor: Color(0xFF1E40AF),
                              child: Icon(Icons.check, color: Colors.white),
                            ),
                            title: Text(
                              '${schedule.course} • ${schedule.room}',
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            subtitle: Text(
                              '${formatDateTime(a.takenAt)}\n${a.address}',
                            ),
                            isThreeLine: true,
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) =>
                                      DetailPage(schedule: schedule),
                                ),
                              );
                            },
                          ),
                        );
                      },
                    ),
            ),
          ],
        ),
      ),
    );
  }
}
