import 'package:flutter/material.dart';

import '../Screens/login.dart';
import '../Screens/registration.dart';
import '../Widgets/colorful_button.dart';
import '../utils/app_routes.dart';
import '../utils/config.dart';
import '../utils/dynamic_sizes.dart';
import 'change_password.dart';

class PersonalDetails extends StatefulWidget {
  final Map riderDetails;
  const PersonalDetails({Key? key, required this.riderDetails})
      : super(key: key);

  @override
  _PersonalDetailsState createState() => _PersonalDetailsState();
}

class _PersonalDetailsState extends State<PersonalDetails> {
  final TextEditingController _controller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppbar(
          context: context,
          text1: "Personal Details",
          automaticallyImplyLeading: true,
          backgroundColor: CustomColors.customYellow),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          CustomSizes().heightBox(context, 0.09),
          registerInputField(
              context, "Name", _controller, widget.riderDetails["full_name"],
              enable: false),
          registerInputField(
              context, "Type", _controller, widget.riderDetails["designation"],
              enable: false),
          registerInputField(
              context, "Role", _controller, widget.riderDetails["role"],
              enable: false),
          registerInputField(context, "Mobile number", _controller,
              widget.riderDetails["phone"],
              enable: false),
          registerInputField(context, "Email", _controller,
              widget.riderDetails["email_address"],
              enable: false),
          CustomSizes().heightBox(context, 0.05),
          InkWell(
            onTap: () => CustomRoutes().push(
              context,
              const ChangePassword(),
            ),
            child: Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: CustomSizes().dynamicWidth(context, 0.05)),
              child: Text(
                'Change your Password',
                style: TextStyle(
                  fontSize: CustomSizes().dynamicHeight(context, 0.015),
                  fontWeight: FontWeight.w700,
                  decoration: TextDecoration.underline,
                ),
              ),
            ),
          ),
          CustomSizes().heightBox(context, 0.05),
          Padding(
            padding: EdgeInsets.symmetric(
                horizontal: CustomSizes().dynamicWidth(context, 0.05)),
            child: colorfulButton(
                context,
                "Edit Profile",
                CustomColors.customYellow,
                CustomColors.customYellow,
                FontWeight.bold),
          ),
        ],
      ),
    );
  }
}
