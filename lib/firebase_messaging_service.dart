import 'package:firebase_messaging/firebase_messaging.dart';

class FirebaseMessagingService {
  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;

  Future<void> requestPermission() async {
    await _firebaseMessaging.requestPermission(
      sound: true,
      badge: true, //notification er pashe akta badge icon show korbe ..
      alert: true,
      announcement: false,
      criticalAlert: false, //eta diley porey app e explain kortey hoitey pare.
      provisional: false,
    );
  }

  Future<void> initialize() async {
    await requestPermission(); //https://firebase.google.com/docs/cloud-messaging/flutter/receive-messages
    //App 3 ta step e thakey ..
    //1.Normal/Alive/ON-Pause ... app running raikka amra home button e click koira app close kori
    FirebaseMessaging.onMessage.listen((message) {
      print(message.notification?.title);
      print(message.notification?.body);
      print(message.data);
    });

    //2.Open /Resume -- app open acey / app calitechi
    FirebaseMessaging.onMessageOpenedApp.listen((message) {
      print(message.notification?.title);
      print(message.notification?.body);
      print(message.data);
    });

    //3.Dead / ON-Terminated
    FirebaseMessaging.onBackgroundMessage(handleBackgroundMessage);
  }

  Future<void> getFCMToken() async {
    final token = await _firebaseMessaging.getToken();
    print(token);
  } //ei token ta 10-15 day por refresh hoibo ..tai onRefresh method create korbo


  Future<void> onRefresh(Function(String) onTokenRefresh) async {
    _firebaseMessaging.onTokenRefresh.listen((token) {
      onTokenRefresh(token);
    });
  }

  //kono ekta topic e subscribe na kora porjonto ei message ta asbey
  Future<void> subscribeToTopic(String topic) async {
    await _firebaseMessaging.subscribeToTopic(topic);
  }

  Future<void> unsubscribeFromTopic(String topic) async {
    await _firebaseMessaging.unsubscribeFromTopic(topic);
  }


}

//App Terminated thakley ektu high level code liktey hoibo ..
Future<void> handleBackgroundMessage(RemoteMessage message) async {}
