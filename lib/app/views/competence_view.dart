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
    final competences = context.watch<CompetenceRepository>();
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
                itemCount: competences.list.length,
                itemBuilder: (context, index) {
                  return Dismissible(
                    key: Key(competences.list[index].name),
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
                      _competenceController
                          .removeCompetence(snapshot.data![index].id!);
                    },
                    child: ListTile(
                      title: Text(snapshot.data![index].name),
                      trailing: Text(snapshot.data![index].degree),
                      onTap: () => _showAddcompetenceDialog(
                          competence: snapshot.data![index]),
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
        onPressed: () => _showAddcompetenceDialog(),
        child: const Icon(Icons.add),
      ),
    );
  }

  void _showAddcompetenceDialog({CompetenceModel? competence}) {
    showDialog(
      context: context,
      builder: (context) {
        return PopupCompetence(
          competence: competence,
          onPopupClose: () => setState(() {
            _competenceController.getCompetences();
          }),
        );
      },
    );
  }
}
