import 'package:app_auth_i_missatges/auth/portal_auth.dart';
import 'package:app_auth_i_missatges/firebase_options.dart';
import 'package:app_auth_i_missatges/serveis/auth/login_o_registre.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

/*
Executar programa especificant el port en la Terminal:
flutter run -d chrome --web-port 5555

Afegir una dependència a l'arxiu pubspec.yaml des de la Terminal:
flutter pub add hive
*/

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: PortalAuth(),
    );
  }
}

// Delete the pubspec.lock file and running flutter pub get again 
//    when it doesn't find the imports.

/*
Projecte de Firebase: FlutterChatApp (compte escola)
====================================================
*/

// Llistar els usuaris de l'aplicació
// ==================================
// 1) Habilitar la Firestore Database.
//    - Seleccionar la regió.
//    - Triar "Start in production mode"
//    - Anar a "Rules", i canviar el "allow read, write: if true;"
//        (i prémer "Publicar").
//
// 2) Crear un arxiu pels serveis de chat:
//    - serveis/chat/servei_chat.dart
//
// 3) Importar la llibreria de Firestore:
//    - flutter pub add cloud_firestore