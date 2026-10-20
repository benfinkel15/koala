import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:hive_flutter/hive_flutter.dart';

class AuthService {
  static bool firebaseReady = false;

  static FirebaseAuth get _auth => FirebaseAuth.instance;
  static FirebaseFirestore get _db => FirebaseFirestore.instance;

  static User? get currentUser {
    if (!firebaseReady) return null;
    try {
      return _auth.currentUser;
    } catch (_) {
      return null;
    }
  }

  static Future<String?> signIn(String email, String password) async {
    if (!firebaseReady) return 'Firebase is not configured yet';
    try {
      await _auth.signInWithEmailAndPassword(email: email, password: password);
      await syncProgressToFirestore();
      return null;
    } on FirebaseAuthException catch (e) {
      return e.message ?? 'Sign in failed';
    } catch (e) {
      return e.toString();
    }
  }

  static Future<String?> register(String email, String password) async {
    if (!firebaseReady) return 'Firebase is not configured yet';
    try {
      await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      await syncProgressToFirestore();
      return null;
    } on FirebaseAuthException catch (e) {
      return e.message ?? 'Registration failed';
    } catch (e) {
      return e.toString();
    }
  }

  static Future<void> signOut() async {
    if (!firebaseReady) return;
    try {
      await _auth.signOut();
    } catch (_) {}
  }

  static Future<void> syncProgressToFirestore() async {
    final user = currentUser;
    if (user == null) return;

    try {
      final progressBox = await Hive.openBox('progress');
      final streakBox = await Hive.openBox('streak');
      final srsBox = await Hive.openBox('srs');

      Map<String, dynamic> boxToMap(Box<dynamic> box) {
        final result = <String, dynamic>{};
        for (final key in box.keys) {
          final value = box.get(key);
          if (value is Map) {
            result[key.toString()] = Map<String, dynamic>.from(value);
          } else {
            result[key.toString()] = value;
          }
        }
        return result;
      }

      await _db.collection('users').doc(user.uid).set({
        'email': user.email,
        'progress': boxToMap(progressBox),
        'streak': boxToMap(streakBox),
        'srs': boxToMap(srsBox),
        'syncedAt': FieldValue.serverTimestamp(),
      }, SetOptions(merge: true));
    } catch (_) {}
  }
}
