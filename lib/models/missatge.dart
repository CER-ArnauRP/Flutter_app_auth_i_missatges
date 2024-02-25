import 'package:cloud_firestore/cloud_firestore.dart';

class Missatge {
  final String idDeLAutor;
  final String emailDeLAutor;
  final String idDeQuiElRep;
  final String missatge;
  final Timestamp timestamp;

  Missatge({
    required this.idDeLAutor,
    required this.emailDeLAutor,
    required this.idDeQuiElRep,
    required this.missatge,
    required this.timestamp,
  });

  Map<String, dynamic> retornarMapaDeLObjecte() {
    return {
      "idDeLAutor": idDeLAutor,
      "emailDeLAutor": emailDeLAutor,
      "idDeQuiElRep": idDeQuiElRep,
      "missatge": missatge,
      "timestamp": timestamp,
    };
  }
}
