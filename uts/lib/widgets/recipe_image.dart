import 'package:flutter/material.dart';
import '../theme/app_theme.dart';

/// Gambar dari internet dengan indikator loading dan tampilan cadangan
/// jika gambar gagal dimuat (misalnya tidak ada koneksi).
class RecipeImage extends StatelessWidget {
  final String url;
  final double? width;
  final double? height;
  final BorderRadius borderRadius;

  const RecipeImage({
    super.key,
    required this.url,
    this.width,
    this.height,
    this.borderRadius = BorderRadius.zero,
  });

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: borderRadius,
      child: Image.network(
        url,
        width: width,
        height: height,
        fit: BoxFit.cover,
        loadingBuilder: (context, child, progress) {
          if (progress == null) return child;
          return Container(
            width: width,
            height: height,
            color: AppColors.sambal.withAlpha(20),
            child: const Center(
              child: SizedBox(
                width: 22,
                height: 22,
                child: CircularProgressIndicator(strokeWidth: 2),
              ),
            ),
          );
        },
        errorBuilder: (context, error, stack) => Container(
          width: width,
          height: height,
          color: AppColors.sambal.withAlpha(20),
          child: const Icon(Icons.ramen_dining,
              color: AppColors.sambal, size: 32),
        ),
      ),
    );
  }
}
