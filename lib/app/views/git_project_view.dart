import 'package:flutter/material.dart';
import 'package:progfile/app/models/git_project_model.dart';
import 'package:progfile/app/repositories/git_project_repository.dart';
import 'package:progfile/app/utils/url_parser.dart';
import 'package:progfile/app/views/popups/popup_git_project.dart';
import 'package:provider/provider.dart';

class GitProjectView extends StatefulWidget {
  const GitProjectView({super.key});

  @override
  State<GitProjectView> createState() => _GitProjectViewState();
}

class _GitProjectViewState extends State<GitProjectView> {
  @override
  Widget build(BuildContext context) {
    final projects = context.watch<GitProjectRepository>();

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
      body: ListView.builder(
        itemCount: projects.list.length,
        itemBuilder: (context, index) {
          return Dismissible(
            key: Key(projects.list[index].name),
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
              projects.delete(projects.list[index].id!);
            },
            child: ListTile(
              title: Text(projects.list[index].name),
              subtitle: Text(
                UrlParser.githubUsernameDisplay(projects.list[index].url),
              ),
              trailing: Text(projects.list[index].language),
              onTap: () =>
                  _showAddRepositoryDialog(repository: projects.list[index]),
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _showAddRepositoryDialog(),
        child: const Icon(Icons.add),
      ),
    );
  }

  void _showAddRepositoryDialog({GitProjectModel? repository}) {
    showDialog(
      context: context,
      builder: (context) {
        return PopupGitProject(repository: repository);
      },
    );
  }
}
