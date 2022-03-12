import 'dart:convert';
import 'dart:developer';

import 'package:baranh_rider/Screens/person.dart';
import 'package:cool_alert/cool_alert.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_ringtone_player/flutter_ringtone_player.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../Khubaib/order_screen.dart';
import '../services/notification_service.dart';
import '../utils/config.dart';
import '../utils/dynamic_sizes.dart';
import 'login.dart';

class CustomTabBar extends StatefulWidget {
  const CustomTabBar({Key? key}) : super(key: key);

  @override
  _CustomTabBarState createState() => _CustomTabBarState();
}

class _CustomTabBarState extends State<CustomTabBar>
    with SingleTickerProviderStateMixin {
  TabController? _tabController;
  double iconSize = 0.05;
  bool _loading = true;
  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;

  @override
  void initState() {
    _firebaseMessaging.getToken().then((token) => log(token!));

    foregroundNotification();

    checkLoginStatus(
      context,
    );
    _tabController = TabController(length: 2, vsync: this);
    super.initState();
  }

  foregroundNotification() async {
    SharedPreferences userData = await SharedPreferences.getInstance();
    var riderData = jsonDecode(userData.getString("user").toString());

    FirebaseMessaging.onMessage.listen((RemoteMessage event) async {
      if (event.data["page"].toString() == riderData["data"]["id"].toString()) {
        await LocalNotificationsService.instance
            .showChatNotification(
          title: '${event.notification!.title}',
          body: '${event.notification!.body}',
        )
            .then((value) async {
          await FlutterRingtonePlayer.play(
            android: AndroidSounds.ringtone,
            ios: IosSounds.bell,
            looping: true,
            volume: 1.0,
            asAlarm: true,
          );

          return CoolAlert.show(
            context: context,
            title: '${event.notification!.title}',
            text: '${event.notification!.body}',
            type: CoolAlertType.info,
            confirmBtnText: "OK",
            backgroundColor: CustomColors.customOrange,
            barrierDismissible: false,
            showCancelBtn: false,
            confirmBtnColor: CustomColors.customOrange,
            lottieAsset: "assets/bell.json",
            confirmBtnTextStyle: TextStyle(
              fontSize: CustomSizes().dynamicWidth(context, .04),
              color: CustomColors.customWhite,
            ),
            onConfirmBtnTap: () {
              FlutterRingtonePlayer.stop();
              Navigator.of(context, rootNavigator: true).pop();
            },
          );
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return _loading == true
        ? const Scaffold(
            body: Center(child: CircularProgressIndicator.adaptive()))
        : Scaffold(
            body: DefaultTabController(
              length: 2,
              child: TabBarView(
                controller: _tabController,
                physics: const NeverScrollableScrollPhysics(),
                children: const [
                  OrderScreen(),
                  Profile(),
                ],
              ),
            ),
            bottomNavigationBar: Container(
              height: CustomSizes().dynamicHeight(context, 0.07),
              color: CustomColors.customBlack.withOpacity(.9),
              child: TabBar(
                indicatorSize: TabBarIndicatorSize.label,
                labelStyle: const TextStyle(color: CustomColors.customGrey),
                unselectedLabelColor: CustomColors.customWhite,
                unselectedLabelStyle:
                    const TextStyle(color: CustomColors.customGrey),
                controller: _tabController,
                labelColor: CustomColors.customOrange,
                indicatorColor: CustomColors.customOrange,
                tabs: const [
                  Tab(
                      text: "Order",
                      icon: Icon(
                        Icons.list,
                        color: CustomColors.customOrange,
                      )),
                  Tab(
                      text: "Profile",
                      icon: Icon(
                        Icons.person,
                        color: CustomColors.customOrange,
                      )),
                ],
              ),
            ),
          );
  }

  checkLoginStatus(
    BuildContext context,
  ) async {
    SharedPreferences userData = await SharedPreferences.getInstance();
    if (userData.getString("user") == null) {
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => const Login()));
    } else {
      setState(() {
        _loading = false;
      });
    }
  }
}
