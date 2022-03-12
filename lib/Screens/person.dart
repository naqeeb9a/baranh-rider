import 'dart:convert';
import 'package:baranh_rider/utils/config.dart';
import 'package:baranh_rider/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../Khubaib/help_center.dart';
import '../Khubaib/personal_detail.dart';
import '../Widgets/text_widget.dart';
import '../utils/app_routes.dart';
import '../utils/dynamic_sizes.dart';
import 'login.dart';
import 'new_orders.dart';

class Profile extends StatefulWidget {
  const Profile({Key? key}) : super(key: key);

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  bool isActive = false;
  Map riderData = {};
  getRiderInfo() async {
    SharedPreferences isRiderActive = await SharedPreferences.getInstance();
    SharedPreferences userData = await SharedPreferences.getInstance();

    if (isRiderActive.getBool("isActive") != null) {
      setState(() {
        userResponse = jsonDecode(userData.getString("user").toString());
        riderData = jsonDecode(userData.getString("user").toString());
        isActive = isRiderActive.getBool("isActive")!;
      });
    } else {
      setState(() {
        riderData = jsonDecode(userData.getString("user").toString());
        isActive = false;
      });
    }
  }

  @override
  void initState() {
    getRiderInfo();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: CustomColors.customBlack,
        appBar: customAppbar(
            context: context,
            text1: "Profile",
            automaticallyImplyLeading: false,
            backgroundColor: CustomColors.customOrange),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: CustomSizes().dynamicWidth(context, 0.05)),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CustomSizes().heightBox(context, 0.05),
                  ListTile(
                    title: text(
                        context,
                        riderData.isEmpty
                            ? "...."
                            : riderData["data"]["full_name"].toString(),
                        0.04,
                        CustomColors.customWhite),
                    trailing: text(
                        context,
                        riderData.isEmpty
                            ? "...."
                            : riderData["data"]["designation"].toString(),
                        0.04,
                        CustomColors.customWhite),
                  ),
                  CustomSizes().heightBox(context, 0.01),
                  Text(
                    riderData.isEmpty
                        ? "...."
                        : riderData["data"]["phone"].toString(),
                    style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        color: CustomColors.customWhite),
                  ),
                  CustomSizes().heightBox(context, 0.03),
                  const Text(
                    "Main",
                    style: TextStyle(
                        color: Colors.grey, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
            CustomSizes().heightBox(context, 0.02),
            cards(
              context,
              Icons.person,
              "Person Detail",
              true,
              check2: true,
              function: () => CustomRoutes().push(
                  context,
                  PersonalDetails(
                    riderDetails: riderData["data"],
                  )),
            ),
            CustomSizes().heightBox(context, 0.02),
            cards(
              context,
              Icons.privacy_tip,
              "Privacy Policy",
              true,
              check2: true,
            ),
            CustomSizes().heightBox(context, 0.02),
            cards(context, Icons.book, "Terms and Conditions", true,
                check2: true),
            CustomSizes().heightBox(context, 0.02),
            cards(
              context,
              Icons.contact_support,
              "Contact Us",
              true,
              check2: true,
              function: () =>
                  CustomRoutes().push(context, const HelpCenterScreen()),
            ),
            CustomSizes().heightBox(context, 0.02),
            cards(context, Icons.logout, "Logout", true, check2: true,
                function: () async {
              SharedPreferences userData =
                  await SharedPreferences.getInstance();
              userData.clear();
              Navigator.pushReplacement(context,
                  MaterialPageRoute(builder: (context) => const Login()));
            }),
          ],
        ));
  }
}
