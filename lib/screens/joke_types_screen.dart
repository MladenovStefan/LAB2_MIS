import 'package:flutter/material.dart';
import 'jokes_by_type_screen.dart';
import 'random_joke_screen.dart';
import 'favorite_jokes_screen.dart';
import '../services/api_services.dart';

class JokeTypesScreen extends StatefulWidget {
  const JokeTypesScreen({Key? key}) : super(key: key);

  @override
  State<JokeTypesScreen> createState() => _JokeTypesScreenState();
}

class _JokeTypesScreenState extends State<JokeTypesScreen> {
  late Future<List<String>> jokeTypes;

  @override
  void initState() {
    super.initState();
    jokeTypes = ApiService.fetchJokeTypes(); 
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Joke Types'),
        actions: [
          IconButton(
            icon: const Icon(Icons.favorite),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const FavoriteJokesScreen()),
              );
            },
          ),
          IconButton(
            icon: const Icon(Icons.shuffle),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const RandomJokeScreen()),
              );
            },
          ),
        ],
      ),
      body: FutureBuilder<List<String>>(
        future: jokeTypes,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else {
            final types = snapshot.data!;
            return ListView.builder(
              itemCount: types.length,
              itemBuilder: (context, index) {
                return Card(
                  child: ListTile(
                    title: Text(types[index]),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => JokesByTypeScreen(type: types[index]),
                        ),
                      );
                    },
                  ),
                );
              },
            );
          }
        },
      ),
    );
  }
}