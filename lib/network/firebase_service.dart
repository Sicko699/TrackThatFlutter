import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/widgets.dart';

class FirebaseService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<Map<String, dynamic>?> loginAndFetchUserData({
    required String email,
    required String password,
  }) async {
    try {
      // Autenticazione
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      // Prendi l'UID dell'utente autenticato
      String uid = userCredential.user!.uid;

      // Recupera il documento dell'utente da Firestore
      DocumentSnapshot userDoc =
          await _firestore.collection('utenti').doc(uid).get();

      debugPrint('User document data: ${userDoc.data()}');
      if (userDoc.exists) {
        return userDoc.data() as Map<String, dynamic>;
      } else {
        print('Documento utente non trovato per uid: $uid');
        return null;
      }
    } on FirebaseAuthException catch (e) {
      print('Errore autenticazione: ${e.message}');
      return null;
    } catch (e) {
      print('Errore generico: $e');
      return null;
    }
  }
}
