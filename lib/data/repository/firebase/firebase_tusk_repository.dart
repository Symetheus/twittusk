import 'package:twittusk/data/data_source/tusk_data_source.dart';
import 'package:twittusk/domain/repository/tusk_repository.dart';
import '../../../domain/models/tusk.dart';
import '../../../domain/models/user.dart';

class FirebaseTuskRepository implements TuskRepository {
  final TuskDataSource _dataSource;

  FirebaseTuskRepository(this._dataSource);

  @override
  Future<User> signIn(String email, String password) async {
    final user = await _dataSource.signIn(email, password);
    return user.toUser();
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


}