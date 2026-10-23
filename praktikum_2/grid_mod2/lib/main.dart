import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Tugas Row & Column',
      home: Scaffold(
        appBar: AppBar(title: const Text('Grid 2x2 Favorite')),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  itemKotak(Colors.red, "Suka 1"),
                  const SizedBox(width: 20),
                  itemKotak(Colors.purple, "Suka 2"),
                ],
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  itemKotak(Colors.orange, "Suka 3"),
                  const SizedBox(width: 20),
                  itemKotak(Colors.teal, "Suka 4"),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget itemKotak(Color warna, String label) {
    return Container(
      width: 100,
      height: 100,
      decoration: BoxDecoration(
        color: warna,
        border: Border.all(color: Colors.black, width: 2),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(
            Icons.favorite,
            color: Colors.red,
            size: 40,
          ),
          const SizedBox(height: 5),
          Text(
            label,
            style: const TextStyle(color: Colors.white),
          ),
        ],
      ),
    );
  }
}