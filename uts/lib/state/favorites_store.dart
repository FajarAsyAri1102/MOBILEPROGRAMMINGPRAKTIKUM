import 'package:flutter/foundation.dart';

/// Penyimpanan sederhana daftar id film favorit (di memori).
class FavoritesStore {
  static final ValueNotifier<Set<int>> ids = ValueNotifier<Set<int>>({});

  static void toggle(int id) {
    final next = Set<int>.from(ids.value);
    if (!next.remove(id)) next.add(id);
    ids.value = next;
  }
}
