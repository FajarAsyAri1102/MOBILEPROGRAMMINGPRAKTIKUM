class TasbihModel {
  final int count;
  final int maxCount;

  const TasbihModel({this.count = 0, this.maxCount = 33});

  double get progress => (count / maxCount) * 100;
  bool get isFinished => count >= maxCount;

  TasbihModel copyWith({int? count}) {
    return TasbihModel(
      count: count ?? this.count,
      maxCount: maxCount,
    );
  }
}