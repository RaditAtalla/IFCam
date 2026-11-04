import 'package:flutter/material.dart';
import '../data/dummy_data.dart';
import '../models/attendance.dart';
import '../models/schedule.dart';
import '../utils/format.dart';
import '../widgets/info_row.dart';

class DetailPage extends StatefulWidget {
  final Schedule schedule;

  // Diisi kalau halaman dibuka setelah ambil foto (belum disimpan)
  final Attendance? attendance;

  const DetailPage({super.key, required this.schedule, this.attendance});

  @override
  State<DetailPage> createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  late final List<String> asprakList;
  Attendance? data;
  final Set<String> present = {};

  // true = mode setelah foto, checklist bisa diubah & ada tombol simpan
  bool get isDraft => widget.attendance != null;

  @override
  void initState() {
    super.initState();
    asprakList = getAsprakForSchedule(widget.schedule);
    data = widget.attendance ?? findAttendanceBySchedule(widget.schedule.id);
    if (data != null) present.addAll(data!.presentAsprak);
  }

  void save() {
    final d = data!;
    dummyAttendances.add(
      Attendance(
        id: d.id,
        scheduleId: d.scheduleId,
        address: d.address,
        latitude: d.latitude,
        longitude: d.longitude,
        takenAt: d.takenAt,
        note: d.note,
        photoPath: d.photoPath,
        presentAsprak: present.toList(),
      ),
    );
    widget.schedule.attended = true;

    ScaffoldMessenger.of(
      context,
    ).showSnackBar(const SnackBar(content: Text('Presensi berhasil disimpan')));
    Navigator.pop(context, true);
  }

  @override
  Widget build(BuildContext context) {
    final s = widget.schedule;

    return Scaffold(
      backgroundColor: const Color(0xFFEFEFFF),
      appBar: AppBar(
        title: const Text('Detail Absen'),
        backgroundColor: Colors.transparent,
        elevation: 0,
        scrolledUnderElevation: 0,
      ),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Foto + judul
                    Row(
                      children: [
                        Container(
                          width: 100,
                          height: 100,
                          decoration: BoxDecoration(
                            color: Colors.blueGrey.shade100,
                            borderRadius: BorderRadius.circular(16),
                          ),
                          child: Icon(
                            data == null
                                ? Icons.no_photography_outlined
                                : Icons.photo_camera_outlined,
                            size: 36,
                            color: Colors.blueGrey,
                          ),
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                s.course,
                                style: const TextStyle(
                                  fontSize: 22,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Text(
                                s.room,
                                style: const TextStyle(color: Colors.blueGrey),
                              ),
                              const SizedBox(height: 4),
                              Text(
                                s.attended ? 'Hadir' : 'Tidak Hadir',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: s.attended ? Colors.green : Colors.red,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),

                    // Detail lokasi, waktu, minggu, dll
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Column(
                        children: [
                          InfoRow(
                            icon: Icons.location_on_outlined,
                            text: data?.address ?? 'Belum ada presensi',
                          ),
                          const SizedBox(height: 10),
                          InfoRow(
                            icon: Icons.my_location_outlined,
                            text: data == null
                                ? '-'
                                : 'Lat ${data!.latitude.toStringAsFixed(6)}, '
                                      'Long ${data!.longitude.toStringAsFixed(6)}',
                          ),
                          const SizedBox(height: 10),
                          InfoRow(
                            icon: Icons.calendar_today_outlined,
                            text: formatDate(s.date),
                          ),
                          const SizedBox(height: 10),
                          InfoRow(
                            icon: Icons.access_time,
                            text: '${s.timeRange} WIB',
                          ),
                          const SizedBox(height: 10),
                          InfoRow(
                            icon: Icons.how_to_reg_outlined,
                            text: data == null
                                ? '-'
                                : 'Presensi: ${formatDateTime(data!.takenAt)}',
                          ),
                          const SizedBox(height: 10),
                          InfoRow(
                            icon: Icons.date_range_outlined,
                            text: 'Minggu ${s.week}',
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 20),

                    // Daftar asprak (berdasarkan data jual/beli shift)
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Asprak hadir',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Color(0xFF1E40AF),
                            ),
                          ),
                          for (final name in asprakList)
                            CheckboxListTile(
                              value: present.contains(name),
                              onChanged: isDraft
                                  ? (value) {
                                      setState(() {
                                        if (value == true) {
                                          present.add(name);
                                        } else {
                                          present.remove(name);
                                        }
                                      });
                                    }
                                  : null,
                              title: Text(name),
                              controlAffinity: ListTileControlAffinity.leading,
                              contentPadding: EdgeInsets.zero,
                              dense: true,
                              activeColor: const Color(0xFF1E40AF),
                            ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 20),
                  ],
                ),
              ),
            ),
            if (isDraft)
              Padding(
                padding: const EdgeInsets.fromLTRB(24, 0, 24, 16),
                child: SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: save,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF1E40AF),
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.all(20),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    child: const Text(
                      'Simpan Presensi',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
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
