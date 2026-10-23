import 'package:flutter/material.dart';

class TujuanPage extends StatelessWidget {
  const TujuanPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0081C9),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              const Text(
                'Ini Halaman Home',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              const Text(
                'Banyak aplikasi memiliki beberapa layar untuk menampilkan informasi '
                'yang berbeda. Contohnya, ada layar produk, dan ketika pengguna '
                'mengklik produk, akan muncul layar dengan detail produk tersebut.',
                style: TextStyle(color: Colors.white, fontSize: 14),
                textAlign: TextAlign.justify,
              ),
              Container(
                padding: const EdgeInsets.all(15),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(15),
                ),
                child: const Icon(Icons.home, size: 100, color: Colors.black87),
              ),
              const Text(
                'Pertama, kita perlu membuat dua halaman atau "routes" yang ingin kita '
                'tampilkan. Selanjutnya, kita gunakan perintah Navigator.push() untuk '
                'berpindah dari halaman pertama ke halaman kedua. Ini seperti kita membuka '
                'halaman baru. Terakhir, kita bisa kembali dari halaman kedua ke halaman '
                'pertama menggunakan Navigator.pop(). Seperti menutup halaman kedua '
                'dan kembali ke halaman pertama.',
                style: TextStyle(color: Colors.white, fontSize: 14),
                textAlign: TextAlign.justify,
              ),
              ElevatedButton.icon(
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFFF94A29),
                  foregroundColor: Colors.white,
                ),
                onPressed: () {
                  Navigator.pop(context);
                },
                label: const Text('Ke Halaman tujuan'),
                icon: const Icon(Icons.arrow_forward_ios, size: 15),
              ),
            ],
          ),
        ),
      ),
    );
  }
}