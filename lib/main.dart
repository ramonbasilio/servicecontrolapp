import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:servicecontrolapp/page_teste.dart';
import 'package:servicecontrolapp/provider/provider.dart';
import 'package:servicecontrolapp/view/page_inicial.dart';
import 'package:servicecontrolapp/view/page_ordem_servico/page_ordem_servico.dart';
import 'package:servicecontrolapp/view/pages_client/page_client.dart';
import 'package:servicecontrolapp/view/pages_client/page_register_client.dart';
import 'controller/Repository/repository_client.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider<RepositoryClient>(
          create: (context) => RepositoryClient()),
      Provider<ProviderPdf>(create: (context) => ProviderPdf()),
    ],
    child: const MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  static GlobalKey<NavigatorState> navKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      navigatorKey: navKey,
      debugShowCheckedModeBanner: false,
      title: 'Service Control 1.0',
      theme: ThemeData(
        useMaterial3: false,
        primarySwatch: Colors.grey,
      ),
      home: const PageInicial(),
    );
  }
}
