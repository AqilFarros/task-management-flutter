part of 'service.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  get currentUser => _auth.currentUser;

  Future<User?> signIn(String email, String password) async {
    try {
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      if (kDebugMode) {
        print("User: ${userCredential.user}");
      }

      return userCredential.user!;
    } on FirebaseAuthException catch (e) {
      if (kDebugMode) {
        print("Error: $e");
      }
      rethrow;
    }
  }

  Future<User?> signUp(
      {required String firstName,
      required String lastName,
      required String email,
      required String password}) async {
    try {
      UserCredential userCredential = await _auth
          .createUserWithEmailAndPassword(email: email, password: password);

      await firestore.collection("users").doc(userCredential.user!.uid).set({
        "first_name": firstName,
        "last_name": lastName,
        "email": email,
      });

      if (kDebugMode) {
        print("User: ${userCredential.user}");
      }

      return userCredential.user!;
    } catch (e) {
      if (kDebugMode) {
        print("Error: $e");
      }

      rethrow;
    }
  }
}
