import 'package:flutter/material.dart';
import '../data/dummy_data.dart';
import '../models/schedule.dart';

class HomePage extends StatelessWidget {
  final String name;
  final String role;

  const HomePage({
    super.key,
    this.name = 'Asprak',
    this.role = 'Asisten Praktikum IFLAB',
  });

  String formatDate(DateTime date) {
    const days = [
      'Senin',
      'Selasa',
      'Rabu',
      'Kamis',
      'Jumat',
      'Sabtu',
      'Minggu',
    ];
    const months = [
      'Januari',
      'Februari',
      'Maret',
      'April',
      'Mei',
      'Juni',
      'Juli',
      'Agustus',
      'September',
      'Oktober',
      'November',
      'Desember',
    ];
    return '${days[date.weekday - 1]}, ${date.day} ${months[date.month - 1]} ${date.year}';
  }

  Schedule? getNextSchedule() {
    for (final schedule in dummySchedules) {
      if (!schedule.attended) {
        return schedule;
      }
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    final nextSchedule = getNextSchedule();

    return SafeArea(
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                const CircleAvatar(
                  radius: 28,
                  backgroundColor: Color(0xFF1E40AF),
                  child: Icon(Icons.person, color: Colors.white, size: 30),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Halo, $name!',
                        style: const TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        role,
                        style: const TextStyle(color: Colors.blueGrey),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 28),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
              ),
              child: nextSchedule == null
                  ? const Text('Tidak ada sesi terdekat')
                  : Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Sesi Terdekat',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF1E40AF),
                          ),
                        ),
                        const SizedBox(height: 16),
                        InfoRow(
                          icon: Icons.menu_book_outlined,
                          text: nextSchedule.course,
                        ),
                        const SizedBox(height: 10),
                        InfoRow(
                          icon: Icons.meeting_room_outlined,
                          text: nextSchedule.room,
                        ),
                        const SizedBox(height: 10),
                        InfoRow(
                          icon: Icons.calendar_today_outlined,
                          text: formatDate(nextSchedule.date),
                        ),
                        const SizedBox(height: 10),
                        InfoRow(
                          icon: Icons.access_time,
                          text:
                              '${nextSchedule.startTime} - ${nextSchedule.endTime} WIB',
                        ),
                      ],
                    ),
            ),
            const SizedBox(height: 24),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                onPressed: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Fitur kamera belum tersedia'),
                    ),
                  );
                },
                icon: const Icon(Icons.camera_alt_outlined),
                label: const Text(
                  'Ambil Foto Presensi',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF1E40AF),
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.all(20),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class InfoRow extends StatelessWidget {
  final IconData icon;
  final String text;

  const InfoRow({super.key, required this.icon, required this.text});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(icon, size: 20, color: Colors.blueGrey),
        const SizedBox(width: 12),
        Expanded(child: Text(text)),
      ],
    );
  }
}
