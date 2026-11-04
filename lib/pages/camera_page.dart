import 'package:flutter/material.dart';
import '../data/dummy_data.dart';
import '../models/attendance.dart';
import '../models/schedule.dart';
import '../utils/format.dart';
import 'detail_page.dart';

class CameraPage extends StatefulWidget {
  final Schedule schedule;

  const CameraPage({super.key, required this.schedule});

  @override
  State<CameraPage> createState() => _CameraPageState();
}

class _CameraPageState extends State<CameraPage> {
  bool flashOn = false;
  bool frontCamera = true;

  // Data presensi sementara (dummy) yang ditempel di foto
  late final Attendance draft = Attendance(
    id: 'A${dummyAttendances.length + 1}',
    scheduleId: widget.schedule.id,
    address: 'Telkom University, Bandung',
    latitude: -6.9733,
    longitude: 107.6303,
    takenAt: getNow(),
    note: 'Captured by IFCam',
    photoPath: '',
    presentAsprak: const [],
  );

  Future<void> takePhoto() async {
    final saved = await Navigator.push<bool>(
      context,
      MaterialPageRoute(
        builder: (context) =>
            DetailPage(schedule: widget.schedule, attendance: draft),
      ),
    );

    // Kalau presensi sudah disimpan, tutup kamera juga
    if (saved == true && mounted) {
      Navigator.pop(context, true);
    }
  }

  Widget buildGeofenceChip() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        color: Colors.green,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: const [
          Icon(Icons.check_circle, color: Colors.white, size: 18),
          SizedBox(width: 8),
          Text(
            'Di dalam area IFLAB • $dummyDistanceMeter m',
            style: TextStyle(color: Colors.white, fontSize: 13),
          ),
        ],
      ),
    );
  }

  Widget buildOverlay() {
    return Container(
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: Colors.black54,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 90,
            height: 90,
            decoration: BoxDecoration(
              color: Colors.green.shade800,
              borderRadius: BorderRadius.circular(8),
            ),
            child: const Icon(Icons.location_on, color: Colors.red, size: 36),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  draft.address,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  'Lat ${draft.latitude.toStringAsFixed(6)} '
                  'Long ${draft.longitude.toStringAsFixed(6)}',
                  style: const TextStyle(color: Colors.white70, fontSize: 11),
                ),
                Text(
                  formatDateTime(draft.takenAt),
                  style: const TextStyle(color: Colors.white70, fontSize: 11),
                ),
                Text(
                  draft.note,
                  style: const TextStyle(color: Colors.white70, fontSize: 11),
                ),
                const Align(
                  alignment: Alignment.centerRight,
                  child: Text(
                    'IFCam',
                    style: TextStyle(
                      color: Colors.amber,
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              child: Row(
                children: [
                  IconButton(
                    onPressed: () => Navigator.pop(context),
                    icon: const Icon(Icons.arrow_back, color: Colors.white),
                  ),
                  const Spacer(),
                  IconButton(
                    onPressed: () => setState(() => flashOn = !flashOn),
                    icon: Icon(
                      flashOn ? Icons.flash_on : Icons.flash_off,
                      color: Colors.white,
                    ),
                  ),
                  IconButton(
                    onPressed: () => setState(() => frontCamera = !frontCamera),
                    icon: const Icon(Icons.cameraswitch, color: Colors.white),
                  ),
                ],
              ),
            ),
            Expanded(
              child: Stack(
                children: [
                  Container(
                    width: double.infinity,
                    decoration: const BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [Color(0xFF555555), Color(0xFF111111)],
                      ),
                    ),
                    child: Center(
                      child: Text(
                        frontCamera
                            ? 'Pratinjau kamera depan\n(data dummy)'
                            : 'Pratinjau kamera belakang\n(data dummy)',
                        textAlign: TextAlign.center,
                        style: const TextStyle(color: Colors.white54),
                      ),
                    ),
                  ),
                  Positioned(top: 12, left: 12, child: buildGeofenceChip()),
                  Positioned(
                    bottom: 12,
                    left: 12,
                    right: 12,
                    child: buildOverlay(),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 24),
              child: GestureDetector(
                onTap: takePhoto,
                child: Container(
                  width: 76,
                  height: 76,
                  padding: const EdgeInsets.all(5),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(color: Colors.white, width: 4),
                  ),
                  child: Container(
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.white,
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
