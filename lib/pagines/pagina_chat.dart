import 'package:flutter/material.dart';

class PaginaChat extends StatelessWidget {
  final String emailDeAmbQuiParlem;

  const PaginaChat({
    super.key,
    required this.emailDeAmbQuiParlem,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(emailDeAmbQuiParlem),
      ),
    );
  }
}
