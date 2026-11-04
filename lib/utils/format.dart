const _days = ['Senin', 'Selasa', 'Rabu', 'Kamis', 'Jumat', 'Sabtu', 'Minggu'];

String twoDigits(int n) => n.toString().padLeft(2, '0');

// Contoh: Kamis, 5/11/2026
String formatDate(DateTime d) =>
    '${_days[d.weekday - 1]}, ${d.day}/${d.month}/${d.year}';

// Contoh: 07.30
String formatTime(DateTime d) => '${twoDigits(d.hour)}.${twoDigits(d.minute)}';

// Contoh: Kamis, 5/11/2026 07.30 WIB
String formatDateTime(DateTime d) => '${formatDate(d)} ${formatTime(d)} WIB';
