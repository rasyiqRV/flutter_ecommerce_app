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
            // 🔍 Search bar
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

            // 📂 Kategori
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

            // 🛍️ Banner Promo
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(16),
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    Image.network(
                      "https://tse4.mm.bing.net/th/id/OIP.sieZHgCUcf9KLD2HMdcU_gHaEc?pid=Api&P=0&h=220",
                      height: 150,
                      width: double.infinity,
                      fit: BoxFit.cover,
                      loadingBuilder: (context, child, loadingProgress) {
                        if (loadingProgress == null) return child;
                        return Container(
                          height: 150,
                          color: Colors.grey.shade300,
                          child: const Center(
                            child: CircularProgressIndicator(
                              color: Color(0xFF3B82F6),
                            ),
                          ),
                        );
                      },
                      errorBuilder: (context, error, stackTrace) {
                        return Container(
                          height: 150,
                          color: Colors.grey.shade200,
                          child: const Center(
                            child: Icon(
                              Icons.broken_image,
                              color: Colors.grey,
                              size: 40,
                            ),
                          ),
                        );
                      },
                    ),
                    Container(
                      height: 150,
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [
                            Colors.black.withOpacity(0.45),
                            Colors.transparent,
                          ],
                          begin: Alignment.bottomCenter,
                          end: Alignment.topCenter,
                        ),
                      ),
                    ),
                    const Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Promo Spesial Minggu Ini!",
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                          ),
                        ),
                        SizedBox(height: 6),
                        Text(
                          "Diskon hingga 70% untuk produk pilihan 🔥",
                          style: TextStyle(color: Colors.white70, fontSize: 14),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),

            // 🧢 Produk rekomendasi
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

            // 💡 Produk grid diperbaiki
            LayoutBuilder(
              builder: (context, constraints) {
                int crossAxisCount = 2;
                if (constraints.maxWidth > 1000) {
                  crossAxisCount = 5;
                } else if (constraints.maxWidth > 700) {
                  crossAxisCount = 4;
                } else if (constraints.maxWidth > 500) {
                  crossAxisCount = 3;
                }

                return GridView.builder(
                  itemCount: produkList.length,
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: crossAxisCount,
                    crossAxisSpacing: 12,
                    mainAxisSpacing: 12,
                    childAspectRatio: 0.72, // ✅ lebih ramping dan proporsional
                  ),
                  itemBuilder: (context, index) {
                    final produk = produkList[index];
                    return produkCard(
                      produk['nama']!,
                      produk['harga']!,
                      produk['gambar']!,
                    );
                  },
                );
              },
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  // 🔹 Data produk
  static final List<Map<String, String>> produkList = [
    {
      "nama": "Sneakers",
      "harga": "Rp 2.299.000",
      "gambar": "assets/images/sepatu_nike.jpeg",
    },
    {
      "nama": "Smartwatch",
      "harga": "Rp 499.000",
      "gambar": "assets/images/smartwacth.jpeg",
    },
    {
      "nama": "Headphone",
      "harga": "Rp 5.199.000",
      "gambar": "assets/images/iphone.jpeg",
    },
    {
      "nama": "Hoodie",
      "harga": "Rp 159.000",
      "gambar": "assets/images/hoodie.jpeg",
    },
  ];

  // 🔹 Produk card
  static Widget produkCard(String nama, String harga, String gambar) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.08),
            blurRadius: 6,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        children: [
          Expanded(
            flex: 7,
            child: ClipRRect(
              borderRadius: const BorderRadius.vertical(
                top: Radius.circular(14),
              ),
              child: AspectRatio(
                aspectRatio: 1, // biar gak gepeng
                child: Image.asset(
                  gambar,
                  fit: BoxFit.cover,
                  width: double.infinity,
                ),
              ),
            ),
          ),

          Expanded(
            flex: 3,
            child: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 10.0,
                vertical: 8.0,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    nama,
                    textAlign: TextAlign.center,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: Color(0xFF1E3A8A),
                    ),
                  ),
                  Text(
                    harga,
                    style: const TextStyle(
                      fontSize: 13,
                      color: Color(0xFF2563EB),
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  // 🔹 Kategori item
  static Widget kategoriItem(String nama, IconData icon, VoidCallback onTap) {
    return _AnimatedKategoriItem(nama: nama, icon: icon, onTap: onTap);
  }
}

// 🔹 Animasi kategori
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
              Icon(widget.icon, color: const Color(0xFF3B82F6), size: 28),
              const SizedBox(height: 8),
              Text(
                widget.nama,
                style: const TextStyle(
                  fontSize: 12,
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
