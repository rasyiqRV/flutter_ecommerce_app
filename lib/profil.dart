import 'package:flutter/material.dart';
import 'package:navigator/main.dart';

class Profil extends StatelessWidget {
  const Profil({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF2F6FF),
      appBar: AppBar(
        title: const Text("Profil"),
        backgroundColor: const Color(0xFF3B82F6),
        foregroundColor: const Color.fromARGB(255, 0, 0, 0),
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Header dengan gradient dan avatar
            Container(
              width: double.infinity,
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  colors: [Color(0xFF3B82F6), Color(0xFF60A5FA)],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
              ),
              padding: const EdgeInsets.symmetric(vertical: 40),
              child: Column(
                children: const [
                  CircleAvatar(
                    radius: 45,
                    backgroundColor: Colors.white,
                    child: Icon(
                      Icons.person,
                      color: Color(0xFF3B82F6),
                      size: 60,
                    ),
                  ),
                  SizedBox(height: 12),
                  Text(
                    "Rasyiq Firmansyah",
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                    ),
                  ),
                  SizedBox(height: 4),
                  Text(
                    "rasyiqfirmansyah@email.com",
                    style: TextStyle(color: Colors.white70, fontSize: 14),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 24),

            // Info section
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.05),
                      blurRadius: 8,
                      offset: const Offset(0, 3),
                    ),
                  ],
                ),
                child: Column(
                  children: const [
                    ListTile(
                      leading: Icon(
                        Icons.shopping_bag,
                        color: Color(0xFF3B82F6),
                      ),
                      title: Text("Pesanan Saya"),
                      trailing: Icon(Icons.chevron_right),
                    ),
                    Divider(),
                    ListTile(
                      leading: Icon(
                        Icons.location_on,
                        color: Color(0xFF3B82F6),
                      ),
                      title: Text("Alamat Pengiriman"),
                      trailing: Icon(Icons.chevron_right),
                    ),
                    Divider(),
                    ListTile(
                      leading: Icon(Icons.payment, color: Color(0xFF3B82F6)),
                      title: Text("Metode Pembayaran"),
                      trailing: Icon(Icons.chevron_right),
                    ),
                    Divider(),
                    ListTile(
                      leading: Icon(
                        Icons.help_outline,
                        color: Color(0xFF3B82F6),
                      ),
                      title: Text("Pusat Bantuan"),
                      trailing: Icon(Icons.chevron_right),
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 24),

            // Tombol logout
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: ElevatedButton.icon(
                onPressed: () {
                  // Arahkan balik ke halaman utama di main.dart
                  Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(builder: (context) => const Home()),
                    (route) => false, // hapus semua rute sebelumnya
                  );
                },
                icon: const Icon(Icons.logout, color: Colors.white),
                label: const Text(
                  "Keluar",
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF3B82F6),
                  minimumSize: const Size(double.infinity, 50),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  elevation: 4,
                ),
              ),
            ),

            const SizedBox(height: 30),
          ],
        ),
      ),
    );
  }
}
