import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class ServeiAuth {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<UserCredential> loginAmbEmailIPassword(String email, password) async {
    try {
      // Fem el procés de login de l'usuari amb les credencials rebudes.
      UserCredential credencialUsuari = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      // =======================================================================
      // Per si de cas creem algun usuari des de Firebase, en compte de a través
      //    de l'aplicació, creem també un registre per a l'usuari que ha fet
      //    login.
      // Creem també un registre de l'usuari a FirebaseStore.
      _firestore.collection("Usuaris").doc(credencialUsuari.user!.uid).set({
        "uid": credencialUsuari.user!.uid,
        "email": email, //credencialUsuari.user!.email,
      });
      // =======================================================================

      return credencialUsuari;
    } on FirebaseAuthException catch (e) {
      throw Exception(e.code);
    }
  }

  Future<void> tancarSessio() async {
    return await _auth.signOut();
  }

  Future<UserCredential> registreAmbEmailIPassword(
      String email, password) async {
    try {
      // Creem l'usuari a Firebase Auth.
      UserCredential credencialUsuari =
          await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      // Creem també un registre de l'usuari a FirebaseStore.
      _firestore.collection("Usuaris").doc(credencialUsuari.user!.uid).set({
        "uid": credencialUsuari.user!.uid,
        "email": email, //credencialUsuari.user!.email,
      });

      return credencialUsuari;
    } on FirebaseException catch (e) {
      throw Exception(e.code);
    }
  }

  User? getUsuariActual() {
    return _auth.currentUser;
  }
}
