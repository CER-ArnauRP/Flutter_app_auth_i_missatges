import 'package:cloud_firestore/cloud_firestore.dart';

class ServeiChat {
  // Agafar la instància de la Firestore.
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // Agafar el stream d'usuaris.
  /*
  --> Map: representa un usuari, objecte que té la informació d'un usuari:
  {
    "email": email1@email1.com,
    "id": ...
  },
  {
    "email": email2@email2.com,
    "id": ...
  }
  --> List: com es mostra prèviament, és una llista de Maps.
  */
  Stream<List<Map<String, dynamic>>> getStreamUsuaris() {
    return _firestore.collection("Usuaris").snapshots().map((event) {
      return event.docs.map((document) {
        // Passem per a cada usuari.
        final usuari = document.data();

        return usuari;
      }).toList();
    });
  }

  // Mètode per enviar missatge.

  // Mètode per rebre missatges.
}
