import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart' as firebase_auth;

import 'app_user.dart';

abstract class AuthRepository {
  Future<AppUser> signIn({required String email, required String password});
  Future<AppUser> signUp({required String name, required String email, required String password});
  Future<void> signOut();
}

class FirebaseAuthRepository implements AuthRepository {
  FirebaseAuthRepository({
    firebase_auth.FirebaseAuth? auth,
    FirebaseFirestore? firestore,
  })  : _auth = auth ?? firebase_auth.FirebaseAuth.instance,
        _firestore = firestore ?? FirebaseFirestore.instance;

  final firebase_auth.FirebaseAuth _auth;
  final FirebaseFirestore _firestore;

  @override
  Future<AppUser> signIn({required String email, required String password}) async {
    try {
      final credential = await _auth.signInWithEmailAndPassword(
        email: email.trim(),
        password: password,
      );
      return await _userFromFirebase(credential.user);
    } on firebase_auth.FirebaseAuthException catch (exception) {
      throw AuthException(_messageFromFirebase(exception));
    }
  }

  @override
  Future<AppUser> signUp({
    required String name,
    required String email,
    required String password,
  }) async {
    try {
      final trimmedName = name.trim().isEmpty ? 'Cliente NICE' : name.trim();
      final credential = await _auth.createUserWithEmailAndPassword(
        email: email.trim(),
        password: password,
      );

      await credential.user?.updateDisplayName(trimmedName);
      await credential.user?.reload();

      final user = _auth.currentUser ?? credential.user;
      if (user == null) {
        throw const AuthException('Nao foi possivel criar o usuario.');
      }

      await _saveUserProfile(user: user, name: trimmedName);

      return AppUser(
        id: user.uid,
        email: user.email ?? email.trim(),
        name: trimmedName,
      );
    } on firebase_auth.FirebaseAuthException catch (exception) {
      throw AuthException(_messageFromFirebase(exception));
    }
  }

  @override
  Future<void> signOut() => _auth.signOut();

  Future<AppUser> _userFromFirebase(firebase_auth.User? user) async {
    if (user == null) {
      throw const AuthException('Usuario nao encontrado.');
    }

    final profile = await _firestore.collection('users').doc(user.uid).get();
    final data = profile.data();

    return AppUser(
      id: user.uid,
      email: user.email ?? '',
      name: data?['name'] as String? ?? user.displayName ?? 'Cliente NICE',
    );
  }

  Future<void> _saveUserProfile({
    required firebase_auth.User user,
    required String name,
  }) {
    return _firestore.collection('users').doc(user.uid).set(
      {
        'name': name,
        'email': user.email,
        'createdAt': FieldValue.serverTimestamp(),
        'updatedAt': FieldValue.serverTimestamp(),
      },
      SetOptions(merge: true),
    );
  }

  String _messageFromFirebase(firebase_auth.FirebaseAuthException exception) {
    switch (exception.code) {
      case 'email-already-in-use':
        return 'Este email ja esta cadastrado.';
      case 'invalid-email':
        return 'Informe um email valido.';
      case 'invalid-credential':
      case 'user-not-found':
      case 'wrong-password':
        return 'Email ou senha invalidos.';
      case 'weak-password':
        return 'A senha precisa ser mais forte.';
      case 'network-request-failed':
        return 'Sem conexao com o Firebase.';
      default:
        return exception.message ?? 'Nao foi possivel concluir a autenticacao.';
    }
  }
}

class AuthException implements Exception {
  const AuthException(this.message);

  final String message;
}
