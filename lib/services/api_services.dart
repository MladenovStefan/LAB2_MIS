import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiService {
  static const String baseUrl = "https://official-joke-api.appspot.com";

  // Fetch joke types
  static Future<List<String>> fetchJokeTypes() async {
    final response = await http.get(Uri.parse('$baseUrl/types'));
    if (response.statusCode == 200) {
      return List<String>.from(json.decode(response.body));
    } else {
      throw Exception("Failed to fetch joke types");
    }
  }

  // Fetch jokes by type
/*************  ✨ Codeium Command ⭐  *************/
  /// Fetches a list of jokes of the specified type from the API.
  ///
  /// The function sends a GET request to the API endpoint corresponding
  /// to the given joke type and retrieves up to ten jokes of that type.
  ///
  /// Returns a Future that resolves to a List of Maps, where each Map
  /// represents a joke with its associated data.
  ///
  /// Throws an Exception if the request fails or if the server response
  /// is not successful.

/******  5f3afeda-efe3-4adb-b8c1-2d364fc117a4  *******/
  static Future<List<Map<String, dynamic>>> fetchJokesByType(String type) async {
    final response = await http.get(Uri.parse('$baseUrl/jokes/$type/ten'));
    if (response.statusCode == 200) {
      return List<Map<String, dynamic>>.from(json.decode(response.body));
    } else {
      throw Exception("Failed to fetch jokes of type $type");
    }
  }

  // Fetch random joke
  static Future<Map<String, dynamic>> fetchRandomJoke() async {
    final response = await http.get(Uri.parse('$baseUrl/random_joke'));
    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception("Failed to fetch random joke");
    }
  }
}