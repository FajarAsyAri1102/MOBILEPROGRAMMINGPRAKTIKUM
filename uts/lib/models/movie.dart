/// Model data film. Dibuat dengan [fromJson] agar mudah dipakai ulang
/// saat data nanti diambil dari API (cukup ganti sumber JSON-nya).
class Movie {
  final int id;
  final String title;
  final List<String> genres;
  final int year;
  final double rating;
  final int duration; // menit
  final String director;
  final List<String> cast;
  final String synopsis;
  final String poster; // path asset; kosong = pakai poster placeholder
  final int color; // warna dasar placeholder poster
  final bool isPopular;

  const Movie({
    required this.id,
    required this.title,
    required this.genres,
    required this.year,
    required this.rating,
    required this.duration,
    required this.director,
    required this.cast,
    required this.synopsis,
    required this.poster,
    required this.color,
    required this.isPopular,
  });

  factory Movie.fromJson(Map<String, dynamic> json) {
    return Movie(
      id: json['id'] as int,
      title: json['title'] as String,
      genres: List<String>.from(json['genres'] as List),
      year: json['year'] as int,
      rating: (json['rating'] as num).toDouble(),
      duration: json['duration'] as int,
      director: json['director'] as String,
      cast: List<String>.from(json['cast'] as List),
      synopsis: json['synopsis'] as String,
      poster: (json['poster'] as String?) ?? '',
      color: int.parse((json['color'] as String).replaceFirst('#', '0xFF')),
      isPopular: (json['isPopular'] as bool?) ?? false,
    );
  }

  String get durationText => '${duration ~/ 60}j ${duration % 60}m';

  String get genreText => genres.join(', ');

  /// Daftar genre unik (terurut) dari kumpulan film.
  static List<String> allGenres(List<Movie> movies) {
    final set = movies.expand((m) => m.genres).toSet().toList();
    set.sort();
    return set;
  }
}
