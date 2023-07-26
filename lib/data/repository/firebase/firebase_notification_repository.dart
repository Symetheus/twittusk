import '../../../domain/repository/notification_repository.dart';
import '../../data_source/notification_data_source.dart';

class FirebaseNotificationRepository implements NotificationRepository {
  final NotificationDataSource _dataSource;

  FirebaseNotificationRepository(this._dataSource);

  @override
  Future<void> sendMessage(String title, String body, String userUid) async {
    await _dataSource.sendMessageToUser(title, body, userUid);
  }

  @override
  Future<void> sendMessageFromTuskId(String tuskId, String title, String body) async {
    await _dataSource.sendMessageFromTuskId(tuskId, title, body);
  }

  @override
  Future<void> subscribeToTopic(String topic) async {
    await _dataSource.subscribeToTopic(topic);
  }
}