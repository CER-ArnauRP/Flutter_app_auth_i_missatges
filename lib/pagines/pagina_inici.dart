//import 'package:app_auth_i_missatges/auth/servei_auth.dart';
import 'package:app_auth_i_missatges/components/drawer_aplicacio.dart';
import 'package:flutter/material.dart';

class PaginaInici extends StatelessWidget {
  const PaginaInici({super.key});

  // Movem la funcionalitat a l'opció del Drawer.
  /*void logout() {
    final serveiAuth = ServeiAuth();
    serveiAuth.tancarSessio();
  }*/

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Pàgina inici"),
        /*actions: [ // Movem la funcionalitat a l'opció del Drawer.
          IconButton(
            onPressed: logout,
            icon: Icon(Icons.logout),
          ),
        ],*/
      ),
      drawer: const DrawerAplicacio(),
    );
  }
}
