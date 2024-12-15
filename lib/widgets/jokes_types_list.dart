import 'package:flutter/material.dart';
import '../screens/jokes_by_type_screen.dart';

class JokeTypesList extends StatelessWidget {
  final List<String> jokeTypes;

  const JokeTypesList({Key? key, required this.jokeTypes}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: jokeTypes.length,
      itemBuilder: (context, index) {
        return Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
          elevation: 3,
          child: ListTile(
            leading: Icon(
              Icons.category_outlined,
              color: Theme.of(context).primaryColor,
            ),
            title: Text(
              jokeTypes[index][0].toUpperCase() + jokeTypes[index].substring(1),
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
            ),
            trailing: const Icon(Icons.arrow_forward_ios, size: 18),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) =>
                      JokesByTypeScreen(type: jokeTypes[index]),
                ),
              );
            },
          ),
        );
      },
    );
  }
}
