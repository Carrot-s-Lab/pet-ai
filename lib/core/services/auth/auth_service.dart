import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';

class AuthService {
  AuthService({FirebaseAuth? auth}) : _auth = auth ?? FirebaseAuth.instance;

  final FirebaseAuth _auth;
  final Completer<void> _readyCompleter = Completer<void>();

  static const String _tag = '[AuthService]';

  User? get currentUser => _auth.currentUser;

  /// Resolves when the user is signed in (anonymously by default).
  /// All Firebase-backed services must `await` this before making requests.
  Future<void> get ready => _readyCompleter.future;

  Future<User> ensureSignedIn() async {
    try {
      final existing = _auth.currentUser;
      if (existing != null) {
        print('$_tag ensureSignedIn: already signed in. uid=${existing.uid} '
            'anonymous=${existing.isAnonymous}');
        if (!_readyCompleter.isCompleted) _readyCompleter.complete();
        return existing;
      }
      print('$_tag ensureSignedIn: signing in anonymously...');
      final credential = await _auth.signInAnonymously();
      final user = credential.user!;
      print('$_tag ensureSignedIn: success. uid=${user.uid}');
      if (!_readyCompleter.isCompleted) _readyCompleter.complete();
      return user;
    } on FirebaseAuthException catch (e, st) {
      print('$_tag ensureSignedIn: FAILED. code=${e.code} message=${e.message} '
          'plugin=${e.plugin}\n$st');
      if (e.code == 'internal-error' ||
          e.code == 'operation-not-allowed' ||
          e.code == 'admin-restricted-operation') {
        print('$_tag HINT: Anonymous sign-in must be enabled in Firebase '
            'Console → Authentication → Sign-in method → Anonymous → Enable.');
      }
      if (!_readyCompleter.isCompleted) {
        _readyCompleter.completeError(e, st);
      }
      rethrow;
    } catch (e, st) {
      print('$_tag ensureSignedIn: FAILED. error=$e\n$st');
      if (!_readyCompleter.isCompleted) {
        _readyCompleter.completeError(e, st);
      }
      rethrow;
    }
  }
}
