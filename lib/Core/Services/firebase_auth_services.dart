import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:managemint/Core/errors/exceptions.dart';

class FirebaseAuthServices {
  Future<User> createUserWithEmailAndPassword({
    required String userName,
    required String email,
    required String password,
    required String role,
    // either 'Project Manager' or 'Developer'
  }) async {
    try {
      final credential =
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      final user = credential.user!;

      // Save additional user info (like role) to Firestore
      await FirebaseFirestore.instance.collection('users').doc(user.uid).set({
        'email': email,
        'role': role,
        'userName' : userName,
        'createdAt': FieldValue.serverTimestamp(),
      });

      return user;
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
  Future<User> signInWithEmailAndPassword(
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

  Future<void> signOutUser() async {
    try {
      await FirebaseAuth.instance.signOut();
    } catch (e) {
      throw Exception('Failed to sign out: $e');
    }
  }


  Future<Map<String, String>> getUserDate(String uid) async {
    try {
      DocumentSnapshot doc = await FirebaseFirestore.instance
          .collection('users')
          .doc(uid)
          .get();

      if (doc.exists) {
        final data = doc.data() as Map<String, dynamic>;
        return {
          'userName': data['userName'] ?? 'No name',
          'role': data['role'] ?? 'Unknown',
        };
      } else {
        throw Exception('User document not found');
      }
    } catch (e) {
      throw Exception('Failed to get user data: $e');
    }
  }


  User? getCurrentUser() {
    return FirebaseAuth.instance.currentUser;
  }


  Future<String?> getCurrentUserRole() async {
    final user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      final doc = await FirebaseFirestore.instance.collection('users').doc(user.uid).get();
      if (doc.exists) {
        return doc.data()?['role'];
      }
    }
    return null;
  }

  bool isUserLoggedIn() {
    return FirebaseAuth.instance.currentUser != null;
  }

}
