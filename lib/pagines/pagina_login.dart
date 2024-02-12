import 'package:app_auth_i_missatges/components/boto_personalitzat.dart';
import 'package:app_auth_i_missatges/components/text_field_personalitzat.dart';
import 'package:flutter/material.dart';

class PaginaLogin extends StatefulWidget {

  // Per navegar de login a registre
  final void Function()? alFerClic;

  const PaginaLogin({super.key, required this.alFerClic,});

  @override
  State<PaginaLogin> createState() => _PaginaLoginState();
}

class _PaginaLoginState extends State<PaginaLogin> {

  final controladorEmail = TextEditingController();
  final controladorPassword = TextEditingController();

  void ferLogin() { // void Function()?

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      body: SafeArea(// Per evitar interfícies dels SO (ex.: el nodge dels mòbils).
        child: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [

                // Logo
                Icon(
                  Icons.message,
                  size: 100,
                  color: Colors.grey[800],
                ),

                const SizedBox(height: 50,),
            
                // Missatge benvinguda
                const Text(
                  "Benvingut/da de nou",
                  style: TextStyle(
                    fontSize: 16,
                  ),
                ),

                const SizedBox(height: 50,),
            
                // TextField Email
                TextFieldPersonalitzat(
                  controladorTextField: controladorEmail, 
                  hintTextField: "Escriu el teu email", 
                  ocultarText: false,
                ),

                const SizedBox(height: 25,),
            
                // TextField Password
                TextFieldPersonalitzat(
                  controladorTextField: controladorPassword, 
                  hintTextField: "Escriu el teu password", 
                  ocultarText: true,
                ),

                const SizedBox(height: 25,),

                // Botó Sign in
                BotoPersonalitzat(
                  accioOnTap: ferLogin, 
                  textDelBoto: "Login",
                ),

                const SizedBox(height: 25,),

                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text("Encara no ets membre?"),
                    const SizedBox(width: 4,),
                    GestureDetector(
                      onTap: widget.alFerClic,
                      //widget. al davant, perquè està declarada en la classe inicial.
                      child: const Text(
                        "Registra't",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}