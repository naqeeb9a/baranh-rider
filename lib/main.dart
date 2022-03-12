import 'dart:convert';

import 'package:animations/animations.dart';
import 'package:baranh_rider/services/notification_service.dart';
import 'package:baranh_rider/utils/config.dart';
import 'package:baranh_rider/utils/constants.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'Screens/tab_bar.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  await LocalNotificationsService.instance.initialize();
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
  notificationFunction();

  runApp(const MyApp());
}

Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  SharedPreferences userData = await SharedPreferences.getInstance();
  var riderData = jsonDecode(userData.getString("user").toString());

  await Firebase.initializeApp();

  if (message.data['id'].toString() == riderData["data"]["id"].toString()) {
    LocalNotificationsService.instance.showChatNotification(
      title: '${message.notification!.title}',
      body: '${message.notification!.body}',
    );
  }
}

notificationFunction() async {
  SharedPreferences userData = await SharedPreferences.getInstance();
  var riderData = jsonDecode(userData.getString("user").toString());

  FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage event) async {
    if (event.data['id'].toString() == riderData["data"]["id"].toString()) {
      await LocalNotificationsService.instance.showChatNotification(
        title: '${event.notification!.title}',
        body: '${event.notification!.body}',
      );
    }
  });
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    customContext = context;

    return MaterialApp(
      title: 'RF Rider',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: CustomColors.primaryColor,
        textTheme: GoogleFonts.baloo2TextTheme(
          Theme.of(context).textTheme,
        ),
      ).copyWith(
        pageTransitionsTheme: const PageTransitionsTheme(
          builders: <TargetPlatform, PageTransitionsBuilder>{
            TargetPlatform.android: SharedAxisPageTransitionsBuilder(
                transitionType: SharedAxisTransitionType.horizontal),
          },
        ),
      ),
      home: const CustomTabBar(),
    );
  }
}
