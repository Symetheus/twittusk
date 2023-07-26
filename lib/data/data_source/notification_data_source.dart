abstract class NotificationDataSource {
  Future<void> sendMessageToUser(String title, String body, String userUid);

  Future<void> sendMessageFromTuskId(String tuskId, String title, String body);

  Future<void> subscribeToTopic(String topic);

  Future<void> unsubscribeFromTopic(String topic);
}