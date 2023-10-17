import 'package:flutter/material.dart';
import 'package:progfile/app/models/competence_model.dart';
import 'package:progfile/app/repositories/competence_repository.dart';
import 'package:progfile/app/views/popups/popup_competence.dart';
import 'package:provider/provider.dart';

class CompetenceView extends StatefulWidget {
  const CompetenceView({super.key});

  @override
  State<CompetenceView> createState() => _CompetenceViewState();
}

class _CompetenceViewState extends State<CompetenceView> {
  @override
  Widget build(BuildContext context) {
    final competenceRepository = context.watch<CompetenceRepository>();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Competências'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: ListView.builder(
        itemCount: competenceRepository.list.length,
        itemBuilder: (context, index) {
          return Dismissible(
            key: Key(competenceRepository.list[index].name),
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
              competenceRepository.delete(competenceRepository.list[index].id!);
            },
            child: ListTile(
              title: Text(competenceRepository.list[index].name),
              trailing: Text(competenceRepository.list[index].degree),
              onTap: () => _showAddcompetenceDialog(
                  competence: competenceRepository.list[index]),
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _showAddcompetenceDialog(),
        child: const Icon(Icons.add),
      ),
    );
  }

  void _showAddcompetenceDialog({CompetenceModel? competence}) {
    showDialog(
      context: context,
      builder: (context) {
        return PopupCompetence(competence: competence);
      },
    );
  }
}
