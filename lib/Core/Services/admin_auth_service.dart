import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../errors/exceptions.dart';

class AdminService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final String usersCollection = 'users';

  Future<void> ensureAdminAccountExists() async {
    try {
      // Check if admin user already exists in Firestore
      final querySnapshot = await _firestore
          .collection(usersCollection)
          .where('role', isEqualTo: 'Admin')
          .limit(1)
          .get();

      if (querySnapshot.docs.isEmpty) {
        const String email = 'admin@managemint.com';
        const String password = 'Admin1234@@';
        const String userName = 'Admin';
        const String role = 'Admin';

        // Use the provided createUserWithEmailAndPassword function
        await createUserWithEmailAndPassword(
          userName: userName,
          email: email,
          password: password,
          role: role,
        );

        print('✅ Admin account created');
      } else {
        print('ℹ️ Admin account already exists');
      }
    } catch (e) {
      print('❌ Error checking/creating admin: $e');
    }
  }

  // This is the provided function to create a user with email and password
  Future<User> createUserWithEmailAndPassword({
    required String userName,
    required String email,
    required String password,
    required String role,
  }) async {
    try {
      final credential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      final user = credential.user!;

      // Save additional user info (like role) to Firestore
      await FirebaseFirestore.instance.collection('users').doc(user.uid).set({
        'email': email,
        'role': role,
        'userName': userName,
        'createdAt': FieldValue.serverTimestamp(),
      });

      return user;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        throw CustomExceptions(message: 'The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        throw CustomExceptions(message: 'The account already exists for that email.');
      } else {
        throw CustomExceptions(message: 'An error occurred, please try later.');
      }
    } catch (e) {
      throw CustomExceptions(message: 'An error occurred, please try later.');
    }
  }
}
