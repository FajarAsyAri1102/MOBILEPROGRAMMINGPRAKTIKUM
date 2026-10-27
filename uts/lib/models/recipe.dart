/// Model data resep. Bentuk JSON-nya dibuat seperti respons API
/// agar nanti cukup mengganti sumber data di RecipeService.
class Recipe {
  final int id;
  final String name;
  final String category;
  final String image;
  final int cookTimeMinutes;
  final int servings;
  final String difficulty;
  final double rating;
  final bool isPopular;
  final List<String> ingredients;
  final List<String> steps;

  const Recipe({
    required this.id,
    required this.name,
    required this.category,
    required this.image,
    required this.cookTimeMinutes,
    required this.servings,
    required this.difficulty,
    required this.rating,
    required this.isPopular,
    required this.ingredients,
    required this.steps,
  });

  factory Recipe.fromJson(Map<String, dynamic> json) {
    return Recipe(
      id: json['id'] as int,
      name: json['name'] as String,
      category: json['category'] as String,
      image: json['image'] as String,
      cookTimeMinutes: json['cookTimeMinutes'] as int,
      servings: json['servings'] as int,
      difficulty: json['difficulty'] as String,
      rating: (json['rating'] as num).toDouble(),
      isPopular: json['isPopular'] as bool? ?? false,
      ingredients: List<String>.from(json['ingredients'] as List),
      steps: List<String>.from(json['steps'] as List),
    );
  }
}
