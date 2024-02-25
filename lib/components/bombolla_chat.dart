import 'package:flutter/material.dart';

class BombollaChat extends StatelessWidget {
  final String missatge;
  final bool esUsuariActual;

  const BombollaChat({
    super.key,
    required this.missatge,
    required this.esUsuariActual,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: esUsuariActual ? Colors.green[200] : Colors.grey[200],
        borderRadius: BorderRadius.circular(15),
      ),
      padding: EdgeInsets.all(10),
      margin: EdgeInsets.all(10),
      child: Text(missatge),
    );
  }
}
