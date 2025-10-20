import 'package:flutter/material.dart';
import 'package:navigator/profil.dart';

class Makanan extends StatelessWidget {
  const Makanan({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF2F6FF),
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () {
            Navigator.pop(context); // balik ke beranda
          },
        ),
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
      body: const Center(
        child: Text(
          "Daftar Produk Makanan",
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w500,
            color: Colors.black87,
          ),
        ),
      ),
    );
  }
}
