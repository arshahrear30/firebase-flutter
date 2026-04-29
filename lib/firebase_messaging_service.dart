import 'package:firebase_messaging/firebase_messaging.dart';

class FirebaseMessagingService {
  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;

  Future<void> requestPermission() async {
    await _firebaseMessaging.requestPermission(
      sound: true,
      badge: true, //notification এর পাশে একটা badge icon show করবে .
      alert: true,
      announcement: false,
      criticalAlert: false, //এটা দিলে পরে app-এ explain করতে হইতে পারে।
      provisional: false,
    );
  }

  Future<void> initialize() async {
    await requestPermission(); //https://firebase.google.com/docs/cloud-messaging/flutter/receive-messages
    //App 3 টা step-এ থাকে ..
    //১. Normal/Alive/ON-Pause ... app running রাইখা আমরা home button-এ click কইরা app close করি
    FirebaseMessaging.onMessage.listen((message) {
      print(message.notification?.title);
      print(message.notification?.body);
      print(message.data);
    });

    //২. Open / Resume -- app open আছে / app চালাইতেছি
    FirebaseMessaging.onMessageOpenedApp.listen((message) {
      print(message.notification?.title);
      print(message.notification?.body);
      print(message.data);
    });

    //৩. Dead / ON-Terminated
    FirebaseMessaging.onBackgroundMessage(handleBackgroundMessage);
  }

  Future<void> getFCMToken() async {
    final token = await _firebaseMessaging.getToken();
    print(token);
  } //এই token টা ১০-১৫ day পর refresh হইবো .. তাই onRefresh method create করবো


  Future<void> onRefresh(Function(String) onTokenRefresh) async {
    _firebaseMessaging.onTokenRefresh.listen((token) {
      onTokenRefresh(token);
    });
  }

  //কোনো একটা topic-এ subscribe না করা পর্যন্ত এই message টা আসবে
  Future<void> subscribeToTopic(String topic) async {
    await _firebaseMessaging.subscribeToTopic(topic);
  }

  Future<void> unsubscribeFromTopic(String topic) async {
    await _firebaseMessaging.unsubscribeFromTopic(topic);
  }


}

//App Terminated থাকলে একটু high level code লিখতে হইবো ..
Future<void> handleBackgroundMessage(RemoteMessage message) async {}
