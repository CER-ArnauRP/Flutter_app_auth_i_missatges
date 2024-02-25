import 'dart:js';

import 'package:app_auth_i_missatges/auth/servei_auth.dart';
import 'package:app_auth_i_missatges/components/text_field_personalitzat.dart';
import 'package:app_auth_i_missatges/serveis/chat/servei_chat.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class PaginaChat extends StatelessWidget {
  final String emailDeAmbQuiParlem;
  final String idDeQuiRepElMissatge;

  PaginaChat({
    super.key,
    required this.emailDeAmbQuiParlem,
    required this.idDeQuiRepElMissatge,
  });

  final TextEditingController _controladorMissatge = TextEditingController();
  final ServeiChat _serveiChat = ServeiChat();
  final ServeiAuth _serveiAuth = ServeiAuth();

  void enviarMissatge() async {
    if (_controladorMissatge.text.isNotEmpty) {
      await _serveiChat.enviarMissatge(
          idDeQuiRepElMissatge, _controladorMissatge.text);

      // Netejem el camp de text.
      _controladorMissatge.clear();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(emailDeAmbQuiParlem),
      ),
      body: Column(
        children: [
          // Zona per mostrar l'historial de missatges.
          Expanded(
            child: _construirLlistaDeMissatges(),
          ),

          // Zona per agafar l'input de l'usuari.
          _construirZonaInputUsuari(),
        ],
      ),
    );
  }

  // Construir llista de missatges.
  Widget _construirLlistaDeMissatges() {
    String idDeQuiEnviaElMissatges = _serveiAuth.getUsuariActual()!.uid;

    return StreamBuilder(
      stream: _serveiChat.getMissatges(
          idDeQuiRepElMissatge, idDeQuiEnviaElMissatges),
      builder: (context, snapshot) {
        // Errors.
        if (snapshot.hasError) {
          return const Text("Error");
        }

        // Carregant.
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Text("Carregant...");
        }

        // Retornar ListView.
        return ListView(
          children: snapshot.data!.docs
              .map((document) => _construirItemMissatge(document))
              .toList(),
        );
      },
    );
  }

  // Construim l'ItemMissatge.
  Widget _construirItemMissatge(DocumentSnapshot documentSnapshot) {
    Map<String, dynamic> data = documentSnapshot.data() as Map<String, dynamic>;

    // Si és l'usuari actual.
    bool esUsuariActual =
        data["idDeLAutor"] == _serveiAuth.getUsuariActual()!.uid;

    // Mostrar missatges de l'usuari actual a la dreta, si no, a l'esquerra.
    var aliniament =
        esUsuariActual ? Alignment.centerRight : Alignment.centerLeft;

    return Container(
      alignment: aliniament,
      child: Text(
        data["missatge"],
      ),
    );
  }

  // Construim la zona d'input de l'usuari.
  Widget _construirZonaInputUsuari() {
    return Row(
      children: [
        // TextField.
        Expanded(
          child: TextFieldPersonalitzat(
            controladorTextField: _controladorMissatge,
            hintTextField: "Escriu un missatge",
            ocultarText: false,
          ),
        ),

        // Botó.
        IconButton(
          onPressed: enviarMissatge,
          icon: const Icon(Icons.arrow_upward),
        ),
      ],
    );
  }
}
