import 'package:flutter/material.dart';
import 'package:navigator/profil.dart';
import 'package:navigator/elektronik.dart';
import 'package:navigator/fashion.dart';
import 'package:navigator/makanan.dart';
import 'package:navigator/kecantikan.dart';
import 'package:navigator/olahraga.dart';

class Halaman_Utama extends StatelessWidget {
  const Halaman_Utama({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF2F6FF),
      appBar: AppBar(
        title: const Text(
          "ShopEase",
          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
        ),
        centerTitle: true,
        backgroundColor: const Color(0xFF3B82F6),
        elevation: 0,
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 12),
            child: GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const Profil()),
                );
              },
              child: const CircleAvatar(
                radius: 18,
                backgroundColor: Colors.white,
                child: Icon(Icons.person, color: Color(0xFF3B82F6), size: 22),
              ),
            ),
          ),
        ],
      ),

      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Search bar
            Container(
              color: const Color(0xFF3B82F6),
              padding: const EdgeInsets.all(16),
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: const TextField(
                  decoration: InputDecoration(
                    hintText: "Cari produk...",
                    border: InputBorder.none,
                    icon: Icon(Icons.search, color: Colors.grey),
                  ),
                ),
              ),
            ),

            // Kategori
            const Padding(
              padding: EdgeInsets.all(16),
              child: Text(
                "Kategori Pilihan",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF1E3A8A),
                ),
              ),
            ),
            SizedBox(
              height: 90,
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: [
                  kategoriItem("Elektronik", Icons.devices, () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const Elektronik(),
                      ),
                    );
                  }),
                  kategoriItem("Fashion", Icons.checkroom, () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const Fashion()),
                    );
                  }),
                  kategoriItem("Makanan", Icons.fastfood, () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const Makanan()),
                    );
                  }),
                  kategoriItem("Kecantikan", Icons.brush, () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const Kecantikan(),
                      ),
                    );
                  }),
                  kategoriItem("Olahraga", Icons.fitness_center, () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const Olahraga()),
                    );
                  }),
                ],
              ),
            ),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: Container(
                height: 120,
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [Color(0xFF60A5FA), Color(0xFF2563EB)],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderRadius: BorderRadius.circular(16),
                ),
                child: const Center(
                  child: Text(
                    "Promo Spesial Minggu Ini!",
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                    ),
                  ),
                ),
              ),
            ),

            // Produk rekomendasi
            const Padding(
              padding: EdgeInsets.all(16),
              child: Text(
                "Rekomendasi Untukmu",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF1E3A8A),
                ),
              ),
            ),
            GridView.count(
              crossAxisCount: 2,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              childAspectRatio: 0.8,
              children: [
                produkCard("Sneakers", "Rp 299.000"),
                produkCard("Smartwatch", "Rp 499.000"),
                produkCard("Headphone", "Rp 199.000"),
                produkCard("Hoodie", "Rp 159.000"),
              ],
            ),
          ],
        ),
      ),
    );
  }

  // Kategori item dengan animasi hover & tap
  static Widget kategoriItem(String nama, IconData icon, VoidCallback onTap) {
    return _AnimatedKategoriItem(nama: nama, icon: icon, onTap: onTap);
  }

  static Widget produkCard(String nama, String harga) {
    return Container(
      margin: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 6,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Icon(Icons.shopping_bag, size: 40, color: Color(0xFF3B82F6)),
            const SizedBox(height: 16),
            Text(
              nama,
              style: const TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.w600,
                color: Color(0xFF1E3A8A),
              ),
            ),
            const SizedBox(height: 6),
            Text(
              harga,
              style: const TextStyle(
                fontSize: 14,
                color: Color(0xFF2563EB),
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// Widget kategori dengan animasi hover + tap
class _AnimatedKategoriItem extends StatefulWidget {
  final String nama;
  final IconData icon;
  final VoidCallback onTap;

  const _AnimatedKategoriItem({
    required this.nama,
    required this.icon,
    required this.onTap,
  });

  @override
  State<_AnimatedKategoriItem> createState() => _AnimatedKategoriItemState();
}

class _AnimatedKategoriItemState extends State<_AnimatedKategoriItem> {
  bool _hovered = false;
  bool _pressed = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _hovered = true),
      onExit: (_) => setState(() => _hovered = false),
      child: GestureDetector(
        onTapDown: (_) => setState(() => _pressed = true),
        onTapUp: (_) {
          setState(() => _pressed = false);
          widget.onTap();
        },
        onTapCancel: () => setState(() => _pressed = false),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          margin: const EdgeInsets.only(left: 12),
          width: 90,
          transform: Matrix4.identity()
            ..scale(
              _pressed
                  ? 0.95
                  : _hovered
                  ? 1.05
                  : 1.0,
            ),
          decoration: BoxDecoration(
            color: _hovered ? const Color(0xFFDBEAFE) : const Color(0xFFE0E7FF),
            borderRadius: BorderRadius.circular(16),
            boxShadow: _hovered
                ? [
                    BoxShadow(
                      color: Colors.blue.withOpacity(0.3),
                      blurRadius: 10,
                      offset: const Offset(0, 4),
                    ),
                  ]
                : [],
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(widget.icon, color: const Color(0xFF3B82F6), size: 30),
              const SizedBox(height: 8),
              Text(
                widget.nama,
                style: const TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w500,
                  color: Color(0xFF1E3A8A),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
