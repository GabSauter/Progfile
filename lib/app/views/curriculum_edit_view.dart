import 'dart:io';

import 'package:flutter/material.dart';
import 'package:progfile/app/repositories/certificate_repository.dart';
import 'package:progfile/app/repositories/language_repository.dart';
import 'package:progfile/app/views/components/form_dropdown.dart';
import 'package:progfile/app/views/components/form_text.dart';
import 'package:progfile/app/views/components/form_textfield.dart';
import 'package:progfile/app/views/components/main_button.dart';
import 'package:progfile/app/views/components/masked_textfield.dart';
import 'package:provider/provider.dart';

import '../controllers/profile_edit_controller.dart';
import '../repositories/profile_repository.dart';
import 'components/image_take.dart';
import 'components/snackbar_helper.dart';

class CurriculumEditView extends StatefulWidget {
  const CurriculumEditView({super.key});

  @override
  State<CurriculumEditView> createState() => _CurriculumEditViewState();
}

class _CurriculumEditViewState extends State<CurriculumEditView> {
  final _controller = ProfileRegisterController();

  final ufOptions = [
    "AC",
    "AL",
    "AP",
    "AM",
    "BA",
    "CE",
    "DF",
    "ES",
    "GO",
    "MA",
    "MT",
    "MS",
    "MG",
    "PA",
    "PB",
    "PR",
    "PE",
    "PI",
    "RJ",
    "RN",
    "RS",
    "RO",
    "RR",
    "SC",
    "SP",
    "SE",
    "TO"
  ];

  late ProfileRepository profile;
  String? selectedValueDegree;
  String? selectedValueUf;

  void myCurriculumChange() async {
    if (profile.myProfile.name == '' &&
        profile.myProfile.email == '' &&
        profile.myProfile.phoneNumber == '' &&
        profile.myProfile.address == '') {
      addCurriculum();
    } else {
      editCurriculum();
    }
  }

  void editCurriculum() {
    if (_controller.formKey.currentState!.validate()) {
      try {
        profile.edit(_controller.editProfile(profile.myProfile));
        profile.getMyProfile();
        if (context.mounted) {
          SnackBarHelper.showSuccessSnackBar(
              'Currículo editado com sucesso!', context);
        }
      } catch (e) {
        SnackBarHelper.showErrorSnackBar(e.toString(), context);
      }
    }
    Navigator.pop(context);
  }

  void addCurriculum() {
    if (_controller.formKey.currentState!.validate()) {
      try {
        profile.create(_controller.generateProfile());
        if (context.mounted) {
          SnackBarHelper.showSuccessSnackBar(
              'Currículo adicionado com sucesso!', context);
        }
      } catch (e) {
        SnackBarHelper.showErrorSnackBar(e.toString(), context);
      }
    }
    Navigator.pushNamed(context, '/home');
  }

