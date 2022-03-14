import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import '../Screens/new_orders.dart';
import '../Widgets/text_widget.dart';
import '../utils/app_routes.dart';
import '../utils/config.dart';
import '../utils/dynamic_sizes.dart';
import 'order_screen.dart';

class SubmitOrder extends StatefulWidget {
  const SubmitOrder({Key? key}) : super(key: key);

  @override
  _SubmitOrderState createState() => _SubmitOrderState();
}

class _SubmitOrderState extends State<SubmitOrder> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: orderBottomBar(
        context,
        "Created Order",
        function: () => CustomRoutes().push(
          context,
          const OrderScreen(),
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          topBar(context, "Submit Order"),
          CustomSizes().heightBox(context, 0.04),
          text(context, "     What`s in it :Document", 0.045,
              CustomColors.customBlack,
              bold: true),
          text(context, "     Up to 5 kg, book a courier", 0.035,
              CustomColors.customLightBlack,
              bold: true),
          CustomSizes().heightBox(context, 0.02),
          text(context, "     Stated value : \$470", 0.035,
              CustomColors.customGrey,
              bold: true),
          Expanded(
            child: ListView.builder(
              padding: EdgeInsets.symmetric(
                  vertical: CustomSizes().dynamicHeight(context, 0.02)),
              shrinkWrap: true,
              itemCount: 5,
              itemBuilder: (BuildContext context, int index) {
                return orderCard(context, index, "", "");
              },
            ),
          )
        ],
      ),
    );
  }
}

Widget orderCard(context, index, text1, mobileNumber, {icon = false}) {
  return Container(
    margin: EdgeInsets.symmetric(
        vertical: CustomSizes().dynamicHeight(context, 0.01)),
    padding: EdgeInsets.symmetric(
        horizontal: CustomSizes().dynamicWidth(context, 0.05),
        vertical: CustomSizes().dynamicWidth(context, 0.05)),
    color: CustomColors.customGrey.withOpacity(0.2),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        CircleAvatar(
          radius: CustomSizes().dynamicWidth(context, 0.05),
          backgroundColor: CustomColors.customOrange,
          child: text(context, index, 0.045, CustomColors.customWhite),
        ),
        SizedBox(
          width: CustomSizes().dynamicWidth(context, 0.6),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              text(context, text1, 0.04, CustomColors.customLightBlack,
                  bold: true, maxLines: 5),
              CustomSizes().heightBox(context, 0.01),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      text(context, "Today till:11.30", 0.04,
                          CustomColors.customLightBlack,
                          bold: true),
                      text(context, mobileNumber, 0.04,
                          CustomColors.customLightBlack,
                          bold: true),
                    ],
                  ),
                  icon == true
                      ? GestureDetector(
                          onTap: () async {
                            await canLaunch("tel:$mobileNumber")
                                ? await launch("tel:$mobileNumber")
                                : throw 'Could not launch $mobileNumber';
                          },
                          child: const Icon(
                            Icons.phone,
                            color: CustomColors.customGreen,
                          ),
                        )
                      : Container(),
                ],
              ),
            ],
          ),
        ),
      ],
    ),
  );
}

Widget orderBottomBar(context, title, {function = ""}) {
  return Container(
    width: CustomSizes().dynamicWidth(context, 1),
    height: CustomSizes().dynamicHeight(context, 0.06),
    padding: EdgeInsets.symmetric(
        horizontal: CustomSizes().dynamicWidth(context, 0.05)),
    color: CustomColors.customLightBlack,
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        text(context, "\$1300", 0.038, CustomColors.customOrange, bold: true),
        InkWell(
          onTap: function == "" ? () {} : function,
          child: Row(children: [
            text(context, title, 0.038, CustomColors.customWhite, bold: true),
            Icon(Icons.arrow_forward_ios,
                size: CustomSizes().dynamicWidth(context, 0.035),
                color: CustomColors.customWhite),
          ]),
        )
      ],
    ),
  );
}
