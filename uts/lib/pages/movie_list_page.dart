import 'package:flutter/material.dart';

import '../models/movie.dart';
import '../theme/app_theme.dart';
import '../widgets/genre_chip.dart';
import '../widgets/movie_card.dart';

/// Halaman 2: Daftar film dengan filter genre dan pencarian.
/// Responsif: ListView di layar sempit, GridView di layar lebar.
class MovieListPage extends StatefulWidget {
  final String title;
  final List<Movie> movies;
  final String? initialGenre;
  final String initialQuery;

  const MovieListPage({
    super.key,
    required this.title,
    required this.movies,
    this.initialGenre,
    this.initialQuery = '',
  });

  @override
  State<MovieListPage> createState() => _MovieListPageState();
}

class _MovieListPageState extends State<MovieListPage> {
  static const _all = 'Semua';

  late String _genre = widget.initialGenre ?? _all;
  late String _query = widget.initialQuery;
  late final TextEditingController _controller =
      TextEditingController(text: widget.initialQuery);

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final genres = [_all, ...Movie.allGenres(widget.movies)];
    final filtered = widget.movies.where((m) {
      final okGenre = _genre == _all || m.genres.contains(_genre);
      final okQuery =
          m.title.toLowerCase().contains(_query.trim().toLowerCase());
      return okGenre && okQuery;
    }).toList();

    return Scaffold(
      appBar: AppBar(title: Text(widget.title)),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 4, 16, 12),
            child: TextField(
              controller: _controller,
              onChanged: (v) => setState(() => _query = v),
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
          ),
          SizedBox(
            height: 38,
            child: ListView.separated(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              scrollDirection: Axis.horizontal,
              itemCount: genres.length,
              separatorBuilder: (_, __) => const SizedBox(width: 8),
              itemBuilder: (_, i) => GenreChip(
                label: genres[i],
                selected: genres[i] == _genre,
                onTap: () => setState(() => _genre = genres[i]),
              ),
            ),
          ),
          const SizedBox(height: 12),
          Expanded(
            child: filtered.isEmpty
                ? const Center(
                    child: Text('Film tidak ditemukan',
                        style: TextStyle(color: AppColors.textMuted)),
                  )
                : LayoutBuilder(
                    builder: (context, constraints) {
                      if (constraints.maxWidth >= 600) {
                        return GridView.builder(
                          padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
                          gridDelegate:
                              const SliverGridDelegateWithMaxCrossAxisExtent(
                            maxCrossAxisExtent: 480,
                            mainAxisExtent: 140,
                            crossAxisSpacing: 12,
                            mainAxisSpacing: 12,
                          ),
                          itemCount: filtered.length,
                          itemBuilder: (_, i) =>
                              MovieCard(movie: filtered[i], section: 'list'),
                        );
                      }
                      return ListView.separated(
                        padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
                        itemCount: filtered.length,
                        separatorBuilder: (_, __) => const SizedBox(height: 10),
                        itemBuilder: (_, i) =>
                            MovieCard(movie: filtered[i], section: 'list'),
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }
}
