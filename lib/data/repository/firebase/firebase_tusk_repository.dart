import 'package:twittusk/data/data_source/tusk_data_source.dart';
import 'package:twittusk/domain/models/user.dart';
import 'package:twittusk/domain/repository/tusk_repository.dart';
import '../../../domain/models/tusk.dart';
import '../../../domain/models/user_session.dart';
import '../../dto/user_dto.dart';

class FirebaseTuskRepository implements TuskRepository {
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
    // TODO: implement getTusks
    throw UnimplementedError();
  }

  @override
  Stream<List<Tusk>> getTusksByUser() {
    // TODO: implement getTusksByUser
    throw UnimplementedError();
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




}