  @override
  Widget build(BuildContext context) {
    profile = context.watch<ProfileRepository>();

    if (selectedValueDegree == null) {
      selectedValueDegree =
          ModalRoute.of(context)!.settings.arguments as String? ?? 'Estagiário';
      selectedValueUf = profile.myProfile.address != ''
        ? profile.myProfile.address.split(' - ')[1]
        : 'PR';

      _controller.image.value = profile.myProfile.image;
      _controller.nameController.text = profile.myProfile.name;
      _controller.emailController.text = profile.myProfile.email;
      _controller.phoneNumberController.text = profile.myProfile.phoneNumber;
      _controller.aboutYouController.text = profile.myProfile.aboutYou;
      _controller.githubUsernameController.text =
          profile.myProfile.githubUsername ?? '';
      _controller.cityController.text =
          profile.myProfile.address.split(' - ')[0];
      _controller.ufController.text = selectedValueUf!;
      _controller.fieldOfExpertiseController.text =
          profile.myProfile.fieldOfExpertise;
      _controller.selectedDegree.text = selectedValueDegree!;
    }

    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => CertificateRepository()),
        ChangeNotifierProvider(create: (context) => LanguageRepository()),
      ],
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Editar Currículo'),
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ),
        body: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
          child: Form(
            key: _controller.formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                GestureDetector(
                  onTap: () async {
                    await _controller.handleImageSelection(context);
                  },
                  child: ValueListenableBuilder<File?>(
                    valueListenable: _controller.image,
                    builder: (context, value, child) {
                      return ImageDisplay(image: value);
                    },
                  ),
                ),
                const SizedBox(height: 25),
                const FormText(
                  text: 'Nome:',
                  fontSize: 16,
                  color: Colors.black,
                  fontWeight: FontWeight.normal,
                ),
                const SizedBox(height: 10),
                FormTextField(
                  textEditingController: _controller.nameController,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Por favor insira algum valor";
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 15),
                const FormText(
                  text: 'Email:',
                  fontSize: 16,
                  color: Colors.black,
                  fontWeight: FontWeight.normal,
                ),
                const SizedBox(height: 10),
                FormTextField(
                  textEditingController: _controller.emailController,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Por favor insira algum valor";
                    } else if (!value.contains("@")) {
                      return "O email precisa ter o @";
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 15),
                const FormText(
                  text: 'Celular:',
                  fontSize: 16,
                  color: Colors.black,
                  fontWeight: FontWeight.normal,
                ),
                const SizedBox(height: 10),
                MaskedTextField(
                  controller: _controller.phoneNumberController,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Por favor insira algum valor.";
                    }
                    String sanitizedNumber =
                        value.replaceAll(RegExp(r'\D'), '');

                    if (sanitizedNumber.length != 11) {
                      return 'O número de telefone precisa ter 11 digitos.';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 15),
                const FormText(
                  text: 'Sobre Você:',
                  fontSize: 16,
                  color: Colors.black,
                  fontWeight: FontWeight.normal,
                ),
                const SizedBox(height: 10),
                FormTextField(
                  maxLines: 4,
                  length: 200,
                  textEditingController: _controller.aboutYouController,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Por favor insira algum valor";
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 25),
                MainButton(
                  onPressedCallback: () {
                    Navigator.pushNamed(context, '/course');
                  },
                  text: 'Adicionar Curso',
                ),
                const SizedBox(height: 15),
                MainButton(
                  onPressedCallback: () {
                    Navigator.pushNamed(context, '/certificate');
                  },
                  text: 'Adicionar Certificado',
                ),
                const SizedBox(height: 25),
                const FormText(
                  text: 'Username Github:',
                  fontSize: 16,
                  color: Colors.black,
                  fontWeight: FontWeight.normal,
                ),
                const SizedBox(height: 10),
                FormTextField(
                  textEditingController: _controller.githubUsernameController,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Por favor insira algum valor";
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 10),
                MainButton(
                  text: 'Repositórios GitHub',
                  onPressedCallback: () {
                    Navigator.pushNamed(
                      context,
                      '/repository',
                      arguments: ModalRoute.of(context)!.settings.arguments,
                    );
                  },
                ),
                const SizedBox(height: 15),
                const FormText(
                  text: 'Cidade:',
                  fontSize: 16,
                  color: Colors.black,
                  fontWeight: FontWeight.normal,
                ),
                const SizedBox(height: 10),
                FormTextField(
                  textEditingController: _controller.cityController,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Por favor insira sua cidade";
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 15),
                const FormText(
                  text: 'UF:',
                  fontSize: 16,
                  color: Colors.black,
                  fontWeight: FontWeight.normal,
                ),
                const SizedBox(height: 10),
                FormDropdown(
                  value: selectedValueUf ?? 'PR',
                  items: ufOptions
                      .map((uf) => DropdownMenuItem<String>(
                            value: uf,
                            child: Text(uf),
                          ))
                      .toList(),
                  onChanged: (uf) => setState(() => {
                        selectedValueUf = uf,
                        _controller.ufController.text = selectedValueUf!,
                      }),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Por favor insira algum valor";
                    }
                    return null;
                  },
                  errorText: 'Selecione o nível de desenvolvedor',
                ),
                const SizedBox(height: 15),
                const FormText(
                  text: 'Área de Estudo:',
                  fontSize: 16,
                  color: Colors.black,
                  fontWeight: FontWeight.normal,
                ),
                const SizedBox(height: 10),
                FormTextField(
                  textEditingController: _controller.fieldOfExpertiseController,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Por favor insira sua área de estudo";
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 15),
                const FormText(
                  text: 'Nível de Desenvolvedor:',
                  fontSize: 16,
                  color: Colors.black,
                  fontWeight: FontWeight.normal,
                ),
                const SizedBox(height: 10),
                FormDropdown(
                  value: selectedValueDegree ?? 'Estagiário',
                  items: ['Estagiário', 'Júnior', 'Sênior', 'Pleno']
                      .map((grade) => DropdownMenuItem<String>(
                            value: grade,
                            child: Text(grade),
                          ))
                      .toList(),
                  onChanged: (degree) => setState(() => {
                        selectedValueDegree = degree,
                        _controller.selectedDegree.text = selectedValueDegree!,
                      }),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Por favor insira um nível";
                    }
                    return null;
                  },
                  errorText: 'Selecione o nível de desenvolvedor',
                ),
                const SizedBox(height: 25),
                MainButton(
                  onPressedCallback: () {
                    Navigator.pushNamed(context, '/language');
                  },
                  text: 'Adicionar Idioma',
                ),
                const SizedBox(height: 15),
                MainButton(
                  onPressedCallback: () {
                    Navigator.pushNamed(context, '/competence');
                  },
                  text: 'Adicionar Competência',
                ),
                const SizedBox(height: 15),
                MainButton(
                  onPressedCallback: () {
                    myCurriculumChange();
                  },
                  text: 'Concluir',
                  buttonColor: Colors.green[500],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
