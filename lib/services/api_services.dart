import 'package:http/http.dart' as http;
import 'dart:convert';

class ApiService {
  static const String baseUrl = 'https://official-joke-api.appspot.com';

  static Future<List<String>> fetchJokeTypes() async {
    try {
      // This is a mock list since the API doesn't provide types
      return ['Programming', 'General', 'Knock-knock', 'Dad'];
    } catch (e) {
      throw Exception('Failed to load joke types: $e');
    }
  }

  static Future<Map<String, dynamic>> fetchRandomJoke() async {
    try {
      final response = await http.get(Uri.parse('$baseUrl/random_joke'));
      if (response.statusCode == 200) {
        return json.decode(response.body);
      } else {
        throw Exception('Failed to load joke');
      }
    } catch (e) {
      throw Exception('Failed to load joke: $e');
    }
  }

  static Future<List<Map<String, dynamic>>> fetchJokesByType(String type) async {
    try {
      final response = await http.get(Uri.parse('$baseUrl/jokes/ten'));
      if (response.statusCode == 200) {
        List<dynamic> jokes = json.decode(response.body);
        return jokes.map((joke) => joke as Map<String, dynamic>).toList();
      } else {
        throw Exception('Failed to load jokes');
      }
    } catch (e) {
      throw Exception('Failed to load jokes: $e');
    }
  }
}