import 'package:flutter/material.dart';
import '../models/recipe.dart';
import '../theme/app_theme.dart';
import '../widgets/recipe_card.dart';

/// Daftar resep dengan pencarian dan filter kategori.
/// Layar lebar (tablet) memakai grid 2 kolom, layar sempit memakai list.
class ListPage extends StatefulWidget {
  final List<Recipe> recipes;
  final String? initialCategory;

  const ListPage({super.key, required this.recipes, this.initialCategory});

  @override
  State<ListPage> createState() => _ListPageState();
}

class _ListPageState extends State<ListPage> {
  String? _category; // null = semua kategori
  String _query = '';

  @override
  void initState() {
    super.initState();
    _category = widget.initialCategory;
  }

  @override
  Widget build(BuildContext context) {
    final categories =
        widget.recipes.map((r) => r.category).toSet().toList();
    final results = widget.recipes.where((r) {
      final matchCategory = _category == null || r.category == _category;
      final matchQuery =
          r.name.toLowerCase().contains(_query.trim().toLowerCase());
      return matchCategory && matchQuery;
    }).toList();

    return Scaffold(
      appBar: AppBar(
        title: Text(_category ?? 'Semua resep',
            style: const TextStyle(fontWeight: FontWeight.w600)),
        backgroundColor: AppColors.kertas,
        surfaceTintColor: Colors.transparent,
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 4, 20, 8),
            child: TextField(
              onChanged: (v) => setState(() => _query = v),
              decoration: InputDecoration(
                hintText: 'Cari nama resep',
                prefixIcon: const Icon(Icons.search),
                filled: true,
                fillColor: Colors.white,
                contentPadding: const EdgeInsets.symmetric(vertical: 12),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(14),
                  borderSide:
                      BorderSide(color: AppColors.arang.withAlpha(25)),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(14),
                  borderSide:
                      BorderSide(color: AppColors.arang.withAlpha(25)),
                ),
              ),
            ),
          ),
          SizedBox(
            height: 44,
            child: ListView(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(horizontal: 20),
              children: [
                _chip('Semua', _category == null, () {
                  setState(() => _category = null);
                }),
                for (final c in categories)
                  _chip(c, _category == c, () {
                    setState(() => _category = c);
                  }),
              ],
            ),
          ),
          Expanded(
            child: results.isEmpty
                ? const Center(child: Text('Resep tidak ditemukan.'))
                : LayoutBuilder(
                    builder: (context, constraints) {
                      if (constraints.maxWidth >= 600) {
                        return GridView.builder(
                          padding: const EdgeInsets.all(20),
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            mainAxisSpacing: 12,
                            crossAxisSpacing: 12,
                            mainAxisExtent: 108,
                          ),
                          itemCount: results.length,
                          itemBuilder: (_, i) =>
                              RecipeCard(recipe: results[i]),
                        );
                      }
                      return ListView.separated(
                        padding: const EdgeInsets.all(20),
                        itemCount: results.length,
                        separatorBuilder: (_, __) =>
                            const SizedBox(height: 12),
                        itemBuilder: (_, i) => RecipeCard(recipe: results[i]),
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }

  Widget _chip(String label, bool selected, VoidCallback onTap) {
    return Padding(
      padding: const EdgeInsets.only(right: 8),
      child: ChoiceChip(
        label: Text(label),
        selected: selected,
        onSelected: (_) => onTap(),
        selectedColor: AppColors.sambal,
        backgroundColor: Colors.white,
        showCheckmark: false,
        labelStyle: TextStyle(
          color: selected ? Colors.white : AppColors.arang,
          fontSize: 13,
        ),
      ),
    );
  }
}
