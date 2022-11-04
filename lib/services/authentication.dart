import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn();

  // connexion avec google

  Future<UserCredential> signInWithGoogle() async {
    // Déclencher le flux d'auth

    final googleUser = await _googleSignIn.signIn();

    // obtenir les details de validation de la demande

    final googleAuth = await googleUser!.authentication;

    // Creer un nouvel identifiant

    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );

    //Renvoi de l'identifiant du user

    return await _auth.signInWithCredential(credential);
  }

  // user state

  Stream<User?> get user => _auth.authStateChanges();

  // deconnexion

  Future<void> signOut() async {
    await _googleSignIn.signOut();
    await _auth.signOut();
  }
}
