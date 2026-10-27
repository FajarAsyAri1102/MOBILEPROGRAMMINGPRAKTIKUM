import 'package:flutter/material.dart';

import '../models/movie.dart';
import '../theme/app_theme.dart';
import '../widgets/genre_chip.dart';
import '../widgets/movie_card.dart';
import '../widgets/poster_view.dart';
import 'movie_detail_page.dart';
import 'movie_list_page.dart';

/// Halaman 1: Beranda (sapaan, pencarian, genre, populer, rilis terbaru).
class HomePage extends StatelessWidget {
  final List<Movie> movies;

  const HomePage({super.key, required this.movies});

  void _openList(BuildContext context, {String? genre, String query = ''}) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => MovieListPage(
          title: genre ?? 'Semua Film',
          movies: movies,
          initialGenre: genre,
          initialQuery: query,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final genres = Movie.allGenres(movies);
    final popular = movies.where((m) => m.isPopular).toList();
    final recent = [...movies]..sort((a, b) => b.year.compareTo(a.year));
    final width = MediaQuery.of(context).size.width;
    final cardWidth = (width * 0.38).clamp(130.0, 200.0);

    return Scaffold(
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.fromLTRB(16, 16, 16, 24),
          children: [
            // Header
            Row(
              children: [
                const Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Selamat Datang',
                          style: TextStyle(
                              fontSize: 24, fontWeight: FontWeight.w800)),
                      SizedBox(height: 4),
                      Text('Film apa yang ingin kamu tonton?',
                          style: TextStyle(color: AppColors.textMuted)),
                    ],
                  ),
                ),
                const CircleAvatar(
                  backgroundColor: AppColors.maroon,
                  child: Icon(Icons.movie_filter_rounded, color: Colors.white),
                ),
              ],
            ),
            const SizedBox(height: 16),

            // Pencarian
            TextField(
              textInputAction: TextInputAction.search,
              onSubmitted: (q) => _openList(context, query: q),
              decoration: InputDecoration(
                hintText: 'Cari judul film...',
                prefixIcon: const Icon(Icons.search_rounded),
                filled: true,
                fillColor: AppColors.surface,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(14),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
            const SizedBox(height: 16),

            // Genre
            SizedBox(
              height: 38,
              child: ListView.separated(
                scrollDirection: Axis.horizontal,
                itemCount: genres.length,
                separatorBuilder: (_, __) => const SizedBox(width: 8),
                itemBuilder: (_, i) => GenreChip(
                  label: genres[i],
                  onTap: () => _openList(context, genre: genres[i]),
                ),
              ),
            ),
            const SizedBox(height: 24),

            // Sedang Populer
            _SectionTitle(
              title: 'Sedang Populer',
              onSeeAll: () => _openList(context),
            ),
            const SizedBox(height: 12),
            SizedBox(
              height: cardWidth * 1.5 + 56,
              child: ListView.separated(
                scrollDirection: Axis.horizontal,
                itemCount: popular.length,
                separatorBuilder: (_, __) => const SizedBox(width: 12),
                itemBuilder: (_, i) => _PosterCard(
                  movie: popular[i],
                  width: cardWidth,
                ),
              ),
            ),
            const SizedBox(height: 24),

            // Rilis Terbaru
            const _SectionTitle(title: 'Rilis Terbaru'),
            const SizedBox(height: 12),
            for (final m in recent.take(5)) ...[
              MovieCard(movie: m, section: 'recent'),
              const SizedBox(height: 10),
            ],
          ],
        ),
      ),
    );
  }
}

class _SectionTitle extends StatelessWidget {
  final String title;
  final VoidCallback? onSeeAll;

  const _SectionTitle({required this.title, this.onSeeAll});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(title,
            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w700)),
        if (onSeeAll != null)
          TextButton(onPressed: onSeeAll, child: const Text('Lihat semua')),
      ],
    );
  }
}

class _PosterCard extends StatelessWidget {
  final Movie movie;
  final double width;

  const _PosterCard({required this.movie, required this.width});

  @override
  Widget build(BuildContext context) {
    final tag = 'popular-${movie.id}';
    return GestureDetector(
      onTap: () => openMovieDetail(context, movie, tag),
      child: SizedBox(
        width: width,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Hero(
                tag: tag,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(14),
                  child: PosterView(movie: movie, showTitle: true),
                ),
              ),
            ),
            const SizedBox(height: 8),
            Text(movie.title,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(fontWeight: FontWeight.w700)),
            const SizedBox(height: 2),
            Row(
              children: [
                const Icon(Icons.star_rounded,
                    size: 15, color: AppColors.gold),
                const SizedBox(width: 3),
                Text(movie.rating.toStringAsFixed(1),
                    style: const TextStyle(fontSize: 12)),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
