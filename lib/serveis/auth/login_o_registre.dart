import 'package:app_auth_i_missatges/pagines/pagina_login.dart';
import 'package:app_auth_i_missatges/pagines/pagina_registre.dart';
import 'package:flutter/material.dart';

class LoginORegistre extends StatefulWidget {
  const LoginORegistre({super.key});

  @override
  State<LoginORegistre> createState() => _LoginORegistreState();
}

class _LoginORegistreState extends State<LoginORegistre> {

  // Primer mostrem la pàgina de Login
  bool mostraPaginaDeLogin = true;

  // Intercanviar entre les pàgines de Login i Registre
  void intercanviarPaginesLoginRegistre() {
    setState(() {
      mostraPaginaDeLogin = !mostraPaginaDeLogin;
    });
  }

  @override
  Widget build(BuildContext context) {
    
    if (mostraPaginaDeLogin) {
      return PaginaLogin(alFerClic: intercanviarPaginesLoginRegistre,);
    } else {
      return PaginaRegistre(alFerClic: intercanviarPaginesLoginRegistre,);
    }
  }
}