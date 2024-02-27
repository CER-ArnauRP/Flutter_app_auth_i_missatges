import 'dart:js';

import 'package:app_auth_i_missatges/auth/servei_auth.dart';
import 'package:app_auth_i_missatges/components/bombolla_chat.dart';
import 'package:app_auth_i_missatges/components/text_field_personalitzat.dart';
import 'package:app_auth_i_missatges/serveis/chat/servei_chat.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class PaginaChat extends StatefulWidget {
  final String emailDeAmbQuiParlem;
  final String idDeQuiRepElMissatge;

  const PaginaChat({
    super.key,
    required this.emailDeAmbQuiParlem,
    required this.idDeQuiRepElMissatge,
  });

  @override
  State<PaginaChat> createState() => _PaginaChatState();
}

class _PaginaChatState extends State<PaginaChat> {
  final TextEditingController _controladorMissatge = TextEditingController();

  final ServeiChat _serveiChat = ServeiChat();
  final ServeiAuth _serveiAuth = ServeiAuth();

  // -----------------------------------------------------------------
  // Fer que el llistat de missatges es mostri des de sota (l'últim), 
  //    i hagis de pujar per veure els missatges anteriors.
  // Creem un node focused.
  FocusNode nodeFocus = FocusNode();
  @override
  void initState() {
    super.initState();

    // Afegim un listener al FocusNode.
    nodeFocus.addListener(() {
      // Si estem en focus, esperem a què el teclat virtual del 
      //    dispositiu es mostri. Llavors calculem el que quedi 
      //    d'espai per mostrar els missatges.
      // Quan es mostri el teclat, esperem un moment (500 milisegons).
      Future.delayed(const Duration(milliseconds: 500), () => ferScrollCapAVall(),);
    });

    // Lo anterior era per tenir en compte el teclat, en cas de dispositiu mòbil.
    // Lo de a continuació és perquè la llista de missatges estigui a baix directament.
    // Esperem a què la ListView estigui construïda, i després fem que vagi a baix.
    Future.delayed(const Duration(milliseconds: 500), () => ferScrollCapAVall(),);
  }

  @override
  void dispose() {
    // Eliminem el FocusNode i els controladors.
    nodeFocus.dispose();
    _controladorMissatge.dispose();

    super.dispose();
  }

  // Controlador Scroll.
  final ScrollController _scrollController = ScrollController();
  void ferScrollCapAVall() {

    _scrollController.animateTo(
      _scrollController.position.maxScrollExtent, 
      duration: const Duration(seconds: 1), 
      curve: Curves.fastOutSlowIn,
    );
  }
  // -----------------------------------------------------------------

  void enviarMissatge() async {
    if (_controladorMissatge.text.isNotEmpty) {
      await _serveiChat.enviarMissatge(
          widget.idDeQuiRepElMissatge, _controladorMissatge.text);

      // Netejem el camp de text.
      _controladorMissatge.clear();
    }

    // Quan hem enviat el missatge, volem que faci scroll cap a vall,
    //    perquè es mostri l'últim missatge.
    ferScrollCapAVall();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.emailDeAmbQuiParlem),
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
          widget.idDeQuiRepElMissatge, idDeQuiEnviaElMissatges),
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
          controller: _scrollController,
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
      child: BombollaChat(
        missatge: data["missatge"],
        esUsuariActual: esUsuariActual,
      ), //Text(data["missatge"],),
    );
  }

  // Construim la zona d'input de l'usuari.
  Widget _construirZonaInputUsuari() {
    return Padding(
      padding: const EdgeInsets.only(left: 25, bottom: 50),
      child: Row(
        children: [
          // TextField.
          Expanded(
            child: TextFieldPersonalitzat(
              controladorTextField: _controladorMissatge,
              hintTextField: "Escriu un missatge",
              ocultarText: false,
              focusNode: nodeFocus,
            ),
          ),

          // Botó.
          Container(
            decoration: const BoxDecoration(
              color: Colors.green,
              shape: BoxShape.circle,
            ),
            padding: const EdgeInsets.symmetric(horizontal: 25),
            child: IconButton(
              onPressed: enviarMissatge,
              icon: const Icon(
                Icons.arrow_upward,
                color: Colors.white,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
