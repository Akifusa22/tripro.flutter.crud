import 'package:firebase_auth/firebase_auth.dart';

class Auth {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  User? get currentUser => _firebaseAuth.currentUser;

  Stream<User?> get authStateChanges => _firebaseAuth.authStateChanges();

  Future<void> signInWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    await _firebaseAuth.signInWithEmailAndPassword(
      email: email,
      password: password,
    );
  }

  Future<void> sendEmailVerification() async {
    User? user = _firebaseAuth.currentUser;

    if (user != null) {
      await user.sendEmailVerification();
    }
  }

  Future<void> createUserWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    await _firebaseAuth.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );
  }

  Future<void> signOut() async {
    await _firebaseAuth.signOut();
  }

  Future<bool> isEmailAlreadyInUse(String email) async {
    try {
      final result = await _firebaseAuth.fetchSignInMethodsForEmail(email);
      return result.isNotEmpty; // Trả về true nếu email đã tồn tại
    } catch (e) {
      return false; // Xử lý lỗi nếu có
    }
  }
}
