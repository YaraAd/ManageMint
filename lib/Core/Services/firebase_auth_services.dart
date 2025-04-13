import 'package:firebase_auth/firebase_auth.dart';
import 'package:managemint/Core/errors/exceptions.dart';

class FirebaseAuthServices {
  Future<User> createUserwithEmialandPassword(
      {required String email, required String password}) async {
    try {
      final credential =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      return credential.user!;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        throw CustomExceptions(message: 'The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        throw CustomExceptions(
            message: 'The account already exists for that email.');
      } else {
        throw CustomExceptions(message: 'An error occurred, please try later.');
      }
    } catch (e) {
      throw CustomExceptions(message: 'An error occurred, please try later.');
    }
  }

  Future<User> signInWithEmailandPassword(
      {required String email, required String password}) async {
    try {
      final credential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);
      return credential.user!;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        throw CustomExceptions(message: 'No user found for that email.');
      } else if (e.code == 'wrong-password') {
        throw CustomExceptions(
            message: 'Wrong password provided for that user.');
      } else {
        throw CustomExceptions(message: 'An error occurred, please try later.');
      }
    } catch (e) {
      throw CustomExceptions(message: 'An error occurred, please try later.');
    }
  }
}
