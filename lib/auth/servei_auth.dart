import 'package:firebase_auth/firebase_auth.dart';

class ServeiAuth {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<UserCredential> loginAmbEmailIPassword(String email, password) async {
    try {
      UserCredential credencialUsuari = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      return credencialUsuari;
    } on FirebaseAuthException catch (e) {
      throw Exception(e.code);
    }
  }

  Future<void> tancarSessio() async {
    return await _auth.signOut();
  }
}
