

import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

import '../Screens/new_orders.dart';
import '../Widgets/colorful_button.dart';
import '../Widgets/text_widget.dart';
import '../utils/config.dart';
import '../utils/dynamic_sizes.dart';

class RatingScreen extends StatefulWidget {
  const RatingScreen({Key? key}) : super(key: key);

  @override
  _RatingScreenState createState() => _RatingScreenState();
}

class _RatingScreenState extends State<RatingScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          topBar(context, "Rating"),
          CustomSizes().heightBox(context, 0.05),
          personCard(context),
          Padding(
            padding: EdgeInsets.symmetric(
                horizontal: CustomSizes().dynamicWidth(context, 0.05)),
            child: Column(
              children: [
                CustomSizes().heightBox(context, 0.015),
                Divider(
                  thickness: CustomSizes().dynamicHeight(context, 0.001),
                ),
                CustomSizes().heightBox(context, 0.02),
                text(
                    context, "Rate Delivery Boy", 0.04, CustomColors.customGrey,
                    bold: true),
                CustomSizes().heightBox(context, 0.015),
                RatingBar.builder(
                  glow: false,
                  initialRating: 3,
                  minRating: 1,
                  direction: Axis.horizontal,
                  allowHalfRating: true,
                  itemCount: 5,
                  unratedColor: CustomColors.customGrey,
                  itemBuilder: (context, _) => const Icon(
                    Icons.star_rounded,
                    color: CustomColors.customYellow,
                  ),
                  onRatingUpdate: (rating) {},
                ),
                CustomSizes().heightBox(context, 0.09),
                colorfulButton(context, "Submit", CustomColors.customYellow,
                    CustomColors.customYellow, FontWeight.bold),
              ],
            ),
          )
        ],
      ),
    );
  }
}

Widget personCard(context,
    {name = "naqeeb",
    phone = "+92039458978",
    icon = false,
    marginline = false,
    phoneIcon = false,
    containerColor = true}) {
  return Container(
    padding: EdgeInsets.symmetric(
      // vertical: CustomSizes().dynamicHeight(context, 0),
      horizontal: CustomSizes().dynamicWidth(context, 0.05),
    ),
    width: CustomSizes().dynamicWidth(context, 1),
    height: CustomSizes().dynamicHeight(context, 0.1),
    margin: marginline == true
        ? EdgeInsets.symmetric(
            vertical: CustomSizes().dynamicHeight(context, 0.01))
        : EdgeInsets.symmetric(
            vertical: CustomSizes().dynamicHeight(context, 0)),
    color: containerColor == true
        ? CustomColors.customWhite
        : CustomColors.noColor,
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        icon == true
            ? Container(
                width: CustomSizes().dynamicWidth(context, 0.12),
                height: CustomSizes().dynamicHeight(context, 0.06),
                decoration: BoxDecoration(
                  border: Border.all(color: CustomColors.customYellow),
                  borderRadius: BorderRadius.circular(
                    CustomSizes().dynamicWidth(context, 0.025),
                  ),
                ),
                child: const Icon(
                  Icons.person,
                  color: CustomColors.customYellow,
                ))
            : Container(
                width: CustomSizes().dynamicWidth(context, 0.2),
                height: CustomSizes().dynamicHeight(context, 0.1),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(
                    CustomSizes().dynamicWidth(context, 0.025),
                  ),
                  image: const DecorationImage(
                      image: NetworkImage(
                          "https://images.pexels.com/photos/2379004/pexels-photo-2379004.jpeg?auto=compress&cs=tinysrgb&dpr=1&w=500"),
                      fit: BoxFit.fitWidth),
                ),
              ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            text(context, "    $name", 0.04, CustomColors.customBlack,
                bold: true),
            CustomSizes().heightBox(context, 0.02),
            text(context, "    $phone", 0.04, CustomColors.customBlack,
                bold: true)
          ],
        ),
        CustomSizes().widthBox(context, 0.3),
        phoneIcon == true
            ? const Icon(
                Icons.phone,
                color: CustomColors.customGreen,
              )
            : CustomSizes().widthBox(context, 0.1),
      ],
    ),
  );
}