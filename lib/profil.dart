import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:universal_io/io.dart' as universal_io;
import 'package:navigator/main.dart';

class Profil extends StatefulWidget {
  const Profil({super.key});

  @override
  State<Profil> createState() => _ProfilState();
}

class _ProfilState extends State<Profil> {
  File? _imageFile;
  Uint8List? _webImage;
  final ImagePicker _picker = ImagePicker();

  @override
  void initState() {
    super.initState();
    _loadSavedImage();
  }

  Future<void> _pickImage() async {
    try {
      final picked = await _picker.pickImage(source: ImageSource.gallery);
      if (picked != null) {
        final bytes = await picked.readAsBytes();
        final prefs = await SharedPreferences.getInstance();
        await prefs.setString('profile_image', base64Encode(bytes));

        if (universal_io.Platform.isAndroid || universal_io.Platform.isIOS) {
          setState(() {
            _imageFile = File(picked.path);
            _webImage = null;
          });
        } else {
          setState(() {
            _webImage = bytes;
            _imageFile = null;
          });
        }
      }
    } catch (e) {
      debugPrint("Error picking image: $e");
    }
  }

  Future<void> _loadSavedImage() async {
    final prefs = await SharedPreferences.getInstance();
    final savedImage = prefs.getString('profile_image');
    if (savedImage != null) {
      final bytes = base64Decode(savedImage);
      if (universal_io.Platform.isAndroid || universal_io.Platform.isIOS) {
        final tempDir = Directory.systemTemp;
        final file = File('${tempDir.path}/saved_profile.png');
        await file.writeAsBytes(bytes);
        setState(() => _imageFile = file);
      } else {
        setState(() => _webImage = bytes);
      }
    }
  }

  Future<void> _removeImage() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('profile_image');
    setState(() {
      _imageFile = null;
      _webImage = null;
    });
  }

  @override
  Widget build(BuildContext context) {
    final profileImage = _imageFile != null
        ? FileImage(_imageFile!)
        : (_webImage != null ? MemoryImage(_webImage!) : null);

    return Scaffold(
      backgroundColor: const Color(0xFFF2F6FF),
      appBar: AppBar(
        title: const Text("Profil"),
        backgroundColor: const Color(0xFF3B82F6),
        foregroundColor: Colors.white,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Header profil
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
                children: [
                  GestureDetector(
                    onTap: _pickImage,
                    onLongPress: _removeImage,
                    child: CircleAvatar(
                      radius: 50,
                      backgroundColor: Colors.white,
                      backgroundImage: profileImage as ImageProvider?,
                      child: profileImage == null
                          ? const Icon(
                              Icons.person,
                              color: Color(0xFF3B82F6),
                              size: 60,
                            )
                          : null,
                    ),
                  ),
                  const SizedBox(height: 10),
                  const Text(
                    "Rasyiq Firmansyah",
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                    ),
                  ),
                  const SizedBox(height: 4),
                  const Text(
                    "NPM 23670015",
                    style: TextStyle(color: Colors.white70, fontSize: 14),
                  ),
                  const SizedBox(height: 8),
                  const Text(
                    "👆 Ketuk untuk ganti foto, tahan untuk hapus",
                    style: TextStyle(color: Colors.white70, fontSize: 12),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 24),

            // Info Mahasiswa
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Container(
                width: double.infinity,
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
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "Info Mahasiswa",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                        color: Color(0xFF3B82F6),
                      ),
                    ),
                    const SizedBox(height: 12),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: const [
                        Text(
                          "Prodi: ",
                          style: TextStyle(fontWeight: FontWeight.w600),
                        ),
                        Text("Informatika"),
                      ],
                    ),
                    const SizedBox(height: 8),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: const [
                        Text(
                          "Semester: ",
                          style: TextStyle(fontWeight: FontWeight.w600),
                        ),
                        Text("5"),
                      ],
                    ),
                    const SizedBox(height: 8),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: const [
                        Text(
                          "Email: ",
                          style: TextStyle(fontWeight: FontWeight.w600),
                        ),
                        Text("rasyiqfirmansyah16@gmail.com"),
                      ],
                    ),
                    const SizedBox(height: 8),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: const [
                        Text(
                          "No. HP: ",
                          style: TextStyle(fontWeight: FontWeight.w600),
                        ),
                        Text("+62 812-3456-7890"),
                      ],
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 24),

            // Info Section lainnya
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
                  Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(builder: (context) => const Home()),
                    (route) => false,
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
