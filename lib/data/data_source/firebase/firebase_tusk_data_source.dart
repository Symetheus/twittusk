import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:twitter_login/twitter_login.dart';
import 'package:twittusk/data/data_source/tusk_data_source.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:twittusk/data/dto/like_dto.dart';
import 'package:twittusk/data/dto/tusk_dto.dart';
import 'package:twittusk/data/dto/user_dto.dart';
import '../../dto/user_session_dto.dart';

class FirebaseTuskDataSource implements TuskDataSource {
  final _tuskStreamController = StreamController<List<TuskDto>>();
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
    return UserDto.fromJson(user.data()!, user.id);
  }

  @override
  Future<void> resetPassword(String email) async {
    await _auth.sendPasswordResetEmail(email: email);
  }

  @override
  Stream<List<TuskDto>> getTusks() {
    FirebaseFirestore.instance
        .collection('tusks')
        .orderBy("publishedAt", descending: true)
        .snapshots()
        .listen((snapshot) async {
      final List<TuskDto> tuskList = [];
      for (var doc in snapshot.docs) {
        final tusk = TuskDto.fromJson(doc.data(), doc.id);
        tusk.user = await _getUserFromDocumentRef(doc.data()["user"]);
        doc.reference.collection("comments").snapshots().listen((event) async {
          tusk.comments.clear();
          for(var i = 0; i < event.docs.length; i++) {
            final comment = event.docs[i];
            final commentDto = TuskDto.fromJson(comment.data(), comment.id);
            commentDto.user = await _getUserFromDocumentRef(comment.data()["user"]);
            tusk.comments.add(commentDto);
            _tuskStreamController.add(tuskList);
          }
        });
        doc.reference.collection("likes").snapshots().listen((event) async {
          tusk.likes.clear();
          for(var i = 0; i < event.docs.length; i++) {
            final like = event.docs[i];
            final likeDto = LikeDto.fromJson(like.data(), like.id);
            likeDto.user = await _getUserFromDocumentRef(like.data()["user"]);
            tusk.likes.add(likeDto);
            _tuskStreamController.add(tuskList);
          }
        });
        tuskList.add(tusk);
      }
      _tuskStreamController.add(tuskList);
    });

    return _tuskStreamController.stream;
  }

  Future<UserDto> _getUserFromDocumentRef(DocumentReference doc) async {
    final user = await doc.get();
    return UserDto.fromJson(user.data() as Map<String, dynamic>, user.id);
  }

  @override
  Future<UserDto?> getCurrentUser() async {
    final user = _auth.currentUser;
    if(user == null) {
      return null;
    }
    final userDoc = await _firestore.collection("users").doc(user.uid).get();
    if(!userDoc.exists) {
      return null;
    }
    return UserDto.fromJson(userDoc.data()!, userDoc.id);
  }

  @override
  Future<List<LikeDto>> getLikesByTusk(String tuskId) async {
    final tusk = FirebaseFirestore.instance.collection('tusks').doc(tuskId);
    final likes = await tusk.collection("likes").get();
    final List<LikeDto> likeList = [];
    for (var doc in likes.docs) {
      final like = LikeDto.fromJson(doc.data(), doc.id);
      like.user = await _getUserFromDocumentRef(doc.data()["user"]);
      likeList.add(like);
    }
    return likeList;
  }

  @override
  Future<void> addLikeTusk(LikeDto like, String tuskId) async {
    final tusk = FirebaseFirestore.instance.collection('tusks').doc(tuskId);
    final json = like.toJson();
    json["user"] = _firestore.collection("users").doc(like.user.uid);
    tusk.collection("likes").add(json);
  }

  @override
  Future<void> removeLikeTusk(String likeId, String tuskId) {
    final tusk = FirebaseFirestore.instance.collection('tusks').doc(tuskId);
    return tusk.collection("likes").doc(likeId).delete();
  }

}