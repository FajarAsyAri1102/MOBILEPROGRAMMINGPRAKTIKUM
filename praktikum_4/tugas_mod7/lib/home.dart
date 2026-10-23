import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF94A29),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              const Text(
                'Ini Halaman Tujuan',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              const Text(
                'Untuk berpindah ke halaman baru, gunakan metode Navigator.push(). '
                'Metode push() akan menambahkan Route ke dalam tumpukan Route '
                'yang dikelola oleh Navigator. Route ini dapat dibuat secara kustom '
                'atau menggunakan MaterialPageRoute, yang memiliki animasi transisi '
                'sesuai dengan platform yang digunakan.',
                style: TextStyle(color: Colors.white, fontSize: 14),
                textAlign: TextAlign.justify,
              ),
              Container(
                padding: const EdgeInsets.all(15),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(15),
                ),
                child: const Icon(Icons.beach_access, size: 100, color: Colors.black87),
              ),
              const Text(
                'Untuk menutup halaman kedua dan kembali ke halaman pertama, '
                'gunakan metode Navigator.pop(). Metode pop() akan menghapus '
                'Route saat ini dari tumpukan Route yang dikelola oleh Navigator.',
                style: TextStyle(color: Colors.white, fontSize: 14),
                textAlign: TextAlign.justify,
              ),
              ElevatedButton.icon(
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF0081C9),
                  foregroundColor: Colors.white,
                ),
                onPressed: () {
                  Navigator.pushNamed(context, '/tujuan');
                },
                icon: const Icon(Icons.arrow_back_ios, size: 15),
                label: const Text('Kembali ke home'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}