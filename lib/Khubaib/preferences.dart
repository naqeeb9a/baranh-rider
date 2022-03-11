import 'package:baranh_rider/Khubaib/submit_order.dart';
import 'package:baranh_rider/Khubaib/track_order.dart';
import 'package:flutter/material.dart';

import '../Screens/new_orders.dart';
import '../Widgets/text_widget.dart';
import '../utils/app_routes.dart';
import '../utils/config.dart';
import '../utils/dynamic_sizes.dart';

class PreferencesScreen extends StatefulWidget {
  const PreferencesScreen({Key? key}) : super(key: key);

  @override
  _PreferencesScreenState createState() => _PreferencesScreenState();
}

int _groupValue = -1;

class _PreferencesScreenState extends State<PreferencesScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: orderBottomBar(
        context,
        "Created Order",
        function: () => CustomRoutes().push(
          context,
          const SubmitOrder(),
        ),
      ),
      body: Column(
        children: [
          topBar(context, "Preferences"),
          CustomSizes().heightBox(context, 0.05),
          preferencesWidget(
            context,
            "Pracel",
            true,
          ),
          CustomSizes().heightBox(context, 0.025),
          preferencesWidget(
            context,
            "Your Phone Number",
            false,
          ),
          CustomSizes().heightBox(context, 0.025),
          preferencesWidget(context, "Notify me By Sms", false, button: true),
          CustomSizes().heightBox(context, 0.025),
          preferencesWidget(context, "Notify Recepients By Sms", false,
              button: true),
          CustomSizes().heightBox(context, 0.025),
          ColoredBox(
            color: CustomColors.customWhite,
            child: myRadioButton(context, "Express Delivery", 1,
                (newValue) => setState(() => _groupValue = newValue),
                text1: true,
                subtitle:
                    "Express Delivery charges are differ than normal delivery charges"),
          ),
          Container(
            color: CustomColors.customGrey,
            padding: EdgeInsets.symmetric(
                horizontal: CustomSizes().dynamicWidth(context, 0.05),
                vertical: CustomSizes().dynamicHeight(context, 0.01)),
            child: Row(
              children: [
                const Icon(Icons.bookmark_outlined,
                    color: CustomColors.customOrange),
                text(context, "Promo Code", 0.04, CustomColors.customLightBlack,
                    bold: true),
                CustomSizes().widthBox(context, 0.5),
                text(context, "Apply", 0.035, CustomColors.customLightBlack),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(
                horizontal: CustomSizes().dynamicWidth(context, 0.05),
                vertical: CustomSizes().dynamicHeight(context, 0.01)),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                text(context, "Payment Mode", 0.04, CustomColors.customGrey,
                    bold: true),
                CustomSizes().heightBox(context, 0.025),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Icon(Icons.atm, color: CustomColors.customGrey),
                    text(context, "Online Payment", 0.04,
                        CustomColors.customLightBlack,
                        bold: true),
                    const Icon(Icons.circle_outlined,
                        color: CustomColors.customGrey)
                  ],
                ),
                CustomSizes().heightBox(context, 0.025),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Icon(Icons.money, color: CustomColors.customGrey),
                    text(context, "Cash", 0.04, CustomColors.customLightBlack,
                        bold: true),
                    const Icon(Icons.circle_outlined,
                        color: CustomColors.customGrey)
                  ],
                ),
                CustomSizes().heightBox(context, 0.025),
                text(context, "Where the Payment will occur", 0.04,
                    CustomColors.customGrey,
                    bold: true),
                CustomSizes().heightBox(context, 0.025),
                myRadioButton(
                    context,
                    "18C, Block D Block Q Gulberg 2, Lahore, Punjab",
                    2,
                    (newValue) => setState(() => _groupValue = newValue)),
                myRadioButton(
                    context,
                    "Address 73, 73 Street L, Block L Gulberg III, Lahore, Punjab",
                    3,
                    (newValue) => setState(() => _groupValue = newValue)),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

Widget preferencesWidget(context, text1, icon, {button = false}) {
  return ColoredBox(
    color: CustomColors.customWhite,
    child: Row(
      children: [
        Flexible(
          child: trackTextField(context, text1, border: false),
        ),
        CustomSizes().widthBox(context, .02),
        icon == true
            ? const Icon(
                Icons.question_mark_sharp,
                color: CustomColors.customOrange,
              )
            : button == true
                ? Switch(
                    activeColor: CustomColors.customOrange,
                    inactiveTrackColor: CustomColors.customGrey,
                    onChanged: (value) {},
                    value: true,
                  )
                : Container(),
        CustomSizes().widthBox(context, .04),
      ],
    ),
  );
}

Widget myRadioButton(context, title, value, onChanged,
    {text1 = false, subtitle}) {
  return RadioListTile(
    value: value,
    groupValue: _groupValue,
    onChanged: onChanged,
    title: text1 == false
        ? text(
            context,
            title,
            0.035,
            CustomColors.customBlack,
          )
        : text(context, title, 0.04, CustomColors.customBlack, bold: true),
    subtitle: text1 == true
        ? text(context, subtitle, 0.035, CustomColors.customGrey, bold: true)
        : null,
  );
}
