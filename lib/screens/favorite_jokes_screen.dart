import 'package:flutter/material.dart';
import '../services/local_storage_service.dart';

class FavoriteJokesScreen extends StatelessWidget {
  const FavoriteJokesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Favorite Jokes')),
      body: FutureBuilder<List<Map<String, dynamic>>>(
        future: LocalStorageService.getFavoriteJokes(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else {
            final jokes = snapshot.data!;
            if (jokes.isEmpty) {
              return const Center(child: Text('No favorite jokes yet!'));
            }
            return ListView.builder(
              itemCount: jokes.length,
              itemBuilder: (context, index) {
                final joke = jokes[index];
                return ListTile(
                  title: Text(joke['setup']),
                  subtitle: Text(joke['punchline']),
                );
              },
            );
          }
        },
      ),
    );
  }
}