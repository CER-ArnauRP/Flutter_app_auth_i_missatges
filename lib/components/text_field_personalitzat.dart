import 'package:flutter/material.dart';

class TextFieldPersonalitzat extends StatelessWidget {

  final TextEditingController controladorTextField;
  final String hintTextField;
  final bool ocultarText;
  final FocusNode ?focusNode;

  const TextFieldPersonalitzat({
    super.key,
    required this.controladorTextField,
    required this.hintTextField,
    required this.ocultarText,
    this.focusNode
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controladorTextField,
      obscureText: ocultarText,
      focusNode: focusNode,
      style: TextStyle(color: Colors.white),
      decoration: InputDecoration(
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.grey.shade200),
        ),
        focusedBorder: const OutlineInputBorder(
          borderSide: BorderSide(color: Colors.white),
        ),
        fillColor: Colors.grey[600],
        filled: true,
        hintText: hintTextField,
        hintStyle: TextStyle(color: Colors.grey.shade400),
      ),
    );
  }
}