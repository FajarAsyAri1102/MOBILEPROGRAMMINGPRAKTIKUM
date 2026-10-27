import 'package:flutter/material.dart';
import '../models/recipe.dart';
import '../services/favorite_store.dart';
import '../theme/app_theme.dart';
import '../widgets/recipe_image.dart';

/// Detail resep: foto, info singkat, bahan, dan langkah memasak.
class DetailPage extends StatelessWidget {
  final Recipe recipe;
  const DetailPage({super.key, required this.recipe});

  @override
  Widget build(BuildContext context) {
    final text = Theme.of(context).textTheme;
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            pinned: true,
            expandedHeight: 280,
            backgroundColor: AppColors.daunPisang,
            foregroundColor: Colors.white,
            flexibleSpace: FlexibleSpaceBar(
              background: SizedBox.expand(
                child: RecipeImage(url: recipe.image),
              ),
            ),
            actions: [
              ValueListenableBuilder<Set<int>>(
                valueListenable: FavoriteStore.ids,
                builder: (context, ids, _) {
                  final isFav = ids.contains(recipe.id);
                  return IconButton(
                    tooltip: isFav ? 'Hapus dari favorit' : 'Simpan ke favorit',
                    onPressed: () => FavoriteStore.toggle(recipe.id),
                    icon: Icon(
                      isFav ? Icons.favorite : Icons.favorite_border,
                      color: isFav ? AppColors.sambal : Colors.white,
                    ),
                  );
                },
              ),
            ],
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(recipe.name,
                      style: text.headlineSmall
                          ?.copyWith(fontWeight: FontWeight.w600)),
                  const SizedBox(height: 4),
                  Text(recipe.category,
                      style: text.bodyMedium
                          ?.copyWith(color: AppColors.abuHangat)),
                  const SizedBox(height: 16),
                  Wrap(
                    spacing: 8,
                    runSpacing: 8,
                    children: [
                      _InfoChip(Icons.schedule,
                          '${recipe.cookTimeMinutes} menit'),
                      _InfoChip(
                          Icons.people_outline, '${recipe.servings} porsi'),
                      _InfoChip(Icons.speed, recipe.difficulty),
                      _InfoChip(Icons.star_rounded, '${recipe.rating}'),
                    ],
                  ),
                  const SizedBox(height: 24),
                  Text('Bahan-bahan',
                      style: text.titleMedium
                          ?.copyWith(fontWeight: FontWeight.w600)),
                  const SizedBox(height: 8),
                  for (final item in recipe.ingredients)
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 4),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Padding(
                            padding: EdgeInsets.only(top: 6, right: 10),
                            child: Icon(Icons.circle,
                                size: 6, color: AppColors.sambal),
                          ),
                          Expanded(child: Text(item, style: text.bodyMedium)),
                        ],
                      ),
                    ),
                  const SizedBox(height: 24),
                  Text('Langkah memasak',
                      style: text.titleMedium
                          ?.copyWith(fontWeight: FontWeight.w600)),
                  const SizedBox(height: 8),
                  for (var i = 0; i < recipe.steps.length; i++)
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 6),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          CircleAvatar(
                            radius: 12,
                            backgroundColor: AppColors.daunPisang,
                            child: Text('${i + 1}',
                                style: const TextStyle(
                                    fontSize: 12, color: Colors.white)),
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                              child:
                                  Text(recipe.steps[i], style: text.bodyMedium)),
                        ],
                      ),
                    ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _InfoChip extends StatelessWidget {
  final IconData icon;
  final String label;
  const _InfoChip(this.icon, this.label);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      decoration: BoxDecoration(
        color: AppColors.daunPisang.withAlpha(22),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 16, color: AppColors.daunPisang),
          const SizedBox(width: 6),
          Text(label, style: Theme.of(context).textTheme.bodySmall),
        ],
      ),
    );
  }
}
