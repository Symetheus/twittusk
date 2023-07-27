import 'dart:async';

import 'package:twittusk/data/data_source/tusk_data_source.dart';
import 'package:twittusk/data/dto/tusk_add_dto.dart';
import 'package:twittusk/domain/models/like.dart';
import 'package:twittusk/domain/models/user.dart';
import 'package:twittusk/domain/repository/tusk_repository.dart';
import '../../../domain/models/tusk.dart';
import '../../../domain/models/user_session.dart';
import '../../dto/like_dto.dart';
import '../../dto/user_dto.dart';

class FirebaseTuskRepository implements TuskRepository {
  final _tuskStreamController = StreamController<List<Tusk>>.broadcast();
  final TuskDataSource _dataSource;

  FirebaseTuskRepository(this._dataSource);

  @override
  Future<UserSession> signIn(String email, String password) async {
    final user = await _dataSource.signIn(email, password);
    return user.toUserSession();
  }

  @override
  Future<UserSession> signUp(String username, String email, String password) async {
    final user = await _dataSource.signUp(username, email, password);
    return user.toUserSession();
  }

  @override
  Future<void> resetPassword(String email) async {
    await _dataSource.resetPassword(email);
  }

  @override
  Stream<List<Tusk>> getTusks() {
    _dataSource.getTusks().listen((data) async {
      final user = await _dataSource.getCurrentUser();
      _tuskStreamController.add(data.map((e) => e.toTusk(user?.uid ?? "")).toList());
    });

    return _tuskStreamController.stream;
  }

  @override
  Stream<List<Tusk>> getTusksByUser(User user) {
    _dataSource.getTusksByUser(UserDto.fromUser(user)).listen((data) {
      _tuskStreamController.add(data.map((e) => e.toTusk(user.uid)).toList());
    });
    return _tuskStreamController.stream;
  }

  @override
  Future<void> addUser(User user) async {
    await _dataSource.addUser(UserDto.fromUser(user));
  }

  @override
  Future<UserSession> signInWithGoogle() async {
    final user = await _dataSource.signInWithGoogle();
    return user.toUserSession();
  }

  @override
  Future<UserSession> signInWithTwitter() async {
    final user = await _dataSource.signInWithTwitter();
    return user.toUserSession();
  }

  @override
  Future<User?> getUserById(String uid) async {
    final user = await _dataSource.getUserById(uid);
    return user?.toUser();
  }

  @override
  Future<void> addLike(String tuskId, bool isLiked) async {
    final user = await _dataSource.getCurrentUser();
    final like = LikeDto(uid: "", isLiked: isLiked);
    like.user = user!;
    await _dataSource.addLikeTusk(like, tuskId);
  }

  @override
  Future<List<Like>> getMyLikesByTusk(String tuskId) async {
    final user = await _dataSource.getCurrentUser();
    final likes = await _dataSource.getLikesByTusk(tuskId);
    return likes.map((e) => e.toLike()).toList().where((e) => e.user.uid == user?.uid).toList();
  }

  @override
  Future<void> removeLike(String likeId, String tuskId) async {
    await _dataSource.removeLikeTusk(likeId, tuskId);
  }

  @override
  Future<Uri> generateTuskDynamicLink(String tuskId) {
    return _dataSource.generateTuskDynamicLink(tuskId);
  }

  @override
  Future<User?> getCurrentUser() async {
    final user = await _dataSource.getCurrentUser();
    return user?.toUser();
  }

  @override
  Future<void> addCommentToTusk(String tuskId, String comment, User user) {
    return _dataSource.addCommentToTusk(tuskId, comment, UserDto.fromUser(user));
  }

  @override
  Stream<List<Tusk>> getCommentsForTusk(String tuskId) {
    _dataSource.getCommentsForTusk(tuskId).listen((data) async {
      final user = await _dataSource.getCurrentUser();
      _tuskStreamController.add(data.map((e) => e.toTusk(user?.uid ?? "")).toList());
    });
    return _tuskStreamController.stream;
  }

  @override
  Future<Tusk> getTuskById(String tuskId) async {
    var tuskDto = await _dataSource.getById(tuskId);
    final user = await _dataSource.getCurrentUser();
    return tuskDto.toTusk(user?.uid ?? "");
  }


  @override
  Future<void> logout() async {
    await _dataSource.logout();
  }

  @override
  Future<String> uploadImage(String path) async {
    return await _dataSource.uploadImage(path);
  }

  @override
  Future<void> addTusk(String description, DateTime publishAt, String? image, User user) async {
    await _dataSource.addTusk(description, publishAt, image, UserDto.fromUser(user));
  }

}
