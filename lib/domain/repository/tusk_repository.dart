import 'package:twittusk/domain/models/tusk.dart';

abstract class TuskRepository {
  Stream<List<Tusk>> getTusks();

  Stream<List<Tusk>> getTusksByUser();
}