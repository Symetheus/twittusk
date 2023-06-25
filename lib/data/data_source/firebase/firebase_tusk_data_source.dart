import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:twitter_login/twitter_login.dart';
import 'package:twittusk/data/data_source/tusk_data_source.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:twittusk/data/dto/user_dto.dart';
import '../../dto/user_session_dto.dart';

class FirebaseTuskDataSource implements TuskDataSource {
  final _auth = FirebaseAuth.instance;
  final _firestore = FirebaseFirestore.instance;

  @override
  Future<UserSessionDto> signIn(String email, String password) async {
    final userCredential = await _auth.signInWithEmailAndPassword(
      email: email,
      password: password,
    );
    return UserSessionDto.fromUserCredential(userCredential);
  }

  @override
  Future<UserSessionDto> signInWithGoogle() async {
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
    final GoogleSignInAuthentication? googleAuth = await googleUser?.authentication;
    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth?.accessToken,
      idToken: googleAuth?.idToken,
    );
    final credentials =  await _auth.signInWithCredential(credential);
    return UserSessionDto.fromUserCredential(credentials);
  }

  @override
  Future<UserSessionDto> signInWithTwitter() async {
    final twitterLogin = TwitterLogin(
      apiKey: dotenv.env['TWITTER_API_KEY'] ?? "",
      apiSecretKey: dotenv.env['TWITTER_API_KEY_SECRET'] ?? "",
      redirectURI: "twittusk://",
    );
    final authResult = await twitterLogin.login();
    final AuthCredential twitterAuthCredential =
    TwitterAuthProvider.credential(
      accessToken: authResult.authToken!,
      secret: authResult.authTokenSecret!,
    );
    final userCredential = await _auth.signInWithCredential(twitterAuthCredential);
    return UserSessionDto.fromUserCredential(userCredential);
  }

  @override
  Future<void> addUser(UserDto user) async {
    final doc = _firestore.collection("users").doc(user.uid);
    await doc.set(user.toJson());
  }

  @override
  Future<UserSessionDto> signUp(String username, String email, String password) async {
    final userCredential = await _auth.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );
    final user = UserDto(
        uid: userCredential.user!.uid,
        username: username,
        arobase: userCredential.user!.email!.split('@')[0],
        email: email
    );
    _firestore.collection("users").add(user.toJson());
    return UserSessionDto.fromUserCredential(userCredential);
  }

  @override
  Future<UserDto?> getUserById(String uid) async {
    final user = await _firestore.collection("users").doc(uid).get();
    if(!user.exists) {
      return null;
    }
    return UserDto.fromJson(user.data()!);
  }

  @override
  Future<void> resetPassword(String email) async {
    await _auth.sendPasswordResetEmail(email: email);
  }
}