import 'dart:convert';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:travel_plan/components/nav_bar.dart';
import 'package:travel_plan/screens/notification.dart';
import 'package:travel_plan/screens/onboarding.dart';
import 'package:travel_plan/styles/colors.dart';
import 'package:travel_plan/utils/const.dart';
import 'package:travel_plan/utils/firebase_options.dart';
import 'package:travel_plan/utils/push_notification.dart';

final navigatorKey = GlobalKey<NavigatorState>();

//function to listen to the background change
Future firebaseBackgroundMessage(RemoteMessage message) async {
  if (message.notification != null) {
    print("Some notification received");
  }
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  //On background notification tapped
  FirebaseMessaging.onMessageOpenedApp.listen(
    (RemoteMessage message) {
      if (message.notification != null) {
        print("Background Notification Tapped");
        navigatorKey.currentState!.pushNamed("/noti", arguments: message);
      }
    },
  );

  //add function noti
  PushNotidications.init();
  PushNotidications.localNotiInit();

  //Listen to background notifications
  FirebaseMessaging.onBackgroundMessage(firebaseBackgroundMessage);
// to handle foreground notifications
  FirebaseMessaging.onMessage.listen((RemoteMessage message) {
    String payloadData = jsonEncode(message.data);
    print("Got a message in foreground");
    if (message.notification != null) {
      PushNotidications.showSimpleNotification(
          title: message.notification!.title!,
          body: message.notification!.body!,
          payload: payloadData);
    }
  });
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    Constants.initialize(context);
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      navigatorKey: navigatorKey,
      theme: ThemeData(
        brightness: Brightness.light,
        primaryColor: AppColors.primaryColor_1,
        textTheme: GoogleFonts.interTextTheme(),
      ),
      routes: {
        '/': (context) => const OnboardingSreen(),
        '/isLogin': (context) => const NavBar(),
        '/noti': (context) => const NotificationScreen(),
      },
    );
  }
}
