# CineKu

Aplikasi katalog dan info film berbasis Flutter. Dibuat untuk UTS Mobile Programming (Semester Ganjil 2025/2026).

## Tema dan Tujuan
CineKu membantu pengguna menemukan film berdasarkan genre, melihat rating dan sinopsis, serta menyimpan film favorit. Data masih berupa data dummy (JSON lokal) dan strukturnya disiapkan agar mudah diganti dengan API.

## Halaman
| Halaman | File | Fungsi |
|---|---|---|
| Beranda | `lib/pages/home_page.dart` | Sapaan, pencarian, chip genre, film populer, rilis terbaru |
| Daftar/Jelajah Film | `lib/pages/movie_list_page.dart` | Daftar film dengan filter genre dan pencarian (list di layar sempit, grid di layar lebar) |
| Detail Film | `lib/pages/movie_detail_page.dart` | Poster, rating, durasi, genre, sinopsis, sutradara, pemeran, tombol favorit |
| Favorit | `lib/pages/favorites_page.dart` | Daftar film favorit |

Navigasi: `BottomNavigationBar` (Beranda, Jelajah, Favorit) dan `Navigator.push` (ke daftar dan detail film).

## Struktur Folder
```
lib/
├── main.dart
├── models/        # class Movie (fromJson)
├── data/          # MovieRepository (baca JSON; ganti ke API nanti)
├── state/         # FavoritesStore
├── theme/         # warna dan tema
├── pages/         # halaman aplikasi
└── widgets/       # widget reusable (MovieCard, GenreChip, PosterView)
assets/
├── data/movies.json
└── images/        # tempat poster (opsional)
```

## Cara Menjalankan
1. Pastikan Flutter sudah terpasang (`flutter doctor`).
2. Di folder proyek, jalankan `flutter create .` (sekali saja, untuk membuat folder android/ios).
3. Jalankan `flutter pub get`.
4. Jalankan `flutter run` (emulator atau perangkat terhubung).

## Menambah Poster
Taruh gambar di `assets/images/` lalu isi field `"poster"` pada `assets/data/movies.json`, misalnya `"assets/images/bayang_senja.jpg"`. Jika kosong, aplikasi memakai poster placeholder berwarna.

## Rencana Pengembangan
Mengganti `MovieRepository.loadMovies()` agar mengambil data dari API (paket `http`), tanpa mengubah model dan halaman.
