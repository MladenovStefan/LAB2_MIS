import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

class LocalStorageService {
  static const String favoritesKey = 'favorite_jokes';

  static Future<void> saveFavoriteJoke(Map<String, dynamic> joke) async {
    final prefs = await SharedPreferences.getInstance();
    final List<String> favorites = prefs.getStringList(favoritesKey) ?? [];
    favorites.add(jsonEncode(joke));
    await prefs.setStringList(favoritesKey, favorites);
  }

  static Future<List<Map<String, dynamic>>> getFavoriteJokes() async {
    final prefs = await SharedPreferences.getInstance();
    final List<String> favorites = prefs.getStringList(favoritesKey) ?? [];
    return favorites.map((j) => jsonDecode(j) as Map<String, dynamic>).toList();
  }
}