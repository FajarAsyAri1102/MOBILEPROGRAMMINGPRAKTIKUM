import 'package:flutter/material.dart';
import '../models/recipe.dart';
import '../services/favorite_store.dart';
import '../theme/app_theme.dart';
import '../widgets/recipe_card.dart';

/// Daftar resep yang ditandai favorit oleh pengguna.
class FavoritePage extends StatelessWidget {
  final List<Recipe> recipes;
  const FavoritePage({super.key, required this.recipes});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Resep favorit',
            style: TextStyle(fontWeight: FontWeight.w600)),
        backgroundColor: AppColors.kertas,
        surfaceTintColor: Colors.transparent,
      ),
      body: ValueListenableBuilder<Set<int>>(
        valueListenable: FavoriteStore.ids,
        builder: (context, ids, _) {
          final favs = recipes.where((r) => ids.contains(r.id)).toList();
          if (favs.isEmpty) {
            return Center(
              child: Padding(
                padding: const EdgeInsets.all(32),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Icon(Icons.favorite_border,
                        size: 48, color: AppColors.abuHangat),
                    const SizedBox(height: 12),
                    Text('Belum ada resep favorit',
                        style: Theme.of(context).textTheme.titleSmall),
                    const SizedBox(height: 4),
                    Text(
                      'Ketuk ikon hati di halaman resep untuk menyimpannya di sini.',
                      textAlign: TextAlign.center,
                      style: Theme.of(context)
                          .textTheme
                          .bodySmall
                          ?.copyWith(color: AppColors.abuHangat),
                    ),
                  ],
                ),
              ),
            );
          }
          return ListView.separated(
            padding: const EdgeInsets.all(20),
            itemCount: favs.length,
            separatorBuilder: (_, __) => const SizedBox(height: 12),
            itemBuilder: (_, i) => RecipeCard(recipe: favs[i]),
          );
        },
      ),
    );
  }
}
