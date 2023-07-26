abstract class NotificationRepository {
  Future<void> sendMessage(String title, String body, String userUid);

  Future<void> sendMessageFromTuskId(String tuskId, String title, String body);

  Future<void> subscribeToTopic(String topic);
}