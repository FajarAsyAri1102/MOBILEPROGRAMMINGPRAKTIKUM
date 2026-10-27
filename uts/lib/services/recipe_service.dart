import 'dart:convert';
import 'package:flutter/services.dart' show rootBundle;
import '../models/recipe.dart';

/// Sumber data resep.
/// Tahap sekarang: membaca file JSON lokal.
/// Tahap berikutnya: ganti isi fetchRecipes() dengan http.get ke API,
/// bentuk datanya sama sehingga halaman lain tidak perlu diubah.
class RecipeService {
  Future<List<Recipe>> fetchRecipes() async {
    final raw = await rootBundle.loadString('assets/data/recipes.json');
    final data = jsonDecode(raw) as Map<String, dynamic>;
    return (data['recipes'] as List)
        .map((e) => Recipe.fromJson(e as Map<String, dynamic>))
        .toList();
  }
}
