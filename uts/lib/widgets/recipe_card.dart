import 'package:flutter/material.dart';
import '../models/recipe.dart';
import '../pages/detail_page.dart';
import '../theme/app_theme.dart';
import 'recipe_image.dart';

/// Kartu resep untuk daftar. Saat diketuk, membuka halaman detail.
class RecipeCard extends StatelessWidget {
  final Recipe recipe;
  const RecipeCard({super.key, required this.recipe});

  @override
  Widget build(BuildContext context) {
    final text = Theme.of(context).textTheme;
    return Card(
      elevation: 0,
      color: Colors.white,
      margin: EdgeInsets.zero,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
        side: BorderSide(color: AppColors.arang.withAlpha(18)),
      ),
      child: InkWell(
        borderRadius: BorderRadius.circular(16),
        onTap: () => Navigator.push(
          context,
          MaterialPageRoute(builder: (_) => DetailPage(recipe: recipe)),
        ),
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Row(
            children: [
              RecipeImage(
                url: recipe.image,
                width: 84,
                height: 84,
                borderRadius: BorderRadius.circular(12),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(recipe.name,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: text.titleSmall
                            ?.copyWith(fontWeight: FontWeight.w600)),
                    const SizedBox(height: 2),
                    Text(recipe.category,
                        style: text.bodySmall
                            ?.copyWith(color: AppColors.abuHangat)),
                    const SizedBox(height: 8),
                    Row(
                      children: [
                        const Icon(Icons.schedule,
                            size: 14, color: AppColors.daunPisang),
                        const SizedBox(width: 4),
                        Text('${recipe.cookTimeMinutes} menit',
                            style: text.bodySmall),
                        const SizedBox(width: 12),
                        const Icon(Icons.star_rounded,
                            size: 16, color: Color(0xFFE3A21A)),
                        const SizedBox(width: 2),
                        Text('${recipe.rating}', style: text.bodySmall),
                      ],
                    ),
                  ],
                ),
              ),
              const Icon(Icons.chevron_right, color: AppColors.abuHangat),
            ],
          ),
        ),
      ),
    );
  }
}
