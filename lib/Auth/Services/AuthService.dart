import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:injectable/injectable.dart';
import 'package:poetry_app/firebase_options.dart';

@singleton
class AuthService {
  // instance of firebase auth
  final FirebaseAuth _auth = FirebaseAuth.instance;

  // instance of _googleSignIn
  final GoogleSignIn _googleSignIn = GoogleSignIn(
      clientId: DefaultFirebaseOptions.currentPlatform.iosClientId);

  Future<String?> signInWithGoogle() async {
    try {
      final GoogleSignInAccount? googleSignInAccount =
          await _googleSignIn.signIn();
      final GoogleSignInAuthentication googleSignInAuthentication =
          await googleSignInAccount!.authentication;
      final AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleSignInAuthentication.accessToken,
        idToken: googleSignInAuthentication.idToken,
      );
      await _auth.signInWithCredential(credential);
      return "Google sign in was successful";
    } on FirebaseAuthException catch (e) {
      return e.message;
    }
  }

  Future<String?> signInWithPassword(String email, String password) async {
    try {
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      return "Sign in succesful";
    } on FirebaseAuthException catch (_) {
      return "Invalid email or password";
    } on Exception catch (_) {
      return "Error";
    }
  }

  Future<String?> signUpWithPassword(
      String name, String email, String password) async {
    try {
      UserCredential userCredential = await _auth
          .createUserWithEmailAndPassword(email: email, password: password);

      User? user = userCredential.user;
      if (user == null) {
        throw Exception();
      }
      await user.updateDisplayName(name);
      await user.reload();
      return "Sign up succesful";
    } on FirebaseAuthException catch (e) {
      if (e.code == "operation-not-allowed") {
        return "Error, signup disabled";
      }
      return e.message;
    } on Exception catch (_) {
      return "Error";
    }
  }

  Future<String?> resetPassword(String email) async {
    try {
      await _auth.sendPasswordResetEmail(email: email);
      return null;
    } on FirebaseAuthException catch (e) {
      return "Invalid email";
    } catch (_) {
      return "Error";
    }
  }

  Future<void> logOut() async {
    await _googleSignIn.signOut();
    await _auth.signOut();
  }
}
