import 'package:cloud_functions/cloud_functions.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import '../notification_data_source.dart';

class FirebaseNotificationDataSource implements NotificationDataSource {
  final FirebaseFunctions _functions = FirebaseFunctions.instance;
  final FirebaseMessaging _messaging = FirebaseMessaging.instance;

  @override
  Future<void> sendMessageToUser(String title, String body, String userUid) async {
    _functions.httpsCallable('sendPushNotifiction').call({
      'title': title,
      'body': body,
      'recipientUid': userUid,
    });
  }

  @override
  Future<void> sendMessageFromTuskId(String tuskId, String title, String body) async {
    _functions.httpsCallable('sendPushNotifictionFromTuskId').call({
      'title': title,
      'body': body,
      'tuskId': tuskId,
    });
  }

  @override
  Future<void> subscribeToTopic(String topic) async {
    _messaging.subscribeToTopic(topic);
  }
}
