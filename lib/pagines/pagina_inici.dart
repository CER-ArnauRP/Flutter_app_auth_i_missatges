//import 'package:app_auth_i_missatges/auth/servei_auth.dart';
import 'dart:js';

import 'package:app_auth_i_missatges/auth/servei_auth.dart';
import 'package:app_auth_i_missatges/components/drawer_aplicacio.dart';
import 'package:app_auth_i_missatges/components/item_usuari.dart';
import 'package:app_auth_i_missatges/pagines/pagina_chat.dart';
import 'package:app_auth_i_missatges/serveis/chat/servei_chat.dart';
import 'package:flutter/material.dart';

class PaginaInici extends StatelessWidget {
  PaginaInici({super.key});

  // Movem la funcionalitat a l'opció del Drawer.
  /*void logout() {
    final serveiAuth = ServeiAuth();
    serveiAuth.tancarSessio();
  }*/

  // Agafem els serveis de chat i de auth.
  final ServeiChat _serveiChat = ServeiChat();
  final ServeiAuth _serveiAuth = ServeiAuth();

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
      body: _construeixLlistaUsuaris(),
    );
  }

  // Definim el Widget de la llista d'usuaris en aquesta mateixa classe/arxiu.
  Widget _construeixLlistaUsuaris() {
    return StreamBuilder(
      stream: _serveiChat.getStreamUsuaris(),
      builder: (context, snapshot) {
        // Mirar si hi ha errors.
        if (snapshot.hasError) {
          return const Text("Error");
        }

        // Carregar dades.
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Text("Carregant...");
        }

        // Retornar la llista.
        return ListView(
          children: snapshot.data!
              .map<Widget>(
                  (dadesUsuari) => _construirItemLlista(dadesUsuari, context))
              .toList(),
        );
      },
    );
  }

  // Widget per contenir un ítem de la llista (un usuari).
  Widget _construirItemLlista(
      Map<String, dynamic> dadesUsuari, BuildContext context) {
    // Mostrar tots els usuaris, excepte l'usuari actual.

    if (dadesUsuari["email"] != _serveiAuth.getUsuariActual()!.email) {
      return ItemUsuari(
        text: dadesUsuari["email"],
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => PaginaChat(
                emailDeAmbQuiParlem: dadesUsuari["email"],
              ),
            ),
          );
        },
      );
    } else {
      return Container(); // Sí és l'usuari actual, no el mostrem.
    }
  }
}
