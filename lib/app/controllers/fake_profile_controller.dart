import 'package:progfile/app/models/competence_model.dart';
import 'package:progfile/app/models/course_model.dart';
import 'package:progfile/app/models/fake_profile_model.dart';
import 'package:progfile/app/models/language_model.dart';

import '../models/repository_model.dart';
import '../models/user_repository_model.dart';

class FakeProfileController {
  static FakeProfileModel getFakeProfile() {
    return FakeProfileModel(
      userRepository: UserRepositoryModel(
        name: 'Gabriel Oliveira',
        email: 'gabriel.leomartins231@gmail.com',
        phone: '(19) 99619-0935',
        city: 'Ponta Grossa',
        uf: 'PR',
        image: null,
        about: '''
Once upons a time there was a lovely princess. But she had an anchantment upon 
her of a fearful sort which could obly be broken by love's first kiss. She was
locked away in a castle guarded by a terrible fire-breathing dragon.''',
      ),
      courses: CourseModel(
        name: 'Bacharelado em Ciencia da Computacao',
        university: 'UTFPR',
        degree: 'Graduação',
        startDate: '2020',
        finishDate: '2024',
      ),
      languages: LanguageModel(name: 'Ingles', degree: 'Avançado'),
      competences: CompetenceModel(name: 'Flutter', degree: 'Pleno'),
      repositories: RepositoryModel(
        name: 'Ninjaalpha01',
        description: 'Projeto de conclusão de curso',
        url: 'github.com/Ninjaalpha01',
        language: 'Dart',
      ),
    );
  }
}
