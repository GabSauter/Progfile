import 'package:flutter/material.dart';
import 'package:progfile/app/models/git_project_model.dart';
import 'package:progfile/app/repositories/curriculum_repository.dart';
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
    final curriculum = context.watch<CurriculumRepository>();
    final projects = curriculum.myCurriculum.gitProjects;

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
        itemCount: projects.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(projects[index].name),
            subtitle: Text(
              UrlParser.githubUsernameDisplay(projects[index].url),
            ),
            trailing: Text(projects[index].language ?? ''),
            onTap: () =>
                _showAddRepositoryDialog(repository: projects[index]),
          );
        },
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
