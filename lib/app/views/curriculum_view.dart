import 'package:flutter/material.dart';
import 'package:progfile/app/models/fake_profile_model.dart';
import 'package:progfile/app/models/git_project_model.dart';
import 'package:progfile/app/views/components/repository_card.dart';
import 'package:provider/provider.dart';
import '../controllers/fake_profile_controller.dart';
import '../models/profile_model.dart';
import '../repositories/curriculum_reposiotory.dart';
import 'components/course_item.dart';

class CurriculumView extends StatefulWidget {
  const CurriculumView({Key? key}) : super(key: key);

  @override
  State<CurriculumView> createState() => _CurriculumViewState();
}

class _CurriculumViewState extends State<CurriculumView> {
  final FakeProfileModel _fakeProfile = FakeProfileController.getFakeProfile();
  late CurriculumRepository curriculumInfo;

  @override
  Widget build(BuildContext context) {
    final profileInfo =
        ModalRoute.of(context)!.settings.arguments as ProfileModel;

    curriculumInfo = context.watch<CurriculumRepository>();

    if (profileInfo.runtimeType != ProfileModel) {
      Navigator.pop(context);
    }

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
      body: buildBody(profileInfo),
    );
  }

  Widget buildBody(ProfileModel profile) {
    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 40),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          buildUserBasicInfo(profile),
          const SizedBox(height: 30),
          buildUserAcademicInfo(profile),
          const Divider(
            color: Colors.black,
            thickness: 1,
            height: 50,
          ),
          buildGithubInfo(profile),
        ],
      ),
    );
  }

  Widget buildGithubInfo(ProfileModel profile) {
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
              profile.githubUsername ?? 'Não informado',
              style: const TextStyle(
                decoration: TextDecoration.underline,
                fontSize: 16,
              ),
            ),
          ],
        ),
        const SizedBox(height: 30),
        Column(
          children: [
            for (GitProjectModel item in curriculumInfo.gitProjects)
              RepositoryCard(
                title: item.name,
                description: item.description,
                languages: item.language,
              ),
          ],
        ),
      ],
    );
  }

  Widget buildUserAcademicInfo(ProfileModel profile) {
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
        profile.aboutYou,
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
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: curriculumInfo.courses.map((item) {
          return CourseItem(course: item);
        }).toList(),
      )
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
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: curriculumInfo.languages.map((item) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                '${item.name} - ${item.degree}',
                style: const TextStyle(fontSize: 16),
              ),
              const SizedBox(height: 10),
            ],
          );
        }).toList(),
      ),
    ];
    List<Widget> skills = [
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Competências:',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 10),
          curriculumInfo.competences.length >= 4
              ? Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Column(
                      children: curriculumInfo.competences
                          .sublist(0, curriculumInfo.competences.length ~/ 2)
                          .map((item) {
                        return Column(
                          children: [
                            Text(item.name),
                            const SizedBox(height: 10),
                          ],
                        );
                      }).toList(),
                    ),
                    const SizedBox(width: 150),
                    Column(
                      children: curriculumInfo.competences
                          .sublist(curriculumInfo.competences.length ~/ 2)
                          .map((item) {
                        return Column(
                          children: [
                            Text(item.name),
                            const SizedBox(height: 10),
                          ],
                        );
                      }).toList(),
                    ),
                  ],
                )
              : Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: curriculumInfo.competences.map((item) {
                    return Column(
                      children: [
                        Text('${item.name} - ${item.degree}',
                            style: const TextStyle(fontSize: 16)),
                        const SizedBox(height: 10),
                      ],
                    );
                  }).toList()),
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
    // Implemente a lógica para construir informações acadêmicas
    // com base nos dados do perfil.
    // Retorne os widgets apropriados.
  }

  Widget buildUserBasicInfo(ProfileModel profile) {
    return Column(
      children: [
        profile.image != null
            ? Image.file(
                profile.image!,
                height: 150,
              )
            : const Image(
                image: AssetImage('assets/images/user.png'),
                height: 150,
              ),
        const SizedBox(height: 10),
        Text(
          profile.name,
          style: const TextStyle(
            fontSize: 28,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 10),
        Text(
          profile.fieldOfExpertise,
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
              profile.email,
              style: const TextStyle(fontSize: 16),
            ),
          ],
        ),
        const SizedBox(height: 10),
        Text(
          profile.phoneNumber,
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
