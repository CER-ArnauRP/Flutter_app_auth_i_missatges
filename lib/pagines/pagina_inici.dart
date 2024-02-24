import 'package:app_auth_i_missatges/auth/servei_auth.dart';
import 'package:flutter/material.dart';

class PaginaInici extends StatelessWidget {
  const PaginaInici({super.key});

  void logout() {
    final serveiAuth = ServeiAuth();
    serveiAuth.tancarSessio();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Pàgina inici"),
        actions: [
          IconButton(
            onPressed: logout,
            icon: Icon(Icons.logout),
          ),
        ],
      ),
    );
  }
}
