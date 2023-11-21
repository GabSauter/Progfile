import 'package:flutter/material.dart';
import 'package:progfile/app/repositories/curriculum_repository.dart';
import 'package:provider/provider.dart';
import '../controllers/search_controller.dart';
import '../models/profile_model.dart';
import '../repositories/profile_repository.dart';

class SearchView extends StatefulWidget {
  const SearchView({super.key});

  @override
  SearchViewState createState() => SearchViewState();
}

class SearchViewState extends State<SearchView> {
  final _searchController = SearchCurriculumController();
  late ProfileRepository profiles;

  List<ProfileModel> filteredResumes = [];

  @override
  void initState() {
    super.initState();
  }

  void _searchResumes(String searchText) {
    setState(() {
      filteredResumes =
          _searchController.searchResumes(searchText, profiles.list);
    });
  }

  @override
  Widget build(BuildContext context) {
    profiles = context.watch<ProfileRepository>();

    if (filteredResumes.isEmpty) {
      filteredResumes = profiles.list;
    }

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).primaryColor,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: const Text("Procurar Curriculo"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Row(
              children: [
                Expanded(
                  child: TextFormField(
                    validator: (value) {
                      return "";
                    },
                    controller: _searchController.searchTextController,
                    onFieldSubmitted: _searchResumes,
                    cursorColor: const Color(0xFF482FF7),
                    decoration: InputDecoration(
                      focusedBorder: OutlineInputBorder(
                        borderSide: const BorderSide(
                            width: 2, color: Color(0xFF482FF7)),
                        borderRadius: BorderRadius.circular(15.0),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderSide: const BorderSide(
                            width: 1, color: Color(0xFF482FF7)),
                        borderRadius: BorderRadius.circular(15.0),
                      ),
                      fillColor: Colors.transparent,
                      hintText: "Procurar por currículos",
                    ),
                  ),
                ),
                const SizedBox(width: 6),
                Container(
                  decoration: BoxDecoration(
                    color: const Color(0xFF482FF7),
                    borderRadius: BorderRadius.circular(15.0),
                  ),
                  height: 60,
                  width: 60,
                  child: IconButton(
                    color: Colors.white,
                    icon: const Icon(Icons.search),
                    onPressed: () {
                      _searchResumes(
                          _searchController.searchTextController.text);
                    },
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Expanded(
              child: ListView.builder(
                itemCount: filteredResumes.length,
                itemBuilder: (context, index) {
                  return InkWell(
                    onTap: () {
                      final profile = filteredResumes[index];
                      context
                          .read<CurriculumRepository>()
                          .getItems(profile.id!);
                      Navigator.pushNamed(
                        context,
                        '/curriculum',
                        arguments: profile,
                      );
                    },
                    child: Card(
                      color: const Color.fromARGB(255, 226, 243, 245),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16.0),
                      ),
                      elevation: 6,
                      margin: const EdgeInsets.symmetric(
                        vertical: 8.0,
                        horizontal: 8.0,
                      ),
                      child: ListTile(
                        contentPadding: const EdgeInsets.all(16.0),
                        leading: filteredResumes[index].image != null
                            ? CircleAvatar(
                                backgroundColor: Colors.black,
                                backgroundImage:
                                    NetworkImage(filteredResumes[index].image!),
                                radius: 40,
                              )
                            : const CircleAvatar(
                                backgroundColor: Colors.black,
                                backgroundImage:
                                    AssetImage("assets/images/user.png"),
                                radius: 40,
                              ),
                        title: Text(
                          filteredResumes[index].name,
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        ),
                        subtitle: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const SizedBox(height: 6.0),
                            Text(filteredResumes[index].fieldOfExpertise),
                            const SizedBox(height: 6.0),
                            Text(filteredResumes[index].degree),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
