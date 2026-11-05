import 'package:flutter/material.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  bool isEditing = false;

  String name = 'John Doe';
  String nim = '103022400000';
  String email = 'doe@iflab.ac.id';
  String phone = '081234567890';

  late TextEditingController nameController;
  late TextEditingController nimController;
  late TextEditingController emailController;
  late TextEditingController phoneController;

  @override
  void initState() {
    super.initState();
    nameController = TextEditingController(text: name);
    nimController = TextEditingController(text: nim);
    emailController = TextEditingController(text: email);
    phoneController = TextEditingController(text: phone);
  }

  @override
  void dispose() {
    nameController.dispose();
    nimController.dispose();
    emailController.dispose();
    phoneController.dispose();
    super.dispose();
  }

  void resetControllers() {
    nameController.text = name;
    nimController.text = nim;
    emailController.text = email;
    phoneController.text = phone;
  }

  void saveProfile() {
    setState(() {
      name = nameController.text;
      nim = nimController.text;
      email = emailController.text;
      phone = phoneController.text;
      isEditing = false;
    });
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(const SnackBar(content: Text('Profil berhasil disimpan')));
  }

  void cancelEdit() {
    setState(() {
      resetControllers();
      isEditing = false;
    });
  }

  Widget buildInfo(String label, String value, IconData icon) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Row(
        children: [
          Icon(icon, color: Colors.blueGrey),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  style: const TextStyle(fontSize: 12, color: Colors.blueGrey),
                ),
                Text(
                  value,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget buildField(
    String label,
    TextEditingController controller,
    IconData icon,
  ) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(label, style: const TextStyle(fontWeight: FontWeight.bold)),
          const SizedBox(height: 8),
          TextField(
            controller: controller,
            decoration: InputDecoration(
              prefixIcon: Icon(icon, color: Colors.blueGrey),
              filled: true,
              fillColor: const Color(0xFFEFEFFF),
              border: OutlineInputBorder(
                borderSide: BorderSide.none,
                borderRadius: BorderRadius.circular(10),
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(
          children: [
            const CircleAvatar(
              radius: 50,
              backgroundColor: Color(0xFF1E40AF),
              backgroundImage: AssetImage("/img/radit_tani.jpg"),
            ),
            const SizedBox(height: 16),
            Text(
              name,
              style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            const Text(
              'Asisten Praktikum IFLAB',
              style: TextStyle(color: Colors.blueGrey),
            ),
            const SizedBox(height: 24),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
              ),
              child: isEditing
                  ? Column(
                      children: [
                        buildField(
                          'Nama',
                          nameController,
                          Icons.person_outline,
                        ),
                        buildField('NIM', nimController, Icons.badge_outlined),
                        buildField(
                          'Email',
                          emailController,
                          Icons.alternate_email_outlined,
                        ),
                        buildField(
                          'No. HP',
                          phoneController,
                          Icons.phone_outlined,
                        ),
                      ],
                    )
                  : Column(
                      children: [
                        buildInfo('Nama', name, Icons.person_outline),
                        buildInfo('NIM', nim, Icons.badge_outlined),
                        buildInfo(
                          'Email',
                          email,
                          Icons.alternate_email_outlined,
                        ),
                        buildInfo('No. HP', phone, Icons.phone_outlined),
                      ],
                    ),
            ),
            const SizedBox(height: 24),
            isEditing
                ? Row(
                    children: [
                      Expanded(
                        child: OutlinedButton(
                          onPressed: cancelEdit,
                          style: OutlinedButton.styleFrom(
                            padding: const EdgeInsets.all(20),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                          child: const Text('Batal'),
                        ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: ElevatedButton(
                          onPressed: saveProfile,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFF1E40AF),
                            foregroundColor: Colors.white,
                            padding: const EdgeInsets.all(20),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                          child: const Text('Simpan'),
                        ),
                      ),
                    ],
                  )
                : SizedBox(
                    width: double.infinity,
                    child: ElevatedButton.icon(
                      onPressed: () {
                        setState(() {
                          isEditing = true;
                        });
                      },
                      icon: const Icon(Icons.edit_outlined),
                      label: const Text('Edit Profil'),
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
