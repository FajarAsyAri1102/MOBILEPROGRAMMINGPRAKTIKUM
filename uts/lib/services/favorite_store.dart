import 'package:flutter/foundation.dart';

/// Penyimpan sederhana id resep favorit (hanya di memori selama app berjalan).
class FavoriteStore {
  static final ValueNotifier<Set<int>> ids = ValueNotifier<Set<int>>({});

  static void toggle(int id) {
    final next = Set<int>.from(ids.value);
    next.contains(id) ? next.remove(id) : next.add(id);
    ids.value = next;
  }
}
