import 'package:flutter/material.dart';
import 'package:progfile/app/models/language_model.dart';
import 'package:progfile/app/repositories/language_repository.dart';
import 'package:progfile/app/views/popups/popup_language.dart';
import 'package:provider/provider.dart';

class LanguageView extends StatefulWidget {
  const LanguageView({super.key});

  @override
  State<LanguageView> createState() => _LanguageViewState();
}

class _LanguageViewState extends State<LanguageView> {
  @override
  Widget build(BuildContext context) {
    final languages = context.watch<LanguageRepository>();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Idiomas'),
      ),
      body: ListView.builder(
        itemCount: languages.list.length,
        itemBuilder: (context, index) {
          return Dismissible(
            key: Key(languages.list[index].name),
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
              languages.delete(languages.list[index].id!);
            },
            child: ListTile(
              title: Text(languages.list[index].name),
              trailing: Text(languages.list[index].degree),
              onTap: () =>
                  _showAddLanguageDialog(language: languages.list[index]),
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _showAddLanguageDialog(),
        child: const Icon(Icons.add),
      ),
    );
  }

  void _showAddLanguageDialog({LanguageModel? language}) {
    showDialog(
      context: context,
      builder: (context) {
        return PopupLanguage(
          language: language,
        );
      },
    );
  }
}
