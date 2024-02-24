import 'package:app_auth_i_missatges/components/boto_personalitzat.dart';
import 'package:app_auth_i_missatges/components/text_field_personalitzat.dart';
import 'package:flutter/material.dart';

class PaginaRegistre extends StatefulWidget {

  // Per navegar de registre a login
  final void Function()? alFerClic;

  const PaginaRegistre({super.key, required this.alFerClic,});

  @override
  State<PaginaRegistre> createState() => __PaginaRegistrStateState();
}

class __PaginaRegistrStateState extends State<PaginaRegistre> {
  final controladorEmail = TextEditingController();
  final controladorPassword = TextEditingController();
  final controladorConfirmarPassword = TextEditingController();

  void crearCompte() { // void Function()?

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
                  "Creem un nou compte d'usuari!",
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
            
                // TextField Password
                TextFieldPersonalitzat(
                  controladorTextField: controladorConfirmarPassword, 
                  hintTextField: "Torna a escriu el teu password", 
                  ocultarText: true,
                ),

                const SizedBox(height: 25,),

                // Botó Sign in
                BotoPersonalitzat(
                  accioOnTap: crearCompte, 
                  textDelBoto: "Crear compte",
                ),

                const SizedBox(height: 25,),

                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text("Ja ets membre?"),
                    const SizedBox(width: 4,),
                    GestureDetector(
                      onTap: widget.alFerClic,
                      //widget. al davant, perquè està declarada en la classe inicial.
                      child: const Text(
                        "Fes login",
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