import 'package:flutter/material.dart';
import '../data/dummy_data.dart';
import 'camera_page.dart';
import 'history_page.dart';
import 'home_page.dart';
import 'profile_page.dart';
import 'shift_page.dart';

class MainShell extends StatefulWidget {
  const MainShell({super.key});

  @override
  State<MainShell> createState() => _MainShellState();
}

class _MainShellState extends State<MainShell> {
  int _selectedIndex = 0;

  void showMessage(String text) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(text)));
  }

  Future<void> openCamera() async {
    final active = getActiveSchedule();

    if (active == null) {
      showMessage('Belum ada sesi yang sedang berlangsung');
      return;
    }
    if (active.attended) {
      showMessage('Kamu sudah presensi di sesi ini');
      return;
    }
    if (!dummyInsideArea) {
      showMessage('Kamu berada di luar area IFLAB ($dummyDistanceMeter m)');
      return;
    }

    await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => CameraPage(schedule: active)),
    );

    if (mounted) setState(() {});
  }

  Widget navItem(int index, IconData icon, String label) {
    final selected = _selectedIndex == index;
    final color = selected ? const Color(0xFF1E40AF) : Colors.grey;

    return Expanded(
      child: InkWell(
        onTap: () => setState(() => _selectedIndex = index),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, color: color),
            Text(label, style: TextStyle(fontSize: 11, color: color)),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final pages = [HomePage(), ShiftPage(), HistoryPage(), ProfilePage()];

    return Scaffold(
      backgroundColor: const Color(0xFFEFEFFF),
      body: pages[_selectedIndex],
      floatingActionButton: FloatingActionButton(
        onPressed: openCamera,
        backgroundColor: const Color(0xFF1E40AF),
        shape: const CircleBorder(),
        child: const Icon(Icons.camera_alt, color: Colors.white),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: BottomAppBar(
        color: Colors.white,
        height: 64,
        padding: EdgeInsets.zero,
        shape: const CircularNotchedRectangle(),
        notchMargin: 8,
        child: Row(
          children: [
            navItem(0, Icons.home, 'Home'),
            navItem(1, Icons.swap_horiz, 'Jual/Beli'),
            const Expanded(child: SizedBox()), // ruang untuk tombol kamera
            navItem(2, Icons.history, 'Riwayat'),
            navItem(3, Icons.person, 'Akun'),
          ],
        ),
      ),
    );
  }
}
