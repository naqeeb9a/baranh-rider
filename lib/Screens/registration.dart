import 'package:baranh_rider/utils/constants.dart';
import 'package:flutter/material.dart';

import '../Widgets/colorful_button.dart';
import '../Widgets/text_widget.dart';
import '../utils/config.dart';
import '../utils/dynamic_sizes.dart';
import 'new_orders.dart';

class Registration extends StatefulWidget {
  const Registration({Key? key}) : super(key: key);

  @override
  State<Registration> createState() => _RegistrationState();
}

class _RegistrationState extends State<Registration> {
  final TextEditingController _email = TextEditingController();
  final TextEditingController _password = TextEditingController();
  final TextEditingController _firstname = TextEditingController();
  final TextEditingController _lastname = TextEditingController();
  final TextEditingController _mobile = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
      child: SizedBox(
        height: CustomSizes().dynamicHeight(context, 1),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            topBar(context, "Registration"),
            CustomSizes().heightBox(context, 0.05),
            Text(
              "      Let's Get Started",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: CustomSizes().dynamicWidth(context, 0.05),
              ),
            ),
            Text(
              "      Fill the form to Create your new account",
              style: TextStyle(
                color: Colors.grey,
                fontSize: CustomSizes().dynamicWidth(context, 0.03),
              ),
            ),
            CustomSizes().heightBox(context, 0.05),
            registerInputField(
                context, "First name", _firstname, "Enter your first name"),
            registerInputField(
                context, "Last name", _lastname, "Enter your last name"),
            registerInputField(context, "Email", _email, "Enter your email"),
            registerInputField(
                context, "Password", _password, "Enter your password",
                password: true),
            registerInputField(
                context, "Mobile number", _mobile, "Enter your mobile number"),
            CustomSizes().heightBox(context, 0.05),
            Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: CustomSizes().dynamicWidth(context, 0.05)),
              child: colorfulButton(
                  context,
                  "Register",
                  CustomColors.customOrange,
                  CustomColors.customOrange,
                  FontWeight.bold),
            ),
            CustomSizes().heightBox(context, 0.02),
            multiColorText(context, "By clicking Register I agree with ",
                "terms, Conditions and Agreements"),
            CustomSizes().heightBox(context, 0.02),
          ],
        ),
      ),
    ));
  }

  @override
  void dispose() {
    _email.dispose();
    _password.dispose();
    _mobile.dispose();
    _firstname.dispose();
    _lastname.dispose();

    super.dispose();
  }
}

Widget multiColorText(context, text, text1) {
  return Center(
    child: SizedBox(
      width: CustomSizes().dynamicWidth(context, 0.6),
      child: RichText(
        textAlign: TextAlign.center,
        text: TextSpan(
          children: [
            TextSpan(
                text: text,
                style: TextStyle(
                    color: Colors.black,
                    fontSize: CustomSizes().dynamicWidth(context, 0.025))),
            TextSpan(
                text: text1,
                style: TextStyle(
                    color: CustomColors.customOrange,
                    fontWeight: FontWeight.bold,
                    fontSize: CustomSizes().dynamicWidth(context, 0.025))),
          ],
        ),
      ),
    ),
  );
}

Widget registerInputField(
    context, text1, TextEditingController controller, hintText,
    {bool password = false, bool enable = true, passFunc = ""}) {
  return Column(
    mainAxisAlignment: MainAxisAlignment.start,
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Padding(
          padding:
              EdgeInsets.only(left: CustomSizes().dynamicWidth(context, 0.05)),
          child:
              text(context, text1, 0.03, CustomColors.customWhite, bold: true)),
      TextFormField(
        controller: controller,
        enabled: enable,
        obscureText: password == true ? obscureText : false,
        cursorColor: Colors.white,
        style: const TextStyle(color: CustomColors.customWhite),
        decoration: InputDecoration(
          hintText: hintText,
          hintStyle: const TextStyle(color: CustomColors.customWhite),
          suffixIcon: password == true
              ? InkWell(
                  onTap: passFunc == "" ? () {} : passFunc,
                  child: const Icon(
                    Icons.visibility_outlined,
                    color: CustomColors.customWhite,
                  ),
                )
              : null,
          focusedBorder: UnderlineInputBorder(
            borderSide: BorderSide(
              color: CustomColors.customOrange,
              width: CustomSizes().dynamicWidth(context, 0.0065),
            ),
          ),
          contentPadding: EdgeInsets.symmetric(
              horizontal: CustomSizes().dynamicWidth(context, 0.05)),
          enabledBorder: const UnderlineInputBorder(
            borderSide: BorderSide(
              color: CustomColors.customWhite,
            ),
          ),
        ),
      ),
      CustomSizes().heightBox(context, 0.01),
    ],
  );
}
