import 'package:app_auth_i_missatges/pagines/pagina_inici.dart';
import 'package:app_auth_i_missatges/serveis/auth/login_o_registre.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class PortalAuth extends StatelessWidget {
  const PortalAuth({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return const PaginaInici();
          } else {
            return const LoginORegistre();
          }
        },
      ),
    );
  }
}
