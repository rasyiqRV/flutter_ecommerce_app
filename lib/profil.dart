import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:universal_io/io.dart' as universal_io;
import 'package:navigator/main.dart'; // Sesuaikan path import ini jika berbeda

class Profil extends StatefulWidget {
  const Profil({super.key});

  @override
  State<Profil> createState() => _ProfilState();
}

class _ProfilState extends State<Profil> {
  // Variabel untuk gambar profil
  File? _imageFile;
  Uint8List? _webImage;
  final ImagePicker _picker = ImagePicker();

  // Variabel untuk Info Mahasiswa (Stateful)
  String _prodi = 'Informatika';
  String _semester = '5';
  String _email = 'rasyiqfirmansyah16@gmail.com';
  String _noHp = '+62 812-3456-7890';

  final List<String> _prodiList = ['Informatika', 'Mesin', 'Sipil', 'Arsitek'];

  @override
  void initState() {
    super.initState();
    _loadSavedImage();
    _loadProfileData();
  }

  // --- Fungsi Load/Save/Remove Image ---

  Future<void> _loadProfileData() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      _prodi = prefs.getString('prodi') ?? 'Informatika';
      _semester = prefs.getString('semester') ?? '5';
      _email = prefs.getString('email') ?? 'rasyiqfirmansyah16@gmail.com';
      _noHp = prefs.getString('noHp') ?? '+62 812-3456-7890';
    });
  }

  Future<void> _pickImage() async {
    // ... (kode _pickImage yang sudah ada)
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
    // ... (kode _loadSavedImage yang sudah ada)
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
    // ... (kode _removeImage yang sudah ada)
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('profile_image');
    setState(() {
      _imageFile = null;
      _webImage = null;
    });
  }

  // --- Fungsi Edit Modal ---

  void _showEditModal() {
    // Inisialisasi controller dengan data saat ini
    String tempProdi = _prodi;
    String tempSemester = _semester;
    final TextEditingController emailController = TextEditingController(
      text: _email,
    );
    final TextEditingController noHpController = TextEditingController(
      text: _noHp,
    );

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Edit Info Mahasiswa'),
          content: SingleChildScrollView(
            child: StatefulBuilder(
              builder: (BuildContext context, StateSetter setModalState) {
                return Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    // Field Prodi (Dropdown)
                    DropdownButtonFormField<String>(
                      decoration: const InputDecoration(
                        labelText: 'Prodi',
                        border: OutlineInputBorder(),
                        contentPadding: EdgeInsets.symmetric(
                          horizontal: 10,
                          vertical: 8,
                        ),
                      ),
                      hint: const Text('Pilih Prodi'),
                      value: tempProdi,
                      items: List.from(
                        _prodiList.map((p) {
                          // <-- Perubahan ada di sini: List.from(...)
                          return DropdownMenuItem(value: p, child: Text(p));
                        }),
                      ), // Menghilangkan .toList() dan menggantinya dengan List.from
                      onChanged: (v) => setModalState(() => tempProdi = v!),
                    ),
                    const SizedBox(height: 12),
                    // Field Semester
                    TextFormField(
                      decoration: const InputDecoration(
                        labelText: 'Semester',
                        border: OutlineInputBorder(),
                        contentPadding: EdgeInsets.symmetric(
                          horizontal: 10,
                          vertical: 8,
                        ),
                      ),
                      initialValue: tempSemester,
                      keyboardType: TextInputType.number,
                      onChanged: (v) => tempSemester = v,
                    ),
                    const SizedBox(height: 12),
                    // Field Email
                    TextField(
                      controller: emailController,
                      decoration: const InputDecoration(
                        labelText: 'Email',
                        border: OutlineInputBorder(),
                        contentPadding: EdgeInsets.symmetric(
                          horizontal: 10,
                          vertical: 8,
                        ),
                      ),
                      keyboardType: TextInputType.emailAddress,
                    ),
                    const SizedBox(height: 12),
                    // Field No. HP
                    TextField(
                      controller: noHpController,
                      decoration: const InputDecoration(
                        labelText: 'No. HP',
                        border: OutlineInputBorder(),
                        contentPadding: EdgeInsets.symmetric(
                          horizontal: 10,
                          vertical: 8,
                        ),
                      ),
                      keyboardType: TextInputType.phone,
                    ),
                  ],
                );
              },
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('Batal'),
            ),
            ElevatedButton(
              onPressed: () async {
                // Simpan perubahan ke State dan SharedPreferences
                final prefs = await SharedPreferences.getInstance();
                await prefs.setString('prodi', tempProdi);
                await prefs.setString('semester', tempSemester);
                await prefs.setString('email', emailController.text.trim());
                await prefs.setString('noHp', noHpController.text.trim());

                setState(() {
                  _prodi = tempProdi;
                  _semester = tempSemester;
                  _email = emailController.text.trim();
                  _noHp = noHpController.text.trim();
                });

                Navigator.of(context).pop(); // Tutup dialog
              },
              child: const Text('Simpan'),
            ),
          ],
        );
      },
    );
  }

  // --- Widget Build ---

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
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          "Info Mahasiswa",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                            color: Color(0xFF3B82F6),
                          ),
                        ),
                        // Tombol Edit Baru
                        GestureDetector(
                          onTap: _showEditModal,
                          child: const Icon(
                            Icons.edit,
                            color: Color(0xFF3B82F6),
                            size: 20,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 12),
                    _buildInfoRow("Prodi:", _prodi),
                    const SizedBox(height: 8),
                    _buildInfoRow("Semester:", _semester),
                    const SizedBox(height: 8),
                    _buildInfoRow("Email:", _email),
                    const SizedBox(height: 8),
                    _buildInfoRow("No. HP:", _noHp),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 24),

            // Info Section lainnya (Pesanan Saya, Alamat, dll.)
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

  // Widget bantu untuk baris info
  Widget _buildInfoRow(String label, String value) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(label, style: const TextStyle(fontWeight: FontWeight.w600)),
        Text(value),
      ],
    );
  }
}
