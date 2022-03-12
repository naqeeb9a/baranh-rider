import 'dart:convert';

import 'package:baranh_rider/Screens/registration.dart';
import 'package:baranh_rider/Screens/tab_bar.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../Widgets/text_widget.dart';
import '../backend/login_function.dart';
import '../utils/config.dart';
import '../utils/constants.dart';
import '../utils/dynamic_sizes.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> with SingleTickerProviderStateMixin {
  final RoundedLoadingButtonController _btnController =
      RoundedLoadingButtonController();
  late final AnimationController _controller;
  final TextEditingController _email = TextEditingController();
  final TextEditingController _password = TextEditingController();
  bool fieldEnable = true;

  @override
  void initState() {
    _controller =
        AnimationController(duration: const Duration(seconds: 10), vsync: this);
    super.initState();
    func();
  }

  func() {
    FirebaseMessaging.instance.getToken().then((value) {


      setState(() {
        fireBaseToken = value;
      });

      print("\n\n\ntoken ===>>>$fireBaseToken<<<");
      // FirebaseMessaging.instance.subscribeToTopic("rider");
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: CustomColors.customBlack,
      appBar: customAppbar(
          context: context,
          automaticallyImplyLeading: false,
          backgroundColor: CustomColors.customOrange,
          text1: "Login"),
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            children: [
              CustomSizes().heightBox(context, 0.1),
              LottieBuilder.asset(
                "assets/rider.json",
                controller: _controller,
                width: CustomSizes().dynamicWidth(context, 0.8),
              ),
              CustomSizes().heightBox(context, 0.1),
              registerInputField(context, "Email", _email, "Enter your email",
                  enable: fieldEnable),
              CustomSizes().heightBox(context, 0.03),
              registerInputField(
                  context, "Password", _password, "Enter your password",
                  password: true, enable: fieldEnable),
              CustomSizes().heightBox(context, 0.3),
              Padding(
                  padding: EdgeInsets.symmetric(
                      horizontal: CustomSizes().dynamicWidth(context, 0.05)),
                  child: loadingButton()),
            ],
          ),
        ),
      ),
    );
  }

  loadingButton() {
    return RoundedLoadingButton(
      color: CustomColors.customOrange,
      child: const Text('Sign in',
          style: TextStyle(color: CustomColors.customWhite)),
      controller: _btnController,
      onPressed: () async {
        _controller.forward();
        if (_email.text.isEmpty || _password.text.isEmpty) {
          _controller.reset();
          _btnController.reset();
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              content: text(context, "Email or password cannot be empty", 0.04,
                  CustomColors.customWhite)));
        } else if (!_email.text.contains("@")) {
          _controller.reset();
          _btnController.reset();
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              content: text(context, "Enter a valid email", 0.04,
                  CustomColors.customWhite)));
        } else {
          setState(() {
            fieldEnable = false;
          });

          var res =
              await UserAuthentication().loginUser(_email.text, _password.text);

          if (res == false) {
            _controller.reset();
            _btnController.reset();

            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                content: text(context, "Email or password incorrect", 0.04,
                    CustomColors.customWhite)));
            setState(() {
              fieldEnable = true;
            });
          } else {
            _btnController.reset();
            SharedPreferences userData = await SharedPreferences.getInstance();
            userData.setString("user", json.encode(res));
            Navigator.pushReplacement(context,
                MaterialPageRoute(builder: (context) => const CustomTabBar()));
            _controller.reset();
            setState(() {
              fieldEnable = true;
            });
          }
        }
      },
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    _email.dispose();
    _password.dispose();
    super.dispose();
  }
}

customAppbar(
    {required BuildContext context,
    required String text1,
    required bool automaticallyImplyLeading,
    required Color backgroundColor}) {
  return AppBar(
    automaticallyImplyLeading: automaticallyImplyLeading,
    backgroundColor: backgroundColor,
    centerTitle: true,
    title: text(context, text1, 0.04, CustomColors.customWhite),
  );
}
