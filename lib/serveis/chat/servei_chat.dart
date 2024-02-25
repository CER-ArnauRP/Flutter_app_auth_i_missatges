import 'package:app_auth_i_missatges/models/missatge.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class ServeiChat {
  // Agafar la instància de la Firestore.
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

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
  Future<void> enviarMissatge(String idDequiRepMissatge, missatge) async {
    // Obtenim info de l'usuari actual.
    final String idUsuariActual = _auth.currentUser!.uid;
    final String emailUsuariActual = _auth.currentUser!.email!;
    final Timestamp timestamp = Timestamp.now();

    // Crear el nou missatge.
    Missatge nouMissatge = Missatge(
      idDeLAutor: idUsuariActual,
      emailDeLAutor: emailUsuariActual,
      idDeQuiElRep: idDequiRepMissatge,
      missatge: missatge,
      timestamp: timestamp,
    );

    // Construim la sala de chat pels dos ususaris.
    //    Ordenada per garantir que sigui única.
    // Construir id de la sala de chat.
    List<String> idsUsuaris = [idUsuariActual, idDequiRepMissatge];
    idsUsuaris.sort();
    // Fa que l'ID de la sala de chat sigui el mateix pels dos ususaris).
    String idSalaChat = idsUsuaris.join("_");

    // Afegir el missatge a la BD.
    await _firestore
        .collection("sales_chat")
        .doc(idSalaChat)
        .collection("missatges")
        .add(nouMissatge.retornarMapaDeLObjecte());
  }

  // Mètode per rebre missatges.
  Stream<QuerySnapshot> getMissatges(String idUsuariActual, idDeLAltreUsuari) {
    // Construim el ID de la sala de chat com quan la creem (o hi afegim missatges).
    List<String> idsUsuaris = [idUsuariActual, idDeLAltreUsuari];
    idsUsuaris.sort();
    String idSalaChat = idsUsuaris.join("_");

    return _firestore
        .collection("sales_chat")
        .doc(idSalaChat)
        .collection("missatges")
        .orderBy(
          "timestamp",
          descending: false,
        )
        .snapshots();
  }
}
