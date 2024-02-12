import 'package:flutter/material.dart';

class BotoPersonalitzat extends StatelessWidget {

  final void Function()? accioOnTap;
  final String textDelBoto;

  const BotoPersonalitzat({
    super.key,
    required this.accioOnTap,
    required this.textDelBoto,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: accioOnTap,
      child: Container(
        padding: const EdgeInsets.all(25),
        decoration: BoxDecoration(
          color: const Color.fromARGB(255, 45, 45, 45),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Center(
          child: Text(
            textDelBoto,
            style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 18,
            ),
          ),
        ),
      ),
    );
  }
}