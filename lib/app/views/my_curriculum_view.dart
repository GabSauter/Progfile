import 'package:flutter/material.dart';
import 'package:progfile/app/views/components/main_button.dart';
import '../models/user_repository_model.dart';

class MyCurriculumView extends StatelessWidget {
  final UserRepositoryModel? userRepository;

  const MyCurriculumView({Key? key, this.userRepository}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Curriculum Registration'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 40),
        child: Column(
          children: [
            userBasicInfo,
            const SizedBox(height: 50),
            Container(
              alignment: Alignment.centerLeft,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Sobre:',
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const Text("Once upon a time there was a lovely princess. "
                      "But she had an enchantment upon her of a fearful sort which "
                      "could only be broken by love's first kiss. "
                      "She was locked away in a castle guarded by a terrible "
                      "fire-breathing dragon."),
                  const SizedBox(height: 20),
                  const Text(
                    'Formacao Academica:',
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const Text('Design Grafico',
                      style: TextStyle(decoration: TextDecoration.underline)),
                  const Text('Tecnico - UEPG'),
                  const Text('2018-2020'),
                  const SizedBox(height: 10),
                  const Text('Bacharelado em Ciencia da Computacao',
                      style: TextStyle(decoration: TextDecoration.underline)),
                  const Text('Graduacao - UTFPR'),
                  const Text('2020-2024'),
                  const SizedBox(height: 20),
                  MainButton(
                      text: 'Meus Certificados',
                      onPressedCallback: () =>
                          {Navigator.pushNamed(context, '/home')}),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget get userBasicInfo {
    return const Column(
      children: [
        Image(image: AssetImage('assets/images/user.png'), height: 150),
        SizedBox(height: 10),
        Text(
          'Roger Rodrigues',
          style: TextStyle(
            fontSize: 25,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(height: 20),
        Text(
          'Desenvolvedor de Software',
          style: TextStyle(
            fontSize: 16,
          ),
        ),
        SizedBox(height: 20),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.email),
            SizedBox(width: 10),
            Text('teste@gmail.com'),
          ],
        ),
        SizedBox(height: 20),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Ponta Grossa - PR'),
            SizedBox(width: 40),
            Text('(19) 99619-0935')
          ],
        ),
      ],
    );
  }
}
