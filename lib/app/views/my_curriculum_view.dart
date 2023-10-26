import 'package:flutter/material.dart';
import 'package:progfile/app/models/profile_model.dart';
import 'package:progfile/app/repositories/curriculum_reposiotory.dart';
import 'package:progfile/app/views/components/repository_card.dart';
import 'package:progfile/app/views/components/main_button.dart';
import 'package:progfile/app/views/components/secondary_button.dart';
import 'package:provider/provider.dart';

import 'components/course_item.dart';

class MyCurriculumView extends StatefulWidget {
  final ProfileModel userRepository;
  // depois mudar para = UserRepositoryModel();

  const MyCurriculumView({Key? key, required this.userRepository})
      : super(key: key);

  @override
  State<MyCurriculumView> createState() => _MyCurriculumViewState();
}

class _MyCurriculumViewState extends State<MyCurriculumView> {
  late CurriculumRepository curriculumInfo;

  @override
  Widget build(BuildContext context) {
    curriculumInfo = context.watch<CurriculumRepository>();

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
    return Consumer<CurriculumRepository>(
      builder: (context, curriculumInfo, child) {
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
                  widget.userRepository.githubUsername ?? 'Não informado',
                  style: const TextStyle(
                    decoration: TextDecoration.underline,
                    fontSize: 16,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 30),
            Column(
              children: curriculumInfo.gitProjects.map((item) {
                return RepositoryCard(
                  title: item.name,
                  description: item.description,
                  languages: item.language,
                );
              }).toList(),
            ),
          ],
        );
      },
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
        widget.userRepository.aboutYou,
        style: const TextStyle(fontSize: 16),
        textAlign: TextAlign.justify,
      ),
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
      const SizedBox(height: 30),
      Center(
        child: MainButton(
          text: 'Meus Certificados',
          onPressedCallback: () =>
              {Navigator.pushNamed(context, '/certificate')},
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
        widget.userRepository.image != null
            ? Image.file(
                widget.userRepository.image!,
                height: 150,
              )
            : const Image(
                image: AssetImage('assets/images/user.png'),
                height: 150,
              ),
        const SizedBox(height: 10),
        Text(
          widget.userRepository.name,
          style: const TextStyle(
            fontSize: 28,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 10),
        Text(
          widget.userRepository.fieldOfExpertise,
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
              widget.userRepository.email,
              style: const TextStyle(fontSize: 16),
            ),
          ],
        ),
        const SizedBox(height: 10),
        Text(
          widget.userRepository.phoneNumber,
          style: const TextStyle(fontSize: 16),
        ),
        const SizedBox(height: 10),
        Text(
          widget.userRepository
              .address, // depois mudar o endereco para cidade e estado
          style: const TextStyle(fontSize: 16),
        ),
      ],
    );
  }
}
