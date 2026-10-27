import 'package:flutter/material.dart';

import '../models/movie.dart';
import '../state/favorites_store.dart';
import '../theme/app_theme.dart';
import '../widgets/movie_card.dart';

/// Daftar film yang ditandai favorit (tab ke-3).
class FavoritesPage extends StatelessWidget {
  final List<Movie> movies;

  const FavoritesPage({super.key, required this.movies});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Film Favorit')),
      body: ValueListenableBuilder<Set<int>>(
        valueListenable: FavoritesStore.ids,
        builder: (context, ids, _) {
          final favs = movies.where((m) => ids.contains(m.id)).toList();
          if (favs.isEmpty) {
            return const Center(
              child: Padding(
                padding: EdgeInsets.all(24),
                child: Text(
                  'Belum ada favorit.\nTekan ikon hati di halaman detail film.',
                  textAlign: TextAlign.center,
                  style: TextStyle(color: AppColors.textMuted),
                ),
              ),
            );
          }
          return ListView.separated(
            padding: const EdgeInsets.all(16),
            itemCount: favs.length,
            separatorBuilder: (_, __) => const SizedBox(height: 10),
            itemBuilder: (_, i) => MovieCard(movie: favs[i], section: 'fav'),
          );
        },
      ),
    );
  }
}
