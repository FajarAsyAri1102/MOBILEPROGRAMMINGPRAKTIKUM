import 'package:flutter/material.dart';

import '../models/movie.dart';
import '../pages/movie_detail_page.dart';
import '../theme/app_theme.dart';
import 'poster_view.dart';

/// Kartu film horizontal (poster kiri, info kanan) untuk daftar.
/// [section] dipakai agar tag Hero unik di setiap bagian layar.
class MovieCard extends StatelessWidget {
  final Movie movie;
  final String section;

  const MovieCard({super.key, required this.movie, required this.section});

  @override
  Widget build(BuildContext context) {
    final tag = '$section-${movie.id}';
    return Card(
      color: AppColors.surface,
      elevation: 0,
      margin: EdgeInsets.zero,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: InkWell(
        borderRadius: BorderRadius.circular(16),
        onTap: () => openMovieDetail(context, movie, tag),
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Row(
            children: [
              Hero(
                tag: tag,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: SizedBox(
                    width: 80,
                    height: 120,
                    child: PosterView(movie: movie),
                  ),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: SizedBox(
                  height: 120,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            movie.title,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          const SizedBox(height: 2),
                          Text(
                            '${movie.genreText} • ${movie.year}',
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(
                              fontSize: 12,
                              color: AppColors.textMuted,
                            ),
                          ),
                          const SizedBox(height: 6),
                          Row(
                            children: [
                              const Icon(Icons.star_rounded,
                                  size: 16, color: AppColors.gold),
                              const SizedBox(width: 4),
                              Text(
                                movie.rating.toStringAsFixed(1),
                                style: const TextStyle(
                                    fontSize: 13, fontWeight: FontWeight.w600),
                              ),
                              const SizedBox(width: 10),
                              Text(
                                movie.durationText,
                                style: const TextStyle(
                                  fontSize: 12,
                                  color: AppColors.textMuted,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      Align(
                        alignment: Alignment.centerRight,
                        child: FilledButton(
                          style: FilledButton.styleFrom(
                            backgroundColor: AppColors.maroon,
                            foregroundColor: Colors.white,
                            minimumSize: const Size(0, 32),
                            padding:
                                const EdgeInsets.symmetric(horizontal: 14),
                          ),
                          onPressed: () =>
                              openMovieDetail(context, movie, tag),
                          child: const Text('Lihat Detail',
                              style: TextStyle(fontSize: 12)),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
