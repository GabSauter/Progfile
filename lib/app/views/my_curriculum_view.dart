import 'package:flutter/material.dart';
import 'package:progfile/app/models/profile_model.dart';
import 'package:progfile/app/views/components/repository_card.dart';
import 'package:progfile/app/views/components/main_button.dart';
import 'package:progfile/app/views/components/secondary_button.dart';

class MyCurriculumView extends StatelessWidget {
  final ProfileModel userRepository;
  // depois mudar para = UserRepositoryModel();

  const MyCurriculumView({Key? key, required this.userRepository})
      : super(key: key);

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
            const SizedBox(height: 30),
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
              'Ninjaalpha01',
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
      Text(userRepository.aboutYou),
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
    return Column(
      children: [
        const Image(image: AssetImage('assets/images/user.png'), height: 150),
        const SizedBox(height: 10),
        Text(
          userRepository.name,
          style: const TextStyle(
            fontSize: 28,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 10),
        Text(
          userRepository.fieldOfExpertise,
          style: const TextStyle(
            fontSize: 18,
          ),
        ),
        const SizedBox(height: 10),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.email),
            const SizedBox(width: 10),
            Text(
              userRepository.email,
              style: const TextStyle(fontSize: 16),
            ),
          ],
        ),
        const SizedBox(height: 10),
        Text(
          userRepository.phoneNumber,
          style: const TextStyle(fontSize: 16),
        ),
        const SizedBox(height: 10),
        Text(
          userRepository
              .address, // depois mudar o endereco para cidade e estado
          style: const TextStyle(fontSize: 16),
        ),
      ],
    );
  }
}
