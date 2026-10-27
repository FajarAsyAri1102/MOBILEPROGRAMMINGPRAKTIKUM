import 'package:flutter/material.dart';

import '../models/movie.dart';

/// Menampilkan poster film. Jika file poster tidak ada, tampil
/// placeholder gradasi berwarna sesuai data film.
class PosterView extends StatelessWidget {
  final Movie movie;
  final bool showTitle;

  const PosterView({super.key, required this.movie, this.showTitle = false});

  @override
  Widget build(BuildContext context) {
    final base = Color(movie.color);
    final fallback = Container(
      width: double.infinity,
      height: double.infinity,
      padding: const EdgeInsets.all(8),
      alignment: Alignment.center,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [base, Color.lerp(base, Colors.black, 0.7)!],
        ),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            Icons.movie_creation_outlined,
            color: Colors.white70,
            size: showTitle ? 48 : 28,
          ),
          if (showTitle) ...[
            const SizedBox(height: 8),
            Text(
              movie.title,
              textAlign: TextAlign.center,
              maxLines: 3,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w700,
                fontSize: 15,
              ),
            ),
          ],
        ],
      ),
    );

    if (movie.poster.isEmpty) return fallback;
    return Image.asset(
      movie.poster,
      fit: BoxFit.cover,
      width: double.infinity,
      height: double.infinity,
      errorBuilder: (_, __, ___) => fallback,
    );
  }
}
