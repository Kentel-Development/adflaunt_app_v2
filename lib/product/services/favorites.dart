import 'package:hive/hive.dart';

class FavoriteService {
  static Future<void> addFavorite(Box<List<String>> box, String id) async {
    final favorites = box.get("favorites", defaultValue: <String>[])!;
    if (!favorites.contains(id)) {
      favorites.add(id);
    } else {
      removeFavorite(box, id);
    }
    await box.put("favorites", favorites);
  }

  static Future<void> removeFavorite(Box<List<String>> box, String id) async {
    final favorites = box.get("favorites", defaultValue: <String>[])!;
    if (favorites.contains(id)) {
      favorites.remove(id);
    }
    await box.put("favorites", favorites);
  }

  static Future<List<String>> getFavorites(Box<List<String>> box) async {
    final favorites = box.get("favorites", defaultValue: <String>[])!;
    return favorites;
  }
}
