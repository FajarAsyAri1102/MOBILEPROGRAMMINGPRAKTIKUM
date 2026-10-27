import 'package:flutter/material.dart';

import '../data/movie_repository.dart';
import '../models/movie.dart';
import 'favorites_page.dart';
import 'home_page.dart';
import 'movie_list_page.dart';

/// Kerangka utama aplikasi: memuat data lalu menampilkan
/// BottomNavigationBar (Beranda, Jelajah, Favorit).
class MainShell extends StatefulWidget {
  const MainShell({super.key});

  @override
  State<MainShell> createState() => _MainShellState();
}

class _MainShellState extends State<MainShell> {
  late final Future<List<Movie>> _future = MovieRepository().loadMovies();
  int _index = 0;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Movie>>(
      future: _future,
      builder: (context, snapshot) {
        if (snapshot.connectionState != ConnectionState.done) {
          return const Scaffold(
              body: Center(child: CircularProgressIndicator()));
        }
        if (snapshot.hasError || !snapshot.hasData) {
          return Scaffold(
            body: Center(child: Text('Gagal memuat data: ${snapshot.error}')),
          );
        }
        final movies = snapshot.data!;
        final pages = <Widget>[
          HomePage(movies: movies),
          MovieListPage(title: 'Jelajah Film', movies: movies),
          FavoritesPage(movies: movies),
        ];
        return Scaffold(
          body: IndexedStack(index: _index, children: pages),
          bottomNavigationBar: BottomNavigationBar(
            currentIndex: _index,
            onTap: (i) => setState(() => _index = i),
            items: const [
              BottomNavigationBarItem(
                  icon: Icon(Icons.home_rounded), label: 'Beranda'),
              BottomNavigationBarItem(
                  icon: Icon(Icons.explore_rounded), label: 'Jelajah'),
              BottomNavigationBarItem(
                  icon: Icon(Icons.favorite_rounded), label: 'Favorit'),
            ],
          ),
        );
      },
    );
  }
}
