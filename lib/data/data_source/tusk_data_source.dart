import '../dto/user_dto.dart';

abstract class TuskDataSource {
  Future<UserDto> signIn(String email, String password);

  Future<void> resetPassword(String email);
}