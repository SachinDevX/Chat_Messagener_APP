import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';

class AuthService extends ChangeNotifier {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // Collection reference
  CollectionReference get _users => _firestore.collection('users');

  // Get current user
  User? get currentUser => _auth.currentUser;

  // Sign Up
  Future<void> signUpWithEmailAndPassword(String email, String password) async {
    try {
      // Create user with email and password
      final userCredential = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      // Create user document with additional error handling
      if (userCredential.user != null) {
        await _users.doc(userCredential.user!.uid).set({
          'uid': userCredential.user!.uid,
          'email': email,
          'createdAt': FieldValue.serverTimestamp(), // Use server timestamp
          'lastLogin': FieldValue.serverTimestamp(),
          'isActive': true,
        }, SetOptions(merge: true)); // Use merge option to prevent overwriting

        print('User document created successfully for: $email');
        notifyListeners();
      } else {
        throw FirebaseAuthException(
          code: 'null-user',
          message: 'Failed to create user document - user is null',
        );
      }
    } on FirebaseAuthException catch (e) {
      print('Firebase Auth Error: ${e.code} - ${e.message}');
      throw e;
    } catch (e) {
      print('Error during sign up: $e');
      throw e;
    }
  }

  // Sign In
  Future<void> signInWithEmailAndPassword(String email, String password) async {
    try {
      final userCredential = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      if (userCredential.user != null) {
        // Get user document with error handling
        final userDocRef = _users.doc(userCredential.user!.uid);
        final userDoc = await userDocRef.get();

        if (!userDoc.exists) {
          // Create missing user document
          await userDocRef.set({
            'uid': userCredential.user!.uid,
            'email': email,
            'createdAt': FieldValue.serverTimestamp(),
            'lastLogin': FieldValue.serverTimestamp(),
            'isActive': true,
          }, SetOptions(merge: true));
          print('Created missing user document for existing user');
        } else {
          // Update last login
          await userDocRef.update({
            'lastLogin': FieldValue.serverTimestamp(),
            'isActive': true,
          });
        }
        notifyListeners();
      }
    } on FirebaseAuthException catch (e) {
      print('Firebase Auth Error: ${e.code} - ${e.message}');
      throw e;
    } catch (e) {
      print('Error during sign in: $e');
      throw e;
    }
  }

  // Sign Out
  Future<void> signOut() async {
    try {
      final uid = currentUser?.uid;
      if (uid != null) {
        // Update user status on sign out
        await _users.doc(uid).update({
          'isActive': false,
          'lastLogout': FieldValue.serverTimestamp(),
        });
      }
      await _auth.signOut();
      notifyListeners();
    } catch (e) {
      print('Error during sign out: $e');
      throw e;
    }
  }

  // Stream of auth state changes
  Stream<User?> authStateChanges() => _auth.authStateChanges();

  // Get user data
  Future<Map<String, dynamic>?> getUserData(String uid) async {
    try {
      final doc = await _users.doc(uid).get();
      return doc.exists ? (doc.data() as Map<String, dynamic>) : null;
    } catch (e) {
      print('Error getting user data: $e');
      return null;
    }
  }
}
