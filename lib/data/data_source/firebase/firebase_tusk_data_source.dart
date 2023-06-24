import 'package:firebase_auth/firebase_auth.dart';
import 'package:twittusk/data/data_source/tusk_data_source.dart';

class FirebaseTuskDataSource implements TuskDataSource {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  @override
  Future<UserCredential> signIn(String email, String password) async {
    UserCredential userCredential = await _auth.signInWithEmailAndPassword(
      email: email,
      password: password,
    );
    return userCredential;
  }
}