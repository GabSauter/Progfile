import 'package:flutter/material.dart';

import 'package:firebase_core/firebase_core.dart';
import 'package:progfile/app/repositories/certificate_repository.dart';
import 'package:provider/provider.dart';
import 'firebase_options.dart';
import 'main_app.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => CertificateRepository(),
        )
      ],
      child: const MainApp(),
    ),
  );
}
