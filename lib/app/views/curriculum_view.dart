import 'package:flutter/material.dart';
import 'package:progfile/app/models/fake_profile_model.dart';
import 'package:progfile/app/views/components/repository_card.dart';

import '../controllers/fake_profile_controller.dart';

class CurriculumView extends StatelessWidget {
  final FakeProfileModel _fakeProfile = FakeProfileController.getFakeProfile();

  CurriculumView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Currículo'),
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
          ],
        ),
      ),
    );
  }

  Widget get githubInfo {
    return Column(
      children: [
        Row(
          children: [
            const Text(
              'GitHub:',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(width: 10),
            Text(
              _fakeProfile.repositories.url,
              style: const TextStyle(
                decoration: TextDecoration.underline,
                fontSize: 16,
              ),
            ),
          ],
        ),
        const SizedBox(height: 40),
        const RepositoryCard(),
        const SizedBox(height: 20),
        const RepositoryCard(),
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
      Text(
        _fakeProfile.userRepository.about,
        style: const TextStyle(fontSize: 16),
        textAlign: TextAlign.justify,
      )
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
      Text(
        '${_fakeProfile.courses.name} - ${_fakeProfile.courses.university}',
        style: const TextStyle(fontSize: 16),
      ),
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
      Text(
        '${_fakeProfile.languages.name} - ${_fakeProfile.languages.degree}',
        style: const TextStyle(fontSize: 16),
      ),
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
        _fakeProfile.userRepository.image ??
            const Image(
              image: AssetImage('assets/images/user.png'),
              height: 150,
            ),
        const SizedBox(height: 10),
        Text(
          _fakeProfile.userRepository.name,
          style: const TextStyle(
            fontSize: 28,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 10),
        const Text(
          'Desenvolvedor de Software',
          style: TextStyle(
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
              _fakeProfile.userRepository.email,
              style: const TextStyle(fontSize: 16),
            ),
          ],
        ),
        const SizedBox(height: 10),
        Text(
          _fakeProfile.userRepository.phone,
          style: const TextStyle(fontSize: 16),
        ),
        const SizedBox(height: 10),
        Text(
          '${_fakeProfile.userRepository.city} - ${_fakeProfile.userRepository.uf}',
          style: const TextStyle(fontSize: 16),
        ),
      ],
    );
  }
}
