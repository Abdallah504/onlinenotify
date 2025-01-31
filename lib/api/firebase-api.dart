import 'dart:convert';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:onlinenotify/main.dart';
import 'package:onlinenotify/screens/notify-screen.dart';

class FirebaseApi{
  final _firebaseMessaging = FirebaseMessaging.instance;

  Future<void>initNotify()async{
    await _firebaseMessaging.requestPermission();
    // final fcmToken = await _firebaseMessaging.getToken();
    // print('Token : $fcmToken');
    initPushNotify();
  }
}
Future initPushNotify()async{
  final localNotifi = FlutterLocalNotificationsPlugin();
  await FirebaseMessaging.instance
  .setForegroundNotificationPresentationOptions(
    alert: true,
    badge: true,
    sound: true
  );

  final androidChannel = AndroidNotificationChannel(
      'high_importance_channel',
      'High_Importance_Notifications',
    description: 'This Channel is important',
    importance: Importance.defaultImportance
  );

  FirebaseMessaging.instance.getInitialMessage().then(handleMessage);
  FirebaseMessaging.onMessageOpenedApp.listen(handleMessage);
  FirebaseMessaging.onBackgroundMessage(handleMessageBackground);
  FirebaseMessaging.onMessage.listen((message){
    final notification = message.notification;
    if(notification ==null)return;
    localNotifi.show(
        notification.hashCode,
        notification.title,
        notification.body,
    NotificationDetails(
      android: AndroidNotificationDetails(androidChannel.id, androidChannel.name,
      channelDescription: androidChannel.description,
        icon: '@drawable/ic_launcher',
        channelShowBadge: true
      )
    )  ,
    payload: jsonEncode(message.toMap())
    );
    initLocalNotify(message, androidChannel);
  });
}

void handleMessage(RemoteMessage? message){
  if(message==null)return;

  navigatorKey.currentState?.pushNamed(
    NotifyScreen.route,
    arguments: message
  );
}

Future<void> handleMessageBackground(RemoteMessage? message)async{
  print('Title : ${message!.notification!.title}');
  print('Body : ${message!.notification!.body}');

}
Future initLocalNotify (messaging, androidChannel)async{
  final localNotifi = FlutterLocalNotificationsPlugin();
  final android = AndroidInitializationSettings('@drawable/ic_launcher');
  final settings = InitializationSettings(android: android);
  await localNotifi.initialize(settings);
  final message = RemoteMessage.fromMap(jsonDecode(messaging));
  handleMessage(message);
  final platform = localNotifi.resolvePlatformSpecificImplementation<AndroidFlutterLocalNotificationsPlugin>();
  await platform?.createNotificationChannel(androidChannel);
}