import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_flutter/firebase_messaging_service.dart';
import 'package:flutter/material.dart';

Future<void> main() async {

  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await FirebaseMessagingService().initialize();
  await FirebaseMessagingService().getFCMToken();
  await FirebaseMessagingService().subscribeToTopic("the-new_boston-myself");
  await FirebaseMessagingService().onRefresh((token) {
    //TODO -- send to API
  });


  //runApp(const FirebaseMessagingService());

}