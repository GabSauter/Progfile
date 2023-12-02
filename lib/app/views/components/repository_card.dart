import 'package:flutter/material.dart';

class RepositoryCard extends StatelessWidget {
  final String title;
  final String description;
  final String languages;

  const RepositoryCard({
    super.key,
    required this.title,
    required this.description,
    required this.languages,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      heightFactor: 1.1,
      child: SizedBox(
        width: MediaQuery.of(context).size.width * .8,
        height: 150,
        child: Card(
          clipBehavior: Clip.hardEdge,
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(15)),
            side: BorderSide(
                color: Color.fromARGB(255, 134, 134, 134), width: .5),
          ),
          elevation: 3,
          child: Padding(
            padding: const EdgeInsets.symmetric(
              vertical: 10,
              horizontal: 20,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 15),
                Text(
                  description,
                  maxLines: 3,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    fontSize: 14,
                  ),
                ),
                const SizedBox(height: 15),
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
      ),
    );
  }
}
