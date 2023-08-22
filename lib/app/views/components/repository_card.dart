import 'package:flutter/material.dart';

class RepositoryCard extends StatelessWidget {
  final String title;
  final String description;
  final String languages;

  const RepositoryCard({
    super.key,
    this.title = 'Repositorio',
    this.description = 'Aplicativo para consulta de currículos.',
    this.languages = 'Flutter, Dart',
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Card(
        clipBehavior: Clip.hardEdge,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(15)),
          side:
              BorderSide(color: Color.fromARGB(255, 134, 134, 134), width: .5),
        ),
        elevation: 3,
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 10),
              Text(
                description,
                style: const TextStyle(
                  fontSize: 14,
                ),
              ),
              const SizedBox(height: 10),
              Text(
                languages,
                style: const TextStyle(
                  fontSize: 14,
                  color: Color.fromARGB(255, 102, 102, 102),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
