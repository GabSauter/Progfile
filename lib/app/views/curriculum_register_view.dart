import 'package:flutter/material.dart';

class CurriculumRegisterView extends StatelessWidget {
  const CurriculumRegisterView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Criar Curriculo'),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            CircleAvatar(
              radius: 80.0,
              backgroundImage: AssetImage('assets/default_avatar.png'),
            ),
            SizedBox(height: 16.0),
            TextFormField(
              decoration: InputDecoration(labelText: 'Nome'),
            ),
            TextFormField(
              decoration: InputDecoration(labelText: 'Email'),
            ),
            TextFormField(
              decoration: InputDecoration(labelText: 'Número do celular'),
            ),
            SizedBox(height: 16.0),
            // Button to add course
            ElevatedButton(
              onPressed: () {},
              child: Text('Adicionar Curso'),
            ),
            ElevatedButton(
              onPressed: () {},
              child: Text('Adicionar Certificado'),
            ),
            SizedBox(height: 16.0),
            // Textfields for GitHub repository URL, Address, Occupation area, and Grade
            TextFormField(
              decoration: InputDecoration(labelText: 'URL Repositorio GitHub'),
            ),
            TextFormField(
              decoration: InputDecoration(labelText: 'Endereço'),
            ),
            TextFormField(
              decoration: InputDecoration(labelText: 'Área De Atuação'),
            ),
            DropdownButtonFormField<String>(
              items: ['Estágio', 'Junior', 'Senior']
                  .map((grade) => DropdownMenuItem<String>(
                        value: grade,
                        child: Text(grade),
                      ))
                  .toList(),
              onChanged: (selectedGrade) {
                // Implement action for grade selection
              },
              value: null,
              decoration: InputDecoration(labelText: 'Grau'),
            ),
            SizedBox(height: 16.0),
            // Button to add idiom
            ElevatedButton(
              onPressed: () {},
              child: Text('Adicionar Idioma'),
            ),
            // Button to add competence
            ElevatedButton(
              onPressed: () {
                // Implement action to add a competence
              },
              child: Text('Adicionar Competência'),
            ),
            SizedBox(height: 16.0),
            // Textfield to add 'About You'
            TextFormField(
              maxLines: 4,
              decoration: InputDecoration(labelText: 'About You'),
            ),
            SizedBox(height: 16.0),
            // Button to conclude the registration
            ElevatedButton(
              onPressed: () {
                // Implement action to conclude the registration
              },
              child: Text('Concluir'),
            ),
          ],
        ),
      ),
    );
  }
}
