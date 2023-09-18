import 'package:flutter/material.dart';
import 'package:progfile/app/models/repository_model.dart';
import 'package:progfile/app/utils/url_parser.dart';
import 'package:progfile/app/views/popups/popup_repository.dart';

import '../controllers/repository_controller.dart';

class RepositoryView extends StatefulWidget {
  const RepositoryView({super.key});

  @override
  State<RepositoryView> createState() => _RepositoryViewState();
}

class _RepositoryViewState extends State<RepositoryView> {
  final _repositoryController = RepositoryController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Repositórios'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: FutureBuilder(
        future: _repositoryController.getRepositories(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            if (snapshot.hasData) {
              return ListView.builder(
                itemCount: snapshot.data!.length,
                itemBuilder: (context, index) {
                  return Dismissible(
                    key: Key(snapshot.data![index].name),
                    direction: DismissDirection.endToStart,
                    background: Container(
                      alignment: AlignmentDirectional.centerEnd,
                      color: Colors.red,
                      child: const Padding(
                        padding: EdgeInsets.fromLTRB(0.0, 0.0, 10.0, 0.0),
                        child: Icon(Icons.delete, color: Colors.white),
                      ),
                    ),
                    onDismissed: (direction) {
                      _repositoryController
                          .removeRepository(snapshot.data![index].id);
                    },
                    child: ListTile(
                      title: Text(snapshot.data![index].name),
                      subtitle: Text(
                        UrlParser.githubUsernameDisplay(
                            snapshot.data![index].url),
                      ),
                      trailing: Text(snapshot.data![index].language),
                      onTap: () => _showAddRepositoryDialog(
                          repository: snapshot.data![index]),
                    ),
                  );
                },
              );
            } else if (snapshot.hasError) {
              return Center(
                child: Text(snapshot.error.toString()),
              );
            } else {
              return const Center(child: Text("Algo deu errado."));
            }
          } else {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _showAddRepositoryDialog(),
        child: const Icon(Icons.add),
      ),
    );
  }

  void _showAddRepositoryDialog({RepositoryModel? repository}) {
    showDialog(
      context: context,
      builder: (context) {
        return PopupRepository(
          repository: repository,
          onPopupClose: () => setState(() {
            _repositoryController.getRepositories();
          }),
        );
      },
    );
  }
}
