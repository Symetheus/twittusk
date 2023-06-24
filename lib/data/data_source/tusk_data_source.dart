import 'package:firebase_auth/firebase_auth.dart';

import '../dto/user_dto.dart';

abstract class TuskDataSource {
  Future<UserDto> signIn(String email, String password);
}