import 'package:flutter/material.dart';

class SearchView extends StatefulWidget {
  const SearchView({super.key});

  @override
  _SearchViewState createState() => _SearchViewState();
}

class _SearchViewState extends State<SearchView> {
  TextEditingController _searchController = TextEditingController();
  List<String> resumes = [
    "John Doe",
    "Jane Smith",
    "Alex Johnson",
    "Emily Brown",
    "Michael Williams"
  ];

  List<String> filteredResumes = [];

  @override
  void initState() {
    super.initState();
    filteredResumes = resumes;
  }

  void _searchResumes(String searchText) {
    setState(() {
      filteredResumes = resumes
          .where((resume) =>
              resume.toLowerCase().contains(searchText.toLowerCase()))
          .toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).primaryColor,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: const Text("ProgFile"),
        centerTitle: true,
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
                    controller: _searchController,
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
                    //obscureText: isPassword,
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
                      _searchResumes(_searchController.text);
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
                  return Card(
                    color: const Color.fromARGB(255, 226, 243, 245),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16.0),
                    ),
                    elevation: 6,
                    margin: const EdgeInsets.symmetric(
                        vertical: 8.0, horizontal: 8.0),
                    child: ListTile(
                      contentPadding: const EdgeInsets.all(16.0),
                      leading: const CircleAvatar(
                        backgroundColor: Colors.black,
                        backgroundImage: AssetImage(""),
                        radius: 40,
                      ),
                      title: Text(
                        filteredResumes[index],
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                      subtitle: const Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(height: 6.0),
                          Text("Desenvolvedor Web"),
                          SizedBox(height: 6.0),
                          Text("Estágio"),
                        ],
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
