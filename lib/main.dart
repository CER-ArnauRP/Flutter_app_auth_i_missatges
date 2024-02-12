import 'package:app_auth_i_missatges/pagines/pagina_login.dart';
import 'package:app_auth_i_missatges/pagines/pagina_registre.dart';
import 'package:flutter/material.dart';

/*
Executar programa especificant el port en la Terminal:
flutter run -d chrome --web-port 5555

Afegir una dependència a l'arxiu pubspec.yaml des de la Terminal:
flutter pub add hive
*/

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: PaginaRegistre(),
    );
  }
}
