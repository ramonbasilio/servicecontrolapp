import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:firebase_core/firebase_core.dart';
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
  runApp(
    ChangeNotifierProvider<RepositoryClient>(
      create: (context) => RepositoryClient(),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  static GlobalKey<NavigatorState> navKey = GlobalKey();

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    
    return MaterialApp(
      navigatorKey: navKey,
      debugShowCheckedModeBanner: false,
      title: 'Service Control 1.0',
      theme: ThemeData(
        primarySwatch: Colors.grey,
      ),
      home: const PageInicial(),
    );
  }
}
