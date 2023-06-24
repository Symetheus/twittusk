import 'package:twittusk/data/data_source/tusk_data_source.dart';
import 'package:twittusk/domain/repository/tusk_repository.dart';
import 'package:firebase_auth/firebase_auth.dart' as auth;
import '../../../domain/models/tusk.dart';

class FirebaseTuskRepository implements TuskRepository {
  final TuskDataSource _dataSource;

  FirebaseTuskRepository(this._dataSource);

  @override
  Future<auth.UserCredential> signIn(String email, String password) async {
    return await _dataSource.signIn(email, password);
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
}