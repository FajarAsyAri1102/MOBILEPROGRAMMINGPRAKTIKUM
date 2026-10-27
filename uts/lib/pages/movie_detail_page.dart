import 'package:flutter/material.dart';

import '../models/movie.dart';
import '../state/favorites_store.dart';
import '../theme/app_theme.dart';
import '../widgets/genre_chip.dart';
import '../widgets/poster_view.dart';

/// Membuka halaman detail dengan Navigator.push.
void openMovieDetail(BuildContext context, Movie movie, String heroTag) {
  Navigator.push(
    context,
    MaterialPageRoute(
      builder: (_) => MovieDetailPage(movie: movie, heroTag: heroTag),
    ),
  );
}

/// Halaman 3: Detail film.
class MovieDetailPage extends StatelessWidget {
  final Movie movie;
  final String heroTag;

  const MovieDetailPage({super.key, required this.movie, required this.heroTag});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: 380,
            pinned: true,
            actions: [
              ValueListenableBuilder<Set<int>>(
                valueListenable: FavoritesStore.ids,
                builder: (context, ids, _) {
                  final fav = ids.contains(movie.id);
                  return IconButton(
                    tooltip: fav ? 'Hapus dari favorit' : 'Tambah ke favorit',
                    icon: Icon(
                      fav ? Icons.favorite : Icons.favorite_border,
                      color: fav ? Colors.redAccent : Colors.white,
                    ),
                    onPressed: () => FavoritesStore.toggle(movie.id),
                  );
                },
              ),
            ],
            flexibleSpace: FlexibleSpaceBar(
              background: Hero(
                tag: heroTag,
                child: PosterView(movie: movie, showTitle: true),
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(movie.title,
                      style: const TextStyle(
                          fontSize: 26, fontWeight: FontWeight.w800)),
                  const SizedBox(height: 10),
                  Row(
                    children: [
                      const Icon(Icons.star_rounded,
                          color: AppColors.gold, size: 20),
                      const SizedBox(width: 4),
                      Text(movie.rating.toStringAsFixed(1),
                          style: const TextStyle(fontWeight: FontWeight.w700)),
                      const SizedBox(width: 16),
                      const Icon(Icons.schedule_rounded,
                          color: AppColors.textMuted, size: 18),
                      const SizedBox(width: 4),
                      Text(movie.durationText,
                          style: const TextStyle(color: AppColors.textMuted)),
                      const SizedBox(width: 16),
                      const Icon(Icons.calendar_today_rounded,
                          color: AppColors.textMuted, size: 16),
                      const SizedBox(width: 4),
                      Text('${movie.year}',
                          style: const TextStyle(color: AppColors.textMuted)),
                    ],
                  ),
                  const SizedBox(height: 14),
                  Wrap(
                    spacing: 8,
                    runSpacing: 8,
                    children: [
                      for (final g in movie.genres)
                        GenreChip(label: g, selected: true),
                    ],
                  ),
                  const SizedBox(height: 20),
                  const _Heading('Sinopsis'),
                  const SizedBox(height: 6),
                  Text(movie.synopsis,
                      style: const TextStyle(height: 1.5, fontSize: 15)),
                  const SizedBox(height: 20),
                  const _Heading('Sutradara'),
                  const SizedBox(height: 6),
                  Text(movie.director, style: const TextStyle(fontSize: 15)),
                  const SizedBox(height: 20),
                  const _Heading('Pemeran'),
                  const SizedBox(height: 8),
                  Wrap(
                    spacing: 8,
                    runSpacing: 8,
                    children: [
                      for (final c in movie.cast) GenreChip(label: c),
                    ],
                  ),
                  const SizedBox(height: 24),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _Heading extends StatelessWidget {
  final String text;
  const _Heading(this.text);

  @override
  Widget build(BuildContext context) => Text(
        text,
        style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w700),
      );
}
