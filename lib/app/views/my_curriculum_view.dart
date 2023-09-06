import 'package:flutter/material.dart';
import 'package:progfile/app/views/components/repository_card.dart';
import 'package:progfile/app/views/components/main_button.dart';
import 'package:progfile/app/views/components/secondary_button.dart';
import '../models/user_repository_model.dart';

class MyCurriculumView extends StatelessWidget {
  final UserRepositoryModel? userRepository;

  const MyCurriculumView({Key? key, this.userRepository}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Meu Currículo'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 40),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            userBasicInfo,
            const SizedBox(height: 50),
            userAcademicInfo(context),
            const Divider(
              color: Colors.black,
              thickness: 1,
              height: 50,
            ),
            githubInfo,
            const SizedBox(height: 40),
            const SecondaryButton(
              text: 'Editar Currículo',
              route: '/curriculumEdit',
              //Aqui fazer a chamada pra pegar os dados que foram carregados do
              //usuario e mostrar um preview nos campos do criar curriculo
            ),
            const SizedBox(height: 20),
            MainButton(
              text: 'Deletar Currículo',
              onPressedCallback: () => {Navigator.pushNamed(context, '/home')},
              buttonColor: Colors.red,
            )
          ],
        ),
      ),
    );
  }

  Widget get githubInfo {
    return const Column(
      children: [
        Row(
          children: [
            Text(
              'GitHub:',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(width: 10),
            Text(
              '/Ninjaalpha01',
              style: TextStyle(
                decoration: TextDecoration.underline,
                fontSize: 16,
              ),
            ),
          ],
        ),
        SizedBox(height: 40),
        RepositoryCard(),
        SizedBox(height: 20),
        RepositoryCard(),
      ],
    );
  }

  Container userAcademicInfo(BuildContext context) {
    List<Widget> about = [
      const Text(
        'Sobre:',
        style: TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.bold,
        ),
      ),
      const SizedBox(height: 5),
      const Text("Once upon a time there was a lovely princess. "
          "But she had an enchantment upon her of a fearful sort which "
          "could only be broken by love's first kiss. "
          "She was locked away in a castle guarded by a terrible "
          "fire-breathing dragon."),
    ];
    List<Widget> academic = [
      const Text(
        'Formação Acadêmica:',
        style: TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.bold,
        ),
      ),
      const SizedBox(height: 5),
      const Text('Design Gráfico',
          style: TextStyle(
            decoration: TextDecoration.underline,
            fontSize: 16,
          )),
      const Text('Tecnico - UEPG', style: TextStyle(fontSize: 16)),
      const Text('2018-2020', style: TextStyle(fontSize: 16)),
      const SizedBox(height: 10),
      const Text('Bacharelado em Ciencia da Computacao',
          style: TextStyle(
            decoration: TextDecoration.underline,
            fontSize: 16,
          )),
      const Text('Graduacao - UTFPR', style: TextStyle(fontSize: 16)),
      const Text('2020-2024', style: TextStyle(fontSize: 16)),
    ];
    List<Widget> languages = [
      const Text(
        'Idiomas:',
        style: TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.bold,
        ),
      ),
      const SizedBox(height: 5),
      const Text('Ingles - Avancado', style: TextStyle(fontSize: 16)),
      const SizedBox(height: 10),
      const Text('Espanhol - Basico', style: TextStyle(fontSize: 16)),
    ];
    List<Widget> skills = [
      const Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Competências:',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Column(
                children: [
                  Text('Flutter', style: TextStyle(fontSize: 16)),
                  SizedBox(height: 10),
                  Text('Dart', style: TextStyle(fontSize: 16)),
                  SizedBox(height: 10),
                  Text('Java', style: TextStyle(fontSize: 16)),
                  SizedBox(height: 10),
                ],
              ),
              SizedBox(width: 150),
              Column(
                children: [
                  Text('C'),
                  SizedBox(height: 10),
                  Text('HTML'),
                  SizedBox(height: 10),
                  Text('CSS'),
                  SizedBox(height: 10),
                ],
              ),
            ],
          ),
        ],
      ),
      const SizedBox(height: 30),
      Center(
        child: MainButton(
          text: 'Meus Certificados',
          onPressedCallback: () =>
              {Navigator.pushNamed(context, '/certificate')},
          buttonWidth: 250,
        ),
      ),
    ];

    return Container(
      alignment: Alignment.centerLeft,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ...about,
          const SizedBox(height: 20),
          ...academic,
          const SizedBox(height: 20),
          ...languages,
          const SizedBox(height: 20),
          ...skills
        ],
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
            fontSize: 28,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(height: 20),
        Text(
          'Desenvolvedor de Software',
          style: TextStyle(
            fontSize: 18,
          ),
        ),
        SizedBox(height: 20),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.email),
            SizedBox(width: 10),
            Text(
              'teste@gmail.com',
              style: TextStyle(fontSize: 16),
            ),
          ],
        ),
        SizedBox(height: 20),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Text(
              'Ponta Grossa - PR',
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(width: 30),
            Text(
              '(19) 99619-0935',
              style: TextStyle(fontSize: 16),
            )
          ],
        ),
      ],
    );
  }
}
