import 'dart:convert';
import 'package:flutter/foundation.dart' show kIsWeb, debugPrint;
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:geolocator/geolocator.dart';
import 'package:geocoding/geocoding.dart';
import 'package:http/http.dart' as http;

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Lokasi Saya',
      theme: ThemeData(
        primarySwatch: Colors.indigo,
        textTheme: GoogleFonts.poppinsTextTheme(
          Theme.of(context).textTheme,
        ),
      ),
      home: const GeolocationScreen(),
    );
  }
}

class GeolocationScreen extends StatefulWidget {
  const GeolocationScreen({super.key});

  @override
  State<GeolocationScreen> createState() => _GeolocationScreenState();
}

class _GeolocationScreenState extends State<GeolocationScreen> {
  String? _kecamatan;
  String? _kota;
  bool _isLoading = false;
  String? _errorMessage;

  Future<void> _getLocation() async {
    // 1. Set status loading dan reset data
    setState(() {
      _isLoading = true;
      _errorMessage = null;
      _kecamatan = null;
      _kota = null;
    });

    try {
      // 2. Cek apakah layanan lokasi (GPS) aktif
      bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
      if (!serviceEnabled) {
        throw Exception('Layanan lokasi tidak aktif. Mohon aktifkan GPS.');
      }

      // 3. Periksa izin akses lokasi
      LocationPermission permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
        if (permission == LocationPermission.denied) {
          throw Exception('Izin lokasi ditolak oleh pengguna.');
        }
      }
      if (permission == LocationPermission.deniedForever) {
        throw Exception(
            'Izin lokasi ditolak permanen. Anda harus mengubahnya di pengaturan aplikasi.');
      }

      // 4. Ambil posisi perangkat saat ini
      Position position = await Geolocator.getCurrentPosition(
        locationSettings: const LocationSettings(
          accuracy: LocationAccuracy.high,
        ),
      );

      // 5. Reverse geocoding
      if (kIsWeb) {
        // Web: package geocoding tidak support, pakai Nominatim (OpenStreetMap)
        final url = Uri.parse(
          'https://nominatim.openstreetmap.org/reverse'
          '?format=jsonv2&lat=${position.latitude}&lon=${position.longitude}'
          '&accept-language=id',
        );
        final res = await http.get(url);
        if (res.statusCode != 200) {
          throw Exception('Gagal mengambil data alamat.');
        }
        final data = jsonDecode(res.body) as Map<String, dynamic>;
        final addr = (data['address'] ?? {}) as Map<String, dynamic>;

        setState(() {
          _kecamatan = (addr['suburb'] ??
                  addr['village'] ??
                  addr['city_district'] ??
                  addr['neighbourhood'] ??
                  addr['municipality'])
              ?.toString();
          _kota = (addr['city'] ??
                  addr['county'] ??
                  addr['town'] ??
                  addr['regency'])
              ?.toString();
        });

        if (_kecamatan == null && _kota == null) {
          throw Exception('Tidak dapat menemukan informasi alamat.');
        }
      } else {
        // Android/iOS: pakai package geocoding
        List<Placemark> placemarks = await placemarkFromCoordinates(
            position.latitude, position.longitude);

        if (placemarks.isNotEmpty) {
          Placemark place = placemarks[0];
          setState(() {
            _kecamatan = place.subLocality;
            _kota = place.subAdministrativeArea;
          });
        } else {
          throw Exception('Tidak dapat menemukan informasi alamat.');
        }
      }
    } catch (e, stack) {
      // 6. Tangani error dan tampilkan pesan
      debugPrint('ERROR: $e');
      debugPrint('STACK: $stack');
      setState(() {
        _errorMessage = e.toString().replaceAll("Exception: ", "");
      });
    } finally {
      // 7. Hentikan status loading
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Lokasi Saya',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: const Color(0xFF1A237E),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Card(
              elevation: 4.0,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12.0)),
              child: Container(
                padding: const EdgeInsets.symmetric(
                    vertical: 32.0, horizontal: 10.0),
                child: _isLoading
                    ? const Center(child: CircularProgressIndicator())
                    : (_errorMessage != null)
                        ? Text(
                            _errorMessage!,
                            textAlign: TextAlign.center,
                            style: const TextStyle(color: Colors.red),
                          )
                        : (_kecamatan == null && _kota == null)
                            ? const Text(
                                'Tekan tombol untuk menampilkan lokasi.',
                                textAlign: TextAlign.center,
                              )
                            : Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Kelurahan/Kecamatan: ${_kecamatan ?? "-"}',
                                    style: const TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  const SizedBox(height: 10),
                                  Text(
                                    'Kota: ${_kota ?? "-"}',
                                    style: const TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
              ),
            ),
            const SizedBox(height: 40),
            ElevatedButton(
              onPressed: _isLoading ? null : _getLocation,
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF1A237E),
                padding: const EdgeInsets.symmetric(vertical: 16.0),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12.0),
                ),
                elevation: 5.0,
              ),
              child: const Text(
                'TAMPILKAN LOKASI SAAT INI',
                style: TextStyle(fontSize: 16, color: Colors.white),
              ),
            ),
          ],
        ),
      ),
    );
  }
}