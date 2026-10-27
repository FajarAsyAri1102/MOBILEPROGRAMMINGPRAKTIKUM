import 'dart:convert';

import 'package:flutter/services.dart' show rootBundle;

import '../models/movie.dart';

/// Sumber data film.
/// Saat ini membaca file JSON lokal. Pada tahap berikutnya, ganti isi
/// [loadMovies] dengan permintaan HTTP ke API, misalnya:
///   final res = await http.get(Uri.parse('https://api.contoh.com/movies'));
///   final raw = res.body;
/// Bagian parsing ke [Movie] tidak perlu diubah.
class MovieRepository {
  Future<List<Movie>> loadMovies() async {
    final raw = await rootBundle.loadString('assets/data/movies.json');
    final data = jsonDecode(raw) as Map<String, dynamic>;
    return (data['movies'] as List)
        .map((e) => Movie.fromJson(e as Map<String, dynamic>))
        .toList();
  }
}